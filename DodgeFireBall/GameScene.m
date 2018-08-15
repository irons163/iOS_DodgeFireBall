//
//  GameScene.m
//  DodgeFireBall
//
//  Created by irons on 2015/7/1.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import "GameScene.h"
#import "Footboard.h"
#import "CommonUtil.h"
#import "BitmapUtil.h"
#import "BrickMaxConfig.h"
#import "ToolUtil.h"
#import "MyADView.h"
#import "MyUtils.h"
#import "GameCenterUtil.h"
#import "Fireball.h"

#define DEFAULT_HP  20

int stay = 0;
int left = 1;
int right = 2;
int key = 0;

int moveDestance = 8;
int FOOTBOARD_SPEED = 3;

static const int SMOOTH_DEVIATION = 1;

const static int PLAYER_STAY_LEFT_INDEX = 0;
const static int PLAYER_STAY_RIGHT_INDEX = 1;
const static int PLAYER_LEFT_WALK01_INDEX = 2;
const static int PLAYER_LEFT_WALK02_INDEX = 3;
const static int PLAYER_LEFT_WALK03_INDEX = 4;
const static int PLAYER_RIGHT_WALK01_INDEX = 5;
const static int PLAYER_RIGHT_WALK02_INDEX = 6;
const static int PLAYER_RIGHT_WALK03_INDEX = 7 ;
const static int PLAYER_LEFT_INJURE_INDEX = 8;
const static int PLAYER_RIGHT_INJURE_INDEX = 9;

int backgroundLayerZPosition = -3;



float DOWNSPEED = 20;
float SLIDERSPEED;

@implementation GameScene{
    int walkCount;
    
    SKSpriteNode * player;
//    SKSpriteNode * fireball;
    SKSpriteNode * leftKey;
    SKSpriteNode * rightKey;
    
    NSMutableArray * playerTextures;
    NSMutableArray * fireballs;
    NSMutableArray * footbardsByLines;
    
    NSTimer * theGameTimer;
    
    bool isGameRun;
    int gameTime;
    float fireballInterval;
    SKLabelNode * gameTImeLabel;
    
    CGSize playerSize;
    
    SKSpriteNode * redNode;
    ToolUtil* toolExplodingUtil;
    
    int catMaxHp;
    int catCurrentHp;
    
    int isStandOnFootboard;
    
    int distance;
    
    MyADView * myAdView;
    SKSpriteNode * rankBtn;
    
    NSMutableArray * musicBtnTextures;
    
    SKSpriteNode * musicBtn;
}

