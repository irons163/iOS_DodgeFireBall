//
//  BrickMaxConfig.m
//  Try_HitBrick
//
//  Created by irons on 2015/5/22.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import "BrickMaxConfig.h"

@implementation BrickMaxConfig{
//    int* bricksMax;
}

//static int LV2_Brick_Twice_MAX = 6;
//static int LV2_Brick_Tool_MAX = 7;
//static int LV2_Brick_BallLevelUP_MAX = 5;
//
//static int LV3_Brick_Three_MAX = 4;
//static int LV3_Brick_Iron_MAX = 2;
//static int LV3_Brick_Tool_MAX = 5;
//static int LV3_Brick_BallLevelUP_MAX = 5;
//
//static int LV4_Brick_Twice_MAX = 3;
//static int LV4_Brick_Three_MAX = 3;
//static int LV4_Brick_Time_MAX = 3;
//static int LV4_Brick_Tool_MAX = 4;
//static int LV4_Brick_BallLevelUP_MAX = 3;
//
//static int LV5_Brick_Twice_MAX = 3;
//static int LV5_Brick_Three_MAX = 3;
//static int LV5_Brick_Iron_MAX = 2;
//static int LV5_Brick_Time_MAX = 2;
//static int LV5_Brick_Tool_MAX = 3;
//static int LV5_Brick_BallLevelUP_MAX = 3;

static int Brick_Once_MAX;
static int Brick_Twice_MAX;
static int Brick_Three_MAX;
static int Brick_Iron_MAX;
static int Brick_Time_MAX;
static int Brick_Tool_MAX;
static int Brick_BallLevelUP_MAX;

static int bricksMax[6];
static int bricksMin[6];

//static bool brickMaxConfigEnable = false;

// private int

static BrickMaxConfig* instance;

-(id)init{
    if(self = [super init]){
        [self initMAXMIN];
    }
    return self;
}

-(void)initMAXMIN{
    /// way 1
    //        static const int data[] = {1, 2, 3, 4, 5};
    //
    //        bricksMax = malloc(sizeof(data));
    //        memcpy(bricksMax, data, sizeof(data));
    
    /// way 2
    //        bricksMax = malloc(sizeof(int)*5);
    //        memcpy(bricksMax, (int[]){1,2,3,4,5}, sizeof(int)*5);
    //
    //        bricksMax[0] = 1;
    //        bricksMax[1] = 2;
    
    
    //bricksMax = {1,2,3};
    //        bricksMax[0] = 1;
    //        bricksMax[1] = 2;
    
    self.Spike_MAX = 1;
    self.Wood_MAX = 1;
    self.Unstable_MAX = 1;
    self.left_slide_MAX = 2;
    self.ritght_slide_MAX = 2;
    self.normal_MAX = 2;
    
    self.Spike_MIN = 1;
    self.Wood_MIN = 1;
    self.Unstable_MIN = 1;
    self.left_slide_MIN = 0;
    self.ritght_slide_MIN = 0;
    self.normal_MIN = 0;
    
    self.LV2_Brick_Twice_MAX = 6;
    self.LV2_Brick_Tool_MAX = 7;
    self.LV2_Brick_BallLevelUP_MAX = 5;
    
    self.LV3_Brick_Three_MAX = 4;
    self.LV3_Brick_Iron_MAX = 2;
    self.LV3_Brick_Tool_MAX = 5;
    self.LV3_Brick_BallLevelUP_MAX = 5;
    
    self.LV4_Brick_Twice_MAX = 3;
    self.LV4_Brick_Three_MAX = 3;
    self.LV4_Brick_Time_MAX = 3;
    self.LV4_Brick_Tool_MAX = 4;
    self.LV4_Brick_BallLevelUP_MAX = 3;
    
    self.LV5_Brick_Twice_MAX = 3;
    self.LV5_Brick_Three_MAX = 3;
    self.LV5_Brick_Iron_MAX = 2;
    self.LV5_Brick_Time_MAX = 2;
    self.LV5_Brick_Tool_MAX = 3;
    self.LV5_Brick_BallLevelUP_MAX = 3;
    
    self.brickMaxConfigEnable = false;
}

+ (id)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

-(void) setBrickMaxConfigEnable:(bool) brickMaxConfigEnable PlayGameLevel:(int) playGameLevel {
    self.brickMaxConfigEnable = brickMaxConfigEnable;
    if (playGameLevel == 0)
        self.brickMaxConfigEnable = false;
    [self setBrickMaxBy:playGameLevel];
}

