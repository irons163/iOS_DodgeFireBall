//
//  ToolUtil.h
//  Try_downStage
//
//  Created by irons on 2015/6/18.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ToolUtil : SKSpriteNode

@property bool isExploding;

-(void)setToolUtilWithX:(float)x Y:(float)y type:(int) type;
-(void)draw:(float) dy;

-(float)tool_x;
-(int)tool_width;

@end
