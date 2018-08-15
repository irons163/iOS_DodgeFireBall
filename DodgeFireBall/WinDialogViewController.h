//
//  WinDialogViewController.h
//  Try_downStage
//
//  Created by irons on 2015/6/24.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameViewController.h"

@interface WinDialogViewController : UIViewController

@property (weak) id<gameDelegate> gameDelegate;
@property int level;
@property (strong, nonatomic) IBOutlet UIButton *goToMenuBtn;
@property (strong, nonatomic) IBOutlet UIButton *goToNextLevel;

- (IBAction)goToMenuClick:(id)sender;
- (IBAction)goToNextLevelClick:(id)sender;

@end
