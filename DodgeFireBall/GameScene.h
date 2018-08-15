//
//  GameScene.h
//  DodgeFireBall
//

//  Copyright (c) 2015年 irons. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameViewController.h"

@interface GameScene : SKScene

@property (weak) id<gameDelegate> gameDelegate;
@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) NSTimeInterval lastSpawnMoveTimeInterval;
@property (nonatomic) NSTimeInterval lastSpawnCreateFootboardTimeInterval;
@property (nonatomic) NSTimeInterval lastSpawnCreateForeballTimeInterval;

@property (nonatomic) SKSpriteNode * hpBar;

@end
