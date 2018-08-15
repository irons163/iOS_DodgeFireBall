//
//  ToolUtil.m
//  Try_downStage
//
//  Created by irons on 2015/6/18.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import "ToolUtil.h"
#import "Footboard.h"
#import "BitmapUtil.h"

@implementation ToolUtil{
    int tool_width;
    SKTexture* bitmap;
    int _type;
    NSTimer* bombExplodeThread;
}

-(void)setToolUtilWithX:(float)x Y:(float)y type:(int) type{
    if(type==Footboard.BOMB){
        bitmap = ((BitmapUtil*)[BitmapUtil sharedInstance]).tool_bomb_bitmap;
    }else if(type==Footboard.BOMB_EXPLODE){
        bitmap = ((BitmapUtil*)[BitmapUtil sharedInstance]).tool_bomb_explosion_bitmap;
        
        if(bombExplodeThread!=nil){
            [bombExplodeThread invalidate];
        }
        
        self.isExploding=true;
        bombExplodeThread = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(bombExploding) userInfo:nil repeats:NO];
    }else{
        bitmap = ((BitmapUtil*)[BitmapUtil sharedInstance]).toll_cure_bitmap;
    }
    tool_width=30;
    float tool_x = x - tool_width/2;
    float tool_y = y;
    _type = type;
    self.texture = bitmap;
    self.size = CGSizeMake(tool_width, tool_width);
    self.position = CGPointMake(tool_x, tool_y);
    self.anchorPoint = CGPointMake(0, 0);
}

-(void)bombExploding{
    self.isExploding=false;
}

-(float)tool_x{
    return self.position.x;
}

-(int)tool_width{
    return tool_width;
}

@end
