//
//  CommonUtil.m
//  Easy_Dodge
//
//  Created by irons on 2015/7/3.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import "CommonUtil.h"

@implementation CommonUtil

//+ (id)sharedInstance {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        instance = [self new];
//    });
//    return instance;
//}

+ (NSString *)timeFormatted:(int)totalSeconds
{
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
}

@end
