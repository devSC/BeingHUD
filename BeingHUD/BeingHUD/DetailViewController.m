//
//  DetailViewController.m
//  BeingHUD
//
//  Created by Wilson Yuan on 15/10/28.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "DetailViewController.h"
#import "UIViewController+HUD.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)Simpleindeterminteprogress:(id)sender {
    
    [self showHUDWithText:@"Ni hao.." deatailText:@"It's being"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
