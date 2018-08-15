//
//  Fireball.m
//  DodgeFireBall
//
//  Created by irons on 2015/10/22.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import "Fireball.h"

@implementation Fireball

-(void)randomType{
    int r = arc4random_uniform(3);
    [self setType:r];
}

-(void)setType:(FIREBALL_TYPE)type{
    switch (type) {
        case NORMAL:
            self.texture = [SKTexture textureWithImageNamed:@""];
            break;
        case FREZEN:
            self.texture = [SKTexture textureWithImageNamed:@""];
            break;
        case EARTH:
            self.texture = [SKTexture textureWithImageNamed:@""];
            break;
        default:
            break;
    }
}



@end
