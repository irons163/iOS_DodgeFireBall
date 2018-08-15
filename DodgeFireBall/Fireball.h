//
//  Fireball.h
//  DodgeFireBall
//
//  Created by irons on 2015/10/22.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef enum{
    NORMAL = 0,
    FREZEN,
    EARTH,
    
}FIREBALL_TYPE;

@interface Fireball : SKSpriteNode

@property (nonatomic) FIREBALL_TYPE type;

-(void)randomType;

@end