-(void) handler:(int)what {
    
    if (what == 0) {
        isGameRun = false;
        
        int maxLevel = [[NSUserDefaults standardUserDefaults] integerForKey:@"level"];
        if (maxLevel < 2) {
            int lv = maxLevel + 1;
            [[NSUserDefaults standardUserDefaults] setInteger:lv forKey:@"level"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }

//        [self.gameDelegate showWinDialog];
        
        [self.gameDelegate showLoseDialog:gameTime];
        
        GameCenterUtil * gameCenterUtil = [GameCenterUtil sharedInstance];
        [gameCenterUtil reportScore:distance forCategory:@"com.irons.HappySpeedUp"];
//        [self.gameDelegate showGameOver];
        [myAdView close];

//        if (!gameSuccess) {
//            [self submitScore];
//        } else {
//            int maxLevel = [[NSUserDefaults standardUserDefaults] integerForKey:@"level"];
//            if (maxLevel < 2) {
//                int lv = maxLevel + 1;
//                [[NSUserDefaults standardUserDefaults] setInteger:lv forKey:@"level"];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//            }
//            
//            [self.gameDelegate showWinDialog];
//        }
    }else{
//        [self submitScore];
    }
}

-(void)setViewRun:(bool)isrun{
    isGameRun = isrun;
    
    for (int i = 0; i < [self children].count; i++) {
        SKNode * n = [self children][i];
        n.paused = !isrun;
    }
}

-(void)initGameTimeTextLabel{
    gameTImeLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    //        clearedMonsterLabel.position = CGPointMake(CGRectGetMidX(self.frame),
    //                                                   CGRectGetMidY(self.frame));
    gameTImeLabel.text = @"00:00:00";
    gameTImeLabel.fontSize = 20;
    gameTImeLabel.color = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
    gameTImeLabel.position = CGPointMake(gameTImeLabel.frame.size.width/2, self.frame.size.height - 100 - gameTImeLabel.frame.size.height);
    
    [self addChild:gameTImeLabel];
}

-(void)initPlayerTexture{
    playerTextures = [NSMutableArray array];
    
    playerTextures[PLAYER_STAY_LEFT_INDEX] = [SKTexture textureWithImageNamed:@"player_girl_left02"];
    playerTextures[PLAYER_STAY_RIGHT_INDEX] = [SKTexture textureWithImageNamed:@"player_girl_right02"];
    playerTextures[PLAYER_LEFT_WALK01_INDEX] = [SKTexture textureWithImageNamed:@"player_girl_left01"];
    playerTextures[PLAYER_LEFT_WALK02_INDEX] = [SKTexture textureWithImageNamed:@"player_girl_left02"];
    playerTextures[PLAYER_LEFT_WALK03_INDEX] = [SKTexture textureWithImageNamed:@"player_girl_left03"];
    playerTextures[PLAYER_RIGHT_WALK01_INDEX] = [SKTexture textureWithImageNamed:@"player_girl_right01"];
    playerTextures[PLAYER_RIGHT_WALK02_INDEX] = [SKTexture textureWithImageNamed:@"player_girl_right02"];
    playerTextures[PLAYER_RIGHT_WALK03_INDEX] = [SKTexture textureWithImageNamed:@"player_girl_right03"];
    playerTextures[PLAYER_LEFT_INJURE_INDEX] = [SKTexture textureWithImageNamed:@"player_girl_injure_left"];
    playerTextures[PLAYER_RIGHT_INJURE_INDEX] = [SKTexture textureWithImageNamed:@"player_girl_injure_right"];
    
    playerSize = ((SKTexture*)playerTextures[0]).size;
    playerSize = CGSizeMake(playerSize.width/2.5f, playerSize.height/2.5f);
}

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    isGameRun = true;
    catMaxHp = DEFAULT_HP;
    catCurrentHp = DEFAULT_HP;
    
    isStandOnFootboard = true;
    
    [BitmapUtil sharedInstance];
    
    [self initPlayerTexture];
    [self initGameTimeTextLabel];
    
    SLIDERSPEED = FOOTBOARD_SPEED/2.5f;
    
    fireballs = [NSMutableArray array];
    footbardsByLines = [NSMutableArray array];
    
    leftKey = [SKSpriteNode spriteNodeWithImageNamed:@"left_keyboard_btn"];
    leftKey.size = CGSizeMake(50, 50);
//    leftKey.position = CGPointMake(100, 150);
    leftKey.position = CGPointMake(0, 0);
    leftKey.anchorPoint = CGPointMake(0, 0);
    
    rightKey = [SKSpriteNode spriteNodeWithImageNamed:@"right_keyboard_btn"];
    rightKey.size = CGSizeMake(50, 50);
//    rightKey.position = CGPointMake(150, 150);
    rightKey.position = CGPointMake(self.frame.size.width - rightKey.size.width, 0);
    rightKey.anchorPoint = CGPointMake(0, 0);
    
    player = [SKSpriteNode spriteNodeWithTexture:playerTextures[PLAYER_STAY_LEFT_INDEX]];
//    player.size = CGSizeMake(80, 80);
    player.size = playerSize;
    player.position = CGPointMake(150, 280);
    player.anchorPoint = CGPointMake(0, 0);
    
    [self addChild:leftKey];
    [self addChild:rightKey];
    [self addChild:player];
    
    SKSpriteNode * hpFrame = [SKSpriteNode spriteNodeWithImageNamed:@"hp_frame"];
    
    self.hpBar = [SKSpriteNode spriteNodeWithImageNamed:@"hp_bar"];
    
    self.hpBar.zPosition = backgroundLayerZPosition;
    
    hpFrame.size = CGSizeMake(self.frame.size.width, 42);
    
    hpFrame.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMaxY(self.frame) - hpFrame.size.height/2 - 45);
    
    hpFrame.zPosition = backgroundLayerZPosition;
    
    [self changeCatHpBar];
    
    [self addChild:hpFrame];
    
    [self addChild:self.hpBar];
    
    [self createFootboard];
    
    redNode = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:self.frame.size];
    redNode.anchorPoint = CGPointMake(0, 0);
    redNode.hidden = YES;
    [self addChild:redNode];
    
    rankBtn = [SKSpriteNode spriteNodeWithImageNamed:@"btnL_GameCenter-hd"];
    rankBtn.size = CGSizeMake(42,42);
    rankBtn.anchorPoint = CGPointMake(0, 0);
    rankBtn.position = CGPointMake(self.frame.size.width - rankBtn.size.width, self.frame.size.height/2);
    rankBtn.zPosition = 1;
    [self addChild:rankBtn];
    
    musicBtnTextures = [NSMutableArray array];
    [musicBtnTextures addObject:[SKTexture textureWithImageNamed:@"btn_Music-hd"]];
    [musicBtnTextures addObject:[SKTexture textureWithImageNamed:@"btn_Music_Select-hd"]];
    
    
    musicBtn = [SKSpriteNode spriteNodeWithImageNamed:@"btn_Music-hd"];
    musicBtn.size = CGSizeMake(42,42);
    musicBtn.anchorPoint = CGPointMake(0, 0);
    musicBtn.position = CGPointMake(self.frame.size.width - musicBtn.size.width, self.frame.size.height/2 - 42);
    musicBtn.zPosition = 1;
    [self addChild:musicBtn];
    
    NSArray* musics = [NSArray arrayWithObjects:@"am_white.mp3", @"biai.mp3", @"cafe.mp3", @"deformation.mp3", nil];
    
    int index = arc4random_uniform(4);
    [MyUtils preparePlayBackgroundMusic:musics[index]];
    
    id isPlayMusicObject = [[NSUserDefaults standardUserDefaults] objectForKey:@"isPlayMusic"];
    BOOL isPlayMusic = true;
    if(isPlayMusicObject==nil){
        isPlayMusicObject = false;
    }else{
        isPlayMusic = [isPlayMusicObject boolValue];
    }
    if(isPlayMusic){
        [MyUtils backgroundMusicPlayerPlay];
        musicBtn.texture = musicBtnTextures[0];
    }else{
        [MyUtils backgroundMusicPlayerPause];
        musicBtn.texture = musicBtnTextures[1];
    }
    
    myAdView = [MyADView spriteNodeWithTexture:nil];
    myAdView.size = CGSizeMake(self.frame.size.width, self.frame.size.width/5.0f);
    //        myAdView.position = CGPointMake(self.frame.size.width/2, self.frame.size.height - 35);
    myAdView.position = CGPointMake(self.frame.size.width/2, 0);
    [myAdView startAd];
    myAdView.zPosition = 1;
    myAdView.anchorPoint = CGPointMake(0.5, 0);
    [self addChild:myAdView];
}

