//
//  Footboard.h
//  DodgeFireBall
//
//  Created by irons on 2015/7/2.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ToolUtil.h"

@interface Footboard : SKSpriteNode

+(Footboard*)FootboardCreateWithX:(float) x y:(float) y w:(float) width h:(float) height;

-(void) setCount;
-(int)which;
-(void) setWhich:(int) witch;
+(int)NOTOOL;

+(int)BOMB;

+(int)CURE;

+(int)BOMB_EXPLODE;

-(int)toolNum;
//
-(void)setToolNum:(int) num;

-(ToolUtil*)tool;
-(void)setTool:(ToolUtil*)toolUtil;

-(void)setIndex:(int)index;
-(int)getIndex;
@end
