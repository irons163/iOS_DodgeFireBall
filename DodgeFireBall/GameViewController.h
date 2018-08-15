//
//  GameViewController.h
//  DodgeFireBall
//

//  Copyright (c) 2015年 irons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
@import iAd;

@protocol gameDelegate <NSObject>

- (void)showWinDialog;
//-(void)showGameOver;
- (void)showLoseDialog:(int)score;
-(void)restartGame;
-(void)showRankView;

@end

@protocol pauseGameDelegate <NSObject>
- (void)pauseGame;
@end

@interface GameViewController : UIViewController<gameDelegate, ADBannerViewDelegate>

@end