-(void)changeCatHpBar {
    float hpBarWidth = self.frame.size.width/((float)catMaxHp/catCurrentHp);
    
    self.hpBar.size = CGSizeMake(hpBarWidth, 42);
    
    self.hpBar.anchorPoint = CGPointMake(0.5, 0.5);
    
    float hpBarOffsetX = self.frame.size.width/10 - hpBarWidth/10;
    
    self.hpBar.position = CGPointMake(CGRectGetMinX(self.frame) + hpBarWidth/2 + hpBarOffsetX,
                                      CGRectGetMaxY(self.frame) - self.hpBar.size.height/2 - 45);
}

-(void)initGameTimer{
    
    theGameTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                    target:self
                                                  selector:@selector(countGameTime)
                                                  userInfo:nil
                                                   repeats:YES];
    //    [timers addObject:theGameTimer];
}

-(void)countGameTime{
    //    if(gameTime>3600){
    ////        theGameTimerLabel.text = @"";
    //        [theGameTimer invalidate];
    //        return;
    //    }
    
    if(!isGameRun){
        return;
    }
    
    gameTime++;
    
    if(gameTime==60){
        fireballInterval = 0.6;
    }else if(gameTime==120){
        fireballInterval = 0.5;
    }else if(gameTime==180){
        fireballInterval = 0.4;
    }else if(gameTime==240){
        fireballInterval = 0.3;
    }
    
    [self setGameTimeNodeText];
}

