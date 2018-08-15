//
//  GameLevel.h
//  Try_downStage
//
//  Created by irons on 2015/5/20.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef enum {
    GIRL = 0,
    BOY = 1
} SEX;

SEX PLAYER_SEX;

@interface GameLevelViewController : UIViewController{
//    SEX PLAYER_SEX;
}
- (IBAction)girlClick:(id)sender;
- (IBAction)boyClick:(id)sender;
- (IBAction)playClick:(id)sender;

+(int)PLAYER_SEX;

+(int)GIRL;

+(int)BOY;
@end
