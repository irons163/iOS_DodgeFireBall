//
//  hintboard.m
//  DodgeFireBall
//
//  Created by irons on 2015/10/22.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import "hintboard.h"
#import "Fireball.h"

@implementation hintboard

+(instancetype)createHintBoader{
    hintboard* node = [hintboard new];
    [node startRandom];
    
    return node;
}

-(void)startRandom{
    NSMutableArray* arr = [NSMutableArray array];
    if(self.arrayHints.count < 3){
        int r = arc4random_uniform(3);
        FIREBALL_TYPE type = r;
        Fireball * newFireball = [Fireball spriteNodeWithTexture:nil];
        newFireball.type = type;
        [arr addObject:newFireball];
    }
    
    [self.arrayHints addObjectsFromArray:arr];
}

-(void)get{
    
}

@end