-(void)setGameTimeNodeText{
    NSString * s = [CommonUtil timeFormatted:gameTime];
    
    gameTImeLabel.text = s;
    gameTImeLabel.position = CGPointMake(gameTImeLabel.frame.size.width/2, self.frame.size.height - 100 - gameTImeLabel.frame.size.height);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        [myAdView touchesBegan:touches withEvent:event];
        
        if(CGRectContainsPoint(leftKey.calculateAccumulatedFrame, location)){
            key = left;
            
        }else if(CGRectContainsPoint(rightKey.calculateAccumulatedFrame, location)){
            key = right;
        }if(CGRectContainsPoint(rankBtn.calculateAccumulatedFrame, location)){
            //        rankBtn.texture = storeBtnClickTextureArray[PRESSED_TEXTURE_INDEX];
            
            [self.gameDelegate showRankView];
        }else if(CGRectContainsPoint(musicBtn.calculateAccumulatedFrame, location)){
            if([MyUtils isBackgroundMusicPlayerPlaying]){
                [MyUtils backgroundMusicPlayerPause];
                musicBtn.texture = musicBtnTextures[1];
                [[NSUserDefaults standardUserDefaults] setBool:false forKey:@"isPlayMusic"];
            }else{
                [MyUtils backgroundMusicPlayerPlay];
                musicBtn.texture = musicBtnTextures[0];
                [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"isPlayMusic"];
            }
        }

    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if(key == left){
        player.texture = playerTextures[PLAYER_STAY_LEFT_INDEX];
    }else if(key == right){
        player.texture = playerTextures[PLAYER_STAY_RIGHT_INDEX];
    }
    
    key = stay;
}

-(void)beHited{
    [self.gameDelegate showLoseDialog:gameTime];
}

-(void)checkPlayerMovedTexture:(int)key{
    if(key == left){
        if(player.position.x -moveDestance < 0){
            player.position = CGPointMake(0, player.position.y);
        }else{
            player.position = CGPointMake(player.position.x - moveDestance, player.position.y);
        }
        
        SKTexture * bitmap;
        if(walkCount%2==0){
            bitmap = playerTextures[PLAYER_LEFT_WALK02_INDEX];
        }else if(walkCount%3==0){
            bitmap = playerTextures[PLAYER_LEFT_WALK01_INDEX];
        }else{
            bitmap = playerTextures[PLAYER_LEFT_WALK03_INDEX];
        }
        player.texture = bitmap;
        walkCount++;
//        key = stay;
    }else if(key == right){
        if(player.position.x + moveDestance > self.frame.size.width - player.size.width){
            player.position = CGPointMake(self.frame.size.width - player.size.width, player.position.y);
        }else{
            player.position = CGPointMake(player.position.x + moveDestance, player.position.y);
        }
        
        SKTexture * bitmap;
        if(walkCount%2==0){
            bitmap = playerTextures[PLAYER_RIGHT_WALK02_INDEX];
        }else if(walkCount%3==0){
            bitmap = playerTextures[PLAYER_RIGHT_WALK01_INDEX];
        }else{
            bitmap = playerTextures[PLAYER_RIGHT_WALK03_INDEX];
        }
        player.texture = bitmap;
        walkCount++;
//        key = stay;
    }
}