-(void) setBrickMaxBy:(int) playGameLevel {
    switch (playGameLevel) {
		case 1:
			Brick_Twice_MAX = self.LV2_Brick_Twice_MAX;
			Brick_Tool_MAX = self.LV2_Brick_Tool_MAX;
			Brick_BallLevelUP_MAX = self.LV2_Brick_BallLevelUP_MAX;
			break;
		case 2:
			Brick_Three_MAX = self.LV3_Brick_Three_MAX;
			Brick_Iron_MAX = self.LV3_Brick_Iron_MAX;
			Brick_Tool_MAX = self.LV3_Brick_Tool_MAX;
			Brick_BallLevelUP_MAX = self.LV3_Brick_BallLevelUP_MAX;
			break;
		case 3:
			Brick_Twice_MAX = self.LV4_Brick_Twice_MAX;
			Brick_Three_MAX = self.LV4_Brick_Three_MAX;
			Brick_Time_MAX = self.LV4_Brick_Time_MAX;
			Brick_Tool_MAX = self.LV4_Brick_Tool_MAX;
			Brick_BallLevelUP_MAX = self.LV4_Brick_BallLevelUP_MAX;
			break;
		case 4:
			Brick_Twice_MAX = self.LV5_Brick_Twice_MAX;
			Brick_Three_MAX = self.LV5_Brick_Three_MAX;
			Brick_Iron_MAX = self.LV5_Brick_Iron_MAX;
			Brick_Time_MAX = self.LV5_Brick_Time_MAX;
			Brick_Tool_MAX = self.LV5_Brick_Tool_MAX;
			Brick_BallLevelUP_MAX = self.LV5_Brick_BallLevelUP_MAX;
			break;
    }
    
//    bricksMax[0] = Brick_Once_MAX;
//    bricksMax[1] = Brick_Twice_MAX;
//    bricksMax[2] = Brick_Three_MAX;
//    bricksMax[3] = Brick_Iron_MAX;
//    bricksMax[4] = Brick_Time_MAX;
//    bricksMax[5] = Brick_Tool_MAX;
//    bricksMax[6] = Brick_BallLevelUP_MAX;
    
    bricksMax[0] = self.normal_MAX;
    bricksMax[1] = self.left_slide_MAX;
    bricksMax[2] = self.ritght_slide_MAX;
    bricksMax[3] = self.Unstable_MAX;
    bricksMax[4] = self.Wood_MAX;
    bricksMax[5] = self.Spike_MAX;
    
    bricksMin[0] = self.normal_MIN;
    bricksMin[1] = self.left_slide_MIN;
    bricksMin[2] = self.ritght_slide_MIN;
    bricksMin[3] = self.Unstable_MIN;
    bricksMin[4] = self.Wood_MIN;
    bricksMin[5] = self.Spike_MIN;
    
//    bricksMax = { Brick_Once_MAX, Brick_Twice_MAX,
//        Brick_Three_MAX, Brick_Iron_MAX, Brick_Time_MAX,
//        Brick_Tool_MAX, Brick_BallLevelUP_MAX };
}

-(void)reset{
    [self initMAXMIN];
    [self setBrickMaxBy:1];
}

-(bool) isBrickOverMin:(int) whichBrickType {
    bool isBrickOverMin = false;
    if(bricksMin[whichBrickType]-1 <0){
        isBrickOverMin = true;
    }else{
        bricksMin[whichBrickType] = bricksMin[whichBrickType]-1;
        bricksMax[whichBrickType] = bricksMax[whichBrickType]-1;
    }
    return isBrickOverMin;
}

-(bool) isBrickOverMax:(int) whichBrickType {
    bool isBrickOverMax = false;
    if(bricksMax[whichBrickType]-1 <0){
        isBrickOverMax = true;
    }else{
        bricksMin[whichBrickType] = bricksMin[whichBrickType]-1;
        bricksMax[whichBrickType] = bricksMax[whichBrickType]-1;
    }
    return isBrickOverMax;
}

-(BOOL)isBrickAllArriveMin{
    bool isBrickAllArriveMin = true;
    for(int i = 0; i < 6; i++){
        if (bricksMin[i] > 0) {
            isBrickAllArriveMin = false;
        }
    }
    return isBrickAllArriveMin;
}

-(bool) isBrickMaxConfigEnable {
    return self.brickMaxConfigEnable;
}

@end
