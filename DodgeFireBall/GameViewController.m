//
//  GameViewController.m
//  DodgeFireBall
//
//  Created by irons on 2015/7/1.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"
#import "GameCenterUtil.h"
#import "WinDialogViewController.h"
#import "GameOverViewController.h"
#import "GameCenterUtil.h"

@implementation SKScene (Unarchive)

+ (instancetype)unarchiveFromFile:(NSString *)file {
    /* Retrieve scene file path from the application bundle */
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
    /* Unarchive the file to an SKScene object */
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:self forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];
    
    return scene;
}

@end

@implementation GameViewController{
    ADBannerView * adBannerView;
    WinDialogViewController * winDialogViewController;
    GameScene *scene;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    
    [self initAndaddScene:skView];
    
    adBannerView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, -50, 200, 30)];
    adBannerView.delegate = self;
    adBannerView.alpha = 1.0f;
    [self.view addSubview:adBannerView];
    
    GameCenterUtil * gameCenterUtil = [GameCenterUtil sharedInstance];
    gameCenterUtil.delegate = self;
    [gameCenterUtil isGameCenterAvailable];
    [gameCenterUtil authenticateLocalUser:self];
    [gameCenterUtil submitAllSavedScores];
}

-(void)initAndaddScene:(SKView*)skView{
    // Create and configure the scene.
    scene = [GameScene unarchiveFromFile:@"GameScene"];
    scene.size = self.view.frame.size;
    scene.scaleMode = SKSceneScaleModeAspectFill;
    scene.gameDelegate = self;
    
    // Present the scene.
    [skView presentScene:scene];
}

-(void) showRankView{
    GameCenterUtil * gameCenterUtil = [GameCenterUtil sharedInstance];
    gameCenterUtil.delegate = self;
    [gameCenterUtil isGameCenterAvailable];
    //    [gameCenterUtil authenticateLocalUser:self];
    [gameCenterUtil showGameCenter:self];
    [gameCenterUtil submitAllSavedScores];
}

-(void)showWinDialog{
    winDialogViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WinDialogViewController"];
    winDialogViewController.gameDelegate = self;
    
    //    gameOverDialogViewController.gameLevelTensDigitalLabel = time;
    
    //    winDialogViewController.gameLevel = gameLevel;
    
    //    [self.navigationController popToViewController:gameOverDialogViewController animated:YES];
    
    //    [self.delegate BviewcontrollerDidTapButton:self];
    
    self.navigationController.providesPresentationContextTransitionStyle = YES;
    self.navigationController.definesPresentationContext = YES;
    [winDialogViewController setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    
    
    /* //before ios8
     self.navigationController.modalPresentationStyle = UIModalPresentationCurrentContext;
     */
    
    //    [self.navigationController presentViewController:winDialogViewController animated:YES completion:^{
    //        //        [reset];
    //    }];
    
    winDialogViewController.view.backgroundColor = [UIColor blackColor];
    winDialogViewController.view.backgroundColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.5];
    //    winDialogViewController.view.alpha = 0.5;
    //    [self.navigationController pushViewController:winDialogViewController animated:YES];
    [self.navigationController presentViewController:winDialogViewController animated:YES completion:nil];
    
//    if (level == 2) {
        //        winDialogViewController.goToNextLevel.rank_level;
//    }
}

-(void)showLoseDialog:(int)score{
    GameOverViewController* gameOverViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"GameOverViewController"];
    gameOverViewController.gameDelegate = self;
    gameOverViewController.gameTime = score;
    
    self.providesPresentationContextTransitionStyle = YES;
    self.definesPresentationContext = YES;
    [gameOverViewController setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    
    [self.navigationController presentViewController:gameOverViewController animated:YES completion:^{
        //        [reset];
    }];
}

-(void)showGameOver{
    
}

-(void)restartGame{
    SKView * skView = (SKView *)self.view;
    [self initAndaddScene:skView];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    [self layoutAnimated:true];
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    //    [adBannerView removeFromSuperview];
    //    adBannerView.delegate = nil;
    //    adBannerView = nil;
    [self layoutAnimated:true];
}

-(BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave{
    //    [MyScene setAllGameRun:NO];
    return true;
}

- (void)layoutAnimated:(BOOL)animated
{
    //    CGRect contentFrame = self.view.bounds;
    
    CGRect contentFrame = self.view.bounds;
    //    contentFrame.origin.y = -50;
    CGRect bannerFrame = adBannerView.frame;
    if (adBannerView.bannerLoaded)
    {
        //        contentFrame.size.height -= adBannerView.frame.size.height;
        contentFrame.size.height = 0;
        bannerFrame.origin.y = contentFrame.size.height;
    } else {
        //        bannerFrame.origin.y = contentFrame.size.height;
        bannerFrame.origin.y = -50;
    }
    
    [UIView animateWithDuration:animated ? 0.25 : 0.0 animations:^{
        adBannerView.frame = contentFrame;
        [adBannerView layoutIfNeeded];
        adBannerView.frame = bannerFrame;
    }];
}

@end