-(void)createFootboard{
    NSMutableArray * footbardsLine;
    footbardsLine = [NSMutableArray array];
    NSMutableArray * tmpfootbardsLine;
    tmpfootbardsLine = [NSMutableArray array];
    NSMutableArray * tmpfootbardsLineIndex;
    tmpfootbardsLineIndex = [NSMutableArray array];
    
    BrickMaxConfig* brickMaxConfig = [BrickMaxConfig sharedInstance];
    [brickMaxConfig setBrickMaxConfigEnable:true PlayGameLevel:1];
    
    for(int i = 0; i < 6; i++){
        
//    for (int j = 0; j<5; j++) {
    
        int k;
        
        do{
            k = arc4random_uniform(5);
        }while([tmpfootbardsLineIndex containsObject:[NSNumber numberWithInt:k]]);
        
        if ([brickMaxConfig isBrickMaxConfigEnable]
            && [brickMaxConfig isBrickOverMin:i]){
            continue;
        }
        
        Footboard* footboard = [Footboard FootboardCreateWithX:k*(self.frame.size.width / 5.0f) y:0 w:self.frame.size.width / 5.0f h:30];
        [footboard setWhich:i];
        footboard.anchorPoint = CGPointMake(0, 1);
        
        [self addChild:footboard];
//        [footbardsLine addObject:footboard];
//        [footbardsLine setObject:footboard atIndexedSubscript:k];
        [tmpfootbardsLine addObject:footboard];
        [tmpfootbardsLineIndex addObject:[NSNumber numberWithInt:k]];
    }
        
        
//    }
    
//    for(int i = 0 ; i < 5; i++){
//        [brickMaxConfig ];
//        
//        Footboard* footboard = [Footboard FootboardCreateWithX:i*(self.frame.size.width / 5.0f) y:0 w:self.frame.size.width / 5.0f h:30];
//        footboard.anchorPoint = CGPointMake(0, 1);
//        
//        if ([brickMaxConfig isBrickMaxConfigEnable]
//            && [brickMaxConfig isBrickOverMin:footboard.which]){
//            continue;
//        }
//    }
    
    int limit = tmpfootbardsLineIndex.count;
    for(int i = 0 ; i < 5 - limit; i++){
//        Footboard* footboard = [Footboard spriteNodeWithImageNamed:@"check_btn"];
//        footboard.size = CGSizeMake(self.frame.size.width / 5.0f, 30);
//        footboard.position = CGPointMake(i*footboard.size.width, 0);
       
        
        if(tmpfootbardsLineIndex.count == 5){
            break;
        }
        
        int k;
        
        do{
            k = arc4random_uniform(5);
        }while([tmpfootbardsLineIndex containsObject:[NSNumber numberWithInt:k]]);
        
//        if([tmpfootbardsLineIndex containsObject:[NSNumber numberWithInt:i]]){
//            continue;
//        }
        
        Footboard* footboard = [Footboard FootboardCreateWithX:k*(self.frame.size.width / 5.0f) y:0 w:self.frame.size.width / 5.0f h:30];
        footboard.anchorPoint = CGPointMake(0, 1);
        
        if ([brickMaxConfig isBrickMaxConfigEnable]
            && [brickMaxConfig isBrickOverMax:footboard.which]){
            i--;
            continue;
        }
        
        [self addChild:footboard];
        [tmpfootbardsLine addObject:footboard];
        [tmpfootbardsLineIndex addObject:[NSNumber numberWithInt:k]];
    }
    
    int newIndex = 0;
    for(int i = footbardsByLines.count-1; i >= 0; i--){
        int previousIndex = 0;
        for(Footboard* footboead in footbardsByLines[i]){
            if(footboead){
                previousIndex = [footboead getIndex];
                break;
            }
        }
        int increase = footbardsByLines.count -i;
        
        newIndex = increase + previousIndex;
    }
    
    for(int i = 0; i < tmpfootbardsLine.count; i++){
        NSInteger index = ((NSInteger)[tmpfootbardsLineIndex indexOfObject:[NSNumber numberWithInt:i]]);
        [tmpfootbardsLine[index] setIndex:newIndex];
        [footbardsLine addObject:tmpfootbardsLine[index]];
    }
    
    [footbardsByLines addObject:footbardsLine];
    
    [brickMaxConfig reset];
}

