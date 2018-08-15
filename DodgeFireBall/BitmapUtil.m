//
//  BitmapUtil.m
//  Try_downStage
//
//  Created by irons on 2015/5/20.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import "BitmapUtil.h"

@implementation BitmapUtil

static BitmapUtil* instance;

-(id)init{
    if(self = [super init]){
        self.PLAYER_WIDTH_PERSENT = 2.5;
        self.TOOL_WIDTH_PERSENT = 4;
        self.FIREBALL_WIDTH_PERSENT = 3;
        
        self.sreenWidth = 300.0;
        self.sreenHeight = 600.0;
        
//        int footbarWidth = self.sreenWidth / MyScene.FOOTBOARD_WIDTH_PERSENT;
//        int playerWidth = footbarWidth / self.PLAYER_WIDTH_PERSENT;
//        int toolWidth = footbarWidth / self.TOOL_WIDTH_PERSENT;
//        int fireballWidth = footbarWidth / self.FIREBALL_WIDTH_PERSENT;
//        
//        self.player_girl_left01_bitmap = [SKTexture textureWithImageNamed:@"player_girl_left01"];
//        self.player_girl_left02_bitmap = [SKTexture textureWithImageNamed:@"player_girl_left02"];
//        self.player_girl_left03_bitmap = [SKTexture textureWithImageNamed:@"player_girl_left03"];
//        self.player_girl_right01_bitmap = [SKTexture textureWithImageNamed:@"player_girl_right01"];
//        self.player_girl_right02_bitmap = [SKTexture textureWithImageNamed:@"player_girl_right02"];
//        self.player_girl_right03_bitmap = [SKTexture textureWithImageNamed:@"player_girl_right03"];
//        
//        self.player_girl_injure_left_bitmap = [SKTexture textureWithImageNamed:@"player_girl_injure_left"];
//        self.player_girl_injure_right_bitmap = [SKTexture textureWithImageNamed:@"player_girl_injure_right"];
//        self.player_girl_down_left_bitmap = [SKTexture textureWithImageNamed:@"player_girl_down_left"];
//        self.player_girl_down_right_bitmap = [SKTexture textureWithImageNamed:@"player_girl_down_right"];
//        
//        int x = self.player_girl_left01_bitmap.size.height;
//        
//     
//        self.player_girl_left01_size = CGSizeMake(playerWidth, (int)((float)self.player_girl_left01_bitmap.size.height/ self.player_girl_left01_bitmap.size.width * playerWidth));
//        
//        self.player_girl_left02_size = CGSizeMake(playerWidth, (int)((float)self.player_girl_left02_bitmap.size.height/ self.player_girl_left02_bitmap.size.width * playerWidth));
//        
//        self.player_girl_left03_size = CGSizeMake(playerWidth, (int)((float)self.player_girl_left03_bitmap.size.height/ self.player_girl_left03_bitmap.size.width * playerWidth));
//        
//        self.player_girl_right01_size = CGSizeMake(playerWidth, (int)((float)self.player_girl_right01_bitmap.size.height/ self.player_girl_right01_bitmap.size.width * playerWidth));
//        
//        self.player_girl_right02_size = CGSizeMake(playerWidth, (int)((float)self.player_girl_right02_bitmap.size.height/ self.player_girl_right02_bitmap.size.width * playerWidth));
//        
//        self.player_girl_right03_size = CGSizeMake(playerWidth, (int)((float)self.player_girl_right03_bitmap.size.height/ self.player_girl_right03_bitmap.size.width * playerWidth));
//        
//        self.player_girl_injure_left_size = CGSizeMake(playerWidth, (int)((float)self.player_girl_injure_left_bitmap.size.height/ self.player_girl_injure_left_bitmap.size.width * playerWidth));
//        
//        self.player_girl_injure_right_size = CGSizeMake(playerWidth, (int)((float)self.player_girl_injure_right_bitmap.size.height/ self.player_girl_injure_right_bitmap.size.width * playerWidth));
//        
//        self.player_girl_down_left_size = CGSizeMake(playerWidth, (int)((float)self.player_girl_down_left_bitmap.size.height/ self.player_girl_down_left_bitmap.size.width * playerWidth));
//        
//        self.player_girl_down_right_size = CGSizeMake(playerWidth, (int)((float)self.player_girl_down_right_bitmap.size.height/ self.player_girl_down_right_bitmap.size.width * playerWidth));
//        
//        
//        self.player_boy_left01_bitmap = [SKTexture textureWithImageNamed:@"player_boy_walk01"];
//        self.player_boy_left03_bitmap = [SKTexture textureWithImageNamed:@"player_boy_walk03"];
//        self.player_boy_left02_bitmap = [SKTexture textureWithImageNamed:@"player_boy_walk02"];
//        self.player_boy_right01_bitmap = [SKTexture textureWithImageNamed:@"player_boy_right01"];
//        self.player_boy_right02_bitmap = [SKTexture textureWithImageNamed:@"player_boy_right02"];
//        self.player_boy_right03_bitmap = [SKTexture textureWithImageNamed:@"player_boy_right03"];
//        self.player_boy_injure_left_bitmap = [SKTexture textureWithImageNamed:@"player_boy_injure_left"];
//        self.player_boy_injure_right_bitmap = [SKTexture textureWithImageNamed:@"player_boy_injure_right"];
//        self.player_boy_down_left_bitmap = [SKTexture textureWithImageNamed:@"player_boy_down_left"];
//        self.player_boy_down_right_bitmap = [SKTexture textureWithImageNamed:@"player_boy_down_right"];
//        
//        
//        self.player_boy_left01_size = CGSizeMake(playerWidth, (int)((float)self.player_boy_left01_bitmap.size.height/ self.player_boy_left01_bitmap.size.width * playerWidth));
//
//        self.player_boy_left03_size = CGSizeMake(playerWidth, (int)((float)self.player_boy_left03_bitmap.size.height/ self.player_boy_left03_bitmap.size.width * playerWidth));
//        
//        self.player_boy_left02_size = CGSizeMake(playerWidth, (int)((float)self.player_boy_left02_bitmap.size.height/ self.player_boy_left02_bitmap.size.width * playerWidth));
//        
//        self.player_boy_right01_size = CGSizeMake(playerWidth, (int)((float)self.player_boy_right01_bitmap.size.height/ self.player_boy_right01_bitmap.size.width * playerWidth));
//        
//        self.player_boy_right02_size = CGSizeMake(playerWidth, (int)((float)self.player_boy_right02_bitmap.size.height/ self.player_boy_right02_bitmap.size.width * playerWidth));
//        
//        self.player_boy_right03_size = CGSizeMake(playerWidth, (int)((float)self.player_boy_right03_bitmap.size.height/ self.player_boy_right03_bitmap.size.width * playerWidth));
//        
//        self.player_boy_injure_left_size = CGSizeMake(playerWidth, (int)((float)self.player_boy_injure_left_bitmap.size.height/ self.player_boy_injure_left_bitmap.size.width * playerWidth));
//        
//        self.player_boy_down_left_size = CGSizeMake(playerWidth, (int)((float)self.player_boy_down_left_bitmap.size.height/ self.player_boy_down_left_bitmap.size.width * playerWidth));
//        
//        self.player_boy_down_right_size = CGSizeMake(playerWidth, (int)((float)self.player_boy_down_right_bitmap.size.height/ self.player_boy_down_right_bitmap.size.width * playerWidth));
//        
//        self.player_boy_injure_right_size = CGSizeMake(playerWidth, (int)((float)self.player_boy_injure_right_bitmap.size.height/ self.player_boy_injure_right_bitmap.size.width * playerWidth));
        
        // 普通地板
        self.footboard_normal_bitmap = [SKTexture textureWithImageNamed:@"footboard_normal"];
        
        // 往左地板
        self.footboard_moving_left1_bitmap = [SKTexture textureWithImageNamed:@"footboard_moving_left1"];
        
        self.footboard_moving_left2_bitmap = [SKTexture textureWithImageNamed:@"footboard_moving_left2"];
        
        self.footboard_moving_left3_bitmap = [SKTexture textureWithImageNamed:@"footboard_moving_left3"];
        
        // bitmap = bitmap1;
        // 往右地板
        self.footboard_moving_right1_bitmap = [SKTexture textureWithImageNamed:@"footboard_moving_right1"];
        
        self.footboard_moving_right2_bitmap = [SKTexture textureWithImageNamed:@"footboard_moving_right2"];
        
        self.footboard_moving_right3_bitmap = [SKTexture textureWithImageNamed:@"footboard_moving_right3"];
        
        // 不穩定地板
        self.footboard_unstable1_bitmap = [SKTexture textureWithImageNamed:@"footboard_unstable1"];
        
        self.footboard_unstable2_bitmap = [SKTexture textureWithImageNamed:@"footboard_unstable2"];
        
        self.footboard_unstable3_bitmap = [SKTexture textureWithImageNamed:@"footboard_unstable3"];
        
        // bitmap = bitmap1;
        // 滑動地板
        self.footboard_spring_bitmap = [SKTexture textureWithImageNamed:@"footboard_spring"];
        // 陷阱地板
        self.footboard_spiked_bitmap = [SKTexture textureWithImageNamed:@"footboard_spiked"];
        
        self.tool_bomb_bitmap = [SKTexture textureWithImageNamed:@"bomb"];
        
        self.tool_bomb_explosion_bitmap = [SKTexture textureWithImageNamed:@"bomb_explosion"];
        
        self.toll_cure_bitmap = [SKTexture textureWithImageNamed:@"cure"];
        
        //		tool_bomb_bitmap = Bitmap.createBitmap(
        //				tool_bomb_bitmap, 0, 0, toolWidth,
        //				(int)((float)tool_bomb_bitmap.getHeight()
        //						/ tool_bomb_bitmap.getWidth() * toolWidth));
        //		tool_bomb_explosion_bitmap = Bitmap.createBitmap(
        //				tool_bomb_explosion_bitmap, 0, 0, toolWidth,
        //				(int)((float)tool_bomb_explosion_bitmap.getHeight()
        //						/ tool_bomb_explosion_bitmap.getWidth() * toolWidth));
        //		toll_cure_bitmap = Bitmap.createBitmap(
        //				toll_cure_bitmap, 0, 0, toolWidth,
        //				(int)((float)toll_cure_bitmap.getHeight()
        //						/ toll_cure_bitmap.getWidth() * toolWidth));
        
        self.tool_bomb_bitmap = [SKTexture textureWithImageNamed:@"bomb"];
        
        self.tool_bomb_explosion_bitmap = [SKTexture textureWithImageNamed:@"bomb_explosion"];
        
        self.toll_cure_bitmap = [SKTexture textureWithImageNamed:@"cure"];
        
        self.footboard_wood_bitmap = [SKTexture textureWithImageNamed:@"footboard_wood"];
       
        self.footboard_wood2_bitmap = [SKTexture textureWithImageNamed:@"footboard_wood2"];
        
        self.footboard_wood3_bitmap = [SKTexture textureWithImageNamed:@"footboard_wood3"];
        
        self.fire_ball = [SKTexture textureWithImageNamed:@"fireball"];
        
        //		fire_ball = Bitmap.createBitmap(
        //				fire_ball, 0, 0, fireballWidth,
        //				(int)((float)fire_ball.getHeight()
        //						/ fire_ball.getWidth() * fireballWidth));
        
//        self.fire_ball_size = CGSizeMake(fireballWidth, (int)((float)self.fire_ball.size.height/ self.fire_ball.size.height * fireballWidth));
    }
    return self;
}

+ (id)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}



@end
