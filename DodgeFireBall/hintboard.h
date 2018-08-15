//
//  hintboard.h
//  DodgeFireBall
//
//  Created by irons on 2015/10/22.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface hintboard : SKNode

@property NSMutableArray* arrayHints;

-(void)startRandom;

@end