-(void)moveFootboard{
    for (NSMutableArray * footbardsLine in footbardsByLines) {
        for (Footboard * footboard in footbardsLine) {
            footboard.position = CGPointMake(footboard.position.x, footboard.position.y + FOOTBOARD_SPEED);
            if(footboard.which == 1 || footboard.which == 2){
                [footboard setCount];
            }
        }
    }
}

-(void)clearFootboard{
    NSMutableArray* fireballsWillClear = [NSMutableArray array];
    NSMutableArray* deleteLineArray = [NSMutableArray array];
    for (NSMutableArray * footbardsLine in footbardsByLines) {
        NSMutableArray* deleteArray = [NSMutableArray array];
        for (Footboard * footboard in footbardsLine) {
            if(footboard.position.y > self.frame.size.height){
//                foot clear;
                [footboard removeFromParent];
                [footboard.tool removeFromParent];
                [deleteArray addObject:footboard];
            }else{
                for (Fireball* fireball in fireballs) {
                    if(CGRectIntersectsRect(fireball.calculateAccumulatedFrame, footboard.calculateAccumulatedFrame)){
//                        footboard.clear
                        
                        
                        
                        
                        switch (fireball.type){
                            case NORMAL:
                                [footboard removeFromParent];
                                [deleteArray addObject:footboard];
                                [footboard.tool removeFromParent];
                                [fireballsWillClear addObject:fireball];
                                break;
                            case FREZEN:
//                                [footboard removeFromParent];
//                                [deleteArray addObject:footboard];
                                [footboard.tool removeFromParent];
                                [fireballsWillClear addObject:fireball];
                                
                                footbardsLine ice;
                                break;
                            case EARTH:
                                //                                [footboard removeFromParent];
                                //                                [deleteArray addObject:footboard];
                                [footboard.tool removeFromParent];
                                [fireballsWillClear addObject:fireball];
                            
                                footbardsLine.
                                break;
                            
                        }
                        break;
                    }
                }
            }
        }
        
        [footbardsLine removeObjectsInArray:deleteArray];
        if(footbardsLine.count==0){
            [deleteLineArray addObject:footbardsLine];
        }
    }
    [footbardsByLines removeObjectsInArray:deleteLineArray];
    
    [self clearFireballAfterHitFootboard:fireballsWillClear];
}

-(void)clearFireballAfterHitFootboard:(NSMutableArray*)fireballWillClear{
    for (SKSpriteNode* fireball in fireballWillClear) {
        [fireball removeFromParent];
        [fireballs removeObject:fireball];
    }
    [fireballWillClear removeAllObjects];
}

-(void)clearFireball{
    for (SKSpriteNode* fireball in fireballs) {
        [fireball removeFromParent];
        [fireballs removeObject:fireball];
    }
}

-(void)checkFootboard{
    for (NSMutableArray * footbardsLine in footbardsByLines) {
    for (Footboard * footboard in footbardsLine) {
        ToolUtil* toolUtil = footboard.tool;
        if (!toolUtil) {
            
            if (footboard.toolNum == Footboard.NOTOOL) {
                toolUtil = nil;
            } else if (footboard.toolNum == Footboard.BOMB) {
                toolUtil = [ToolUtil spriteNodeWithTexture:nil];
                [toolUtil setToolUtilWithX:footboard.position.x + footboard.size.width/2 Y:footboard.position.y type:Footboard.BOMB];
                //					toolUtil.draw(canvas, SPEED);
                toolUtil.anchorPoint = CGPointZero;
            } else if (footboard.toolNum == Footboard.BOMB_EXPLODE) {
                
            } else {
                toolUtil = [ToolUtil spriteNodeWithTexture:nil];
                [toolUtil setToolUtilWithX:footboard.position.x + footboard.size.width/2 Y:footboard.position.y type:Footboard.CURE];
                //					toolUtil.draw(canvas, SPEED);
                toolUtil.anchorPoint = CGPointZero;
            }
            
            if(toolUtil!=nil){
                footboard.tool = toolUtil;
                toolUtil.zPosition = 1;
                [self addChild:toolUtil];
            }
            
        }
        
        if(footboard.toolNum == Footboard.BOMB_EXPLODE && toolExplodingUtil!=nil){
            if(toolExplodingUtil.isExploding){
                toolUtil = nil;
                [toolUtil removeFromParent];
                [self checkPlayerInjure];
//                isInjure = false;
//                [toolExplodingUtil draw:SPEED];
            }else{
                [toolExplodingUtil removeFromParent];
                toolExplodingUtil = nil;
                footboard.toolNum = Footboard.NOTOOL;
                footboard.tool = nil;
                [footboard.tool removeFromParent];
            }
        }
    }
    }
}
                 
