//
//  GameLevel.m
//  Try_downStage
//
//  Created by irons on 2015/5/20.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import "GameLevelViewController.h"
#import "GameViewController.h"

@implementation GameLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)girlClick:(id)sender {
    PLAYER_SEX = GIRL;
}

- (IBAction)boyClick:(id)sender {
    PLAYER_SEX = BOY;
}

- (IBAction)playClick:(id)sender {
    GameViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"GameViewController"];
//    winDialogViewController.gameDelegate = self;
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController presentViewController:viewController animated:YES completion:^{
        //        [reset];
    }];
}

+(int)PLAYER_SEX{
    return PLAYER_SEX;
}

+(int)GIRL{
    return GIRL;
}

+(int)BOY{
    return BOY;
}

@end