-(void)checkPlayerInjure{
    if(key == left){
        player.texture = playerTextures[PLAYER_LEFT_INJURE_INDEX];
    }else{
        player.texture = playerTextures[PLAYER_LEFT_INJURE_INDEX];
    }
}

-(void)checkTool{
    
}

-(void)setIndexScore:(int)index{
    gameTImeLabel.text = [NSString stringWithFormat:@"%d",index];
}

- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast {
    self.lastSpawnTimeInterval += timeSinceLast;
    self.lastSpawnMoveTimeInterval += timeSinceLast;
    self.lastSpawnCreateFootboardTimeInterval += timeSinceLast;
    self.lastSpawnCreateForeballTimeInterval += timeSinceLast;
    
    redNode.hidden = true;
    
    if (self.lastSpawnTimeInterval > 0.1) {
        self.lastSpawnTimeInterval = 0;
        
        for(int i = 0; i < fireballs.count; i++){
            SKSpriteNode * fireballForCheck = fireballs[i];
            if(CGRectContainsRect(fireballForCheck.calculateAccumulatedFrame, player.calculateAccumulatedFrame)){
                [self beHited];
            }
        }
        
        isStandOnFootboard = false;
        Footboard* standedFootboard = nil;
        
        for (NSMutableArray * footbardsLine in footbardsByLines) {
            for (Footboard * footboard in footbardsLine) {
                CGRect p = player.calculateAccumulatedFrame;
                CGRect f = footboard.calculateAccumulatedFrame;
//                if(CGRectIntersectsRect(player.calculateAccumulatedFrame, footboard.calculateAccumulatedFrame)){
//                    isStandOnFootboard = true;
//                    standedFootboard = footboard;
//                }
                float SMOOTH_DEVIATION = 1;
                float footboardWidth = footboard.frame.size.width;
                bool b1 = footboard.position.x < player.position.x + player.size.width - SMOOTH_DEVIATION*4;
                bool b2 = footboard.position.x + footboardWidth > player.position.x + SMOOTH_DEVIATION*4;
                bool b3 = footboard.position.y <= player.position.y +1;
                bool b4 = footboard.position.y > player.position.y
                 - DOWNSPEED - FOOTBOARD_SPEED;
                if(b1
                && b2
                &&
                (
                 b3 &&
                 b4)){
                    
                    isStandOnFootboard = true;
                    standedFootboard = footboard;
                    [self setIndexScore:[standedFootboard getIndex]];
                    break;
                }
            }
        }
        
        [self moveFootboard];
        
        if(isStandOnFootboard){
//            [self checkPlayerMoved];
            player.position = CGPointMake(player.position.x, standedFootboard.position.y);
        }else{
            player.position = CGPointMake(player.position.x, player.position.y-DOWNSPEED);
        }
        
        if(standedFootboard){
            ToolUtil* toolUtil = standedFootboard.tool;
            if (toolUtil != nil
                && (toolUtil.tool_x < player.position.x + player.size.width -SMOOTH_DEVIATION*4)
                && (toolUtil.tool_x + toolUtil.tool_width > player.position.x +SMOOTH_DEVIATION*4)
                && standedFootboard.toolNum != Footboard.BOMB_EXPLODE) {
                if (standedFootboard.toolNum == Footboard.BOMB) {
//                    isInjure = true;
                    standedFootboard.toolNum = Footboard.BOMB_EXPLODE;
                    standedFootboard.tool = nil;
                    [toolUtil removeFromParent];
                    standedFootboard.tool = toolExplodingUtil = [ToolUtil spriteNodeWithTexture:nil];
                    [toolExplodingUtil setToolUtilWithX:standedFootboard.position.x + standedFootboard.size.width/2 Y:standedFootboard.position.y type:Footboard.BOMB_EXPLODE];
                    [self addChild:toolExplodingUtil];
                    catCurrentHp--;
                    [self changeCatHpBar];
                    redNode.hidden = false;
                } else if (standedFootboard.toolNum == Footboard.CURE){
                    catCurrentHp++;
                    [self changeCatHpBar];
                    standedFootboard.toolNum = Footboard.NOTOOL;
                    standedFootboard.tool = nil;
                    [toolUtil removeFromParent];
                }
                
            }

            if(standedFootboard.which==1){
                if(player.position.x + -SLIDERSPEED < 0){
                    player.position = CGPointMake(0, player.position.y);
                }else{
                    player.position = CGPointMake(player.position.x + -SLIDERSPEED, player.position.y);
                    [standedFootboard setCount];
                }
                
            }else if(standedFootboard.which==2){
                if(player.position.x + SLIDERSPEED > self.frame.size.width - player.size.width){
                    player.position = CGPointMake(self.frame.size.width - player.size.width, player.position.y);
                }else{
                    player.position = CGPointMake(player.position.x + SLIDERSPEED, player.position.y);
                    [standedFootboard setCount];
                }
                
            }else if(standedFootboard.which==5){
                catCurrentHp--;
                [self changeCatHpBar];
                redNode.hidden = false;
                [self checkPlayerInjure];
                standedFootboard.texture=nil;
            }else{
                [standedFootboard setCount];
            }
            
            if(standedFootboard.texture==nil){
                for (NSMutableArray * footbardsLine in footbardsByLines) {
                    if ([footbardsLine containsObject:standedFootboard]) {
                        [footbardsLine removeObject:standedFootboard];
                        [standedFootboard removeFromParent];
                        [standedFootboard.tool removeFromParent];
                        break;
                    }
                }
            }
            
        }
        
        [self checkPlayerMovedTexture:key];
        
        if (catCurrentHp == 0 || player.position.y + player.size.height < 0) {
            redNode.hidden = false;
            
            isGameRun = false;
//            if(!isGameFinish){
//                isGameFinish = true;
                [self handler:0];
//            }
        }
    }
    
    if (self.lastSpawnMoveTimeInterval > 0.1) {
        self.lastSpawnMoveTimeInterval = 0;
        
        
        [self clearFootboard];
    }
    
    if(self.lastSpawnCreateFootboardTimeInterval > 3.0){
        self.lastSpawnCreateFootboardTimeInterval = 0;
        
        [self createFootboard];
        [self checkFootboard];
    }
    
    if(self.lastSpawnCreateForeballTimeInterval > 2.5){
        self.lastSpawnCreateForeballTimeInterval = 0;
        
        Fireball * fireball = [Fireball spriteNodeWithImageNamed:@"fireball"];
        fireball.size = CGSizeMake(50, 50);
        int x = arc4random_uniform(self.frame.size.width - fireball.size.width);
        fireball.anchorPoint = CGPointMake(0, 0);
        fireball.position = CGPointMake(x, self.frame.size.height);
        
        [self addChild:fireball];
        [fireballs addObject:fireball];
        
        SKAction * move = [SKAction moveToY:0 duration:1.5];
        SKAction * end = [SKAction runBlock:^{
            [fireball removeFromParent];
            [fireballs removeObject:fireball];
        }];
        
        [fireball runAction:[SKAction sequence:@[move, end]]];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    if(!isGameRun)
        return;
    /* Called before each frame is rendered */
    // 获取时间增量
    // 如果我们运行的每秒帧数低于60，我们依然希望一切和每秒60帧移动的位移相同
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
    self.lastUpdateTimeInterval = currentTime;
    if (timeSinceLast > 1) { // 如果上次更新后得时间增量大于1秒
        timeSinceLast = 1.0 / 60.0;
        self.lastUpdateTimeInterval = currentTime;
    }
    
    [self updateWithTimeSinceLastUpdate:timeSinceLast];
    
}

@end
