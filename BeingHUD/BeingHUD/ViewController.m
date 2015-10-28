//
//  ViewController.m
//  BeingHUD
//
//  Created by Wilson Yuan on 15/10/28.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+HUD.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.view.layer.cornerRadius

}
- (IBAction)simpleProgress:(id)sender {
    [self showHUD];
    [self hideHUDAfterDelay:2];
}
- (IBAction)withLabel:(id)sender {
    [self showHUDWithText:@"Loading"];
//    [self hideHUDAfterDelay:2];
    [self hideHUDAfterExcutedBlock:^{
        [self myTask];
    }];
}
- (IBAction)withDetailLabel:(id)sender {
    [self showHUDWithText:@"Loading" deatailText:@"Plase wait"];
    [self hideHUDAfterExcuted:@selector(myTask) onTarget:self withObject:nil];
}
- (IBAction)determinateMode:(id)sender {
    [self showDeterminateHUDWithText:@"Update.." determinateMode:NHHUDDeterminateModeDeterminate];
    [self hideHUDAfterExcutedBlock:^{
        [self myProgressTask];
    }];
}
- (IBAction)annularDeterminateMode:(id)sender {
    [self showDeterminateHUDWithText:@"Update.." determinateMode:NHHUDDeterminateModeAnnularDeterminate];
    [self hideHUDAfterExcutedBlock:^{
        [self myProgressTask];
    }];

}
- (IBAction)barDeterminateMode:(id)sender {
    [self showDeterminateHUDWithText:@"Update.." determinateMode:NHHUDDeterminateModeDeterminateHorizontalBar];
    [self hideHUDAfterExcutedBlock:^{
        [self myProgressTask];
    }];

}
- (IBAction)customeView:(id)sender {
    [self showHUDWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark"]]];
}
- (IBAction)modeSwitch:(id)sender {
    [self showHUDWithText:@"Connecting..."];
    [self hideHUDAfterExcuted:@selector(myMixedTask) onTarget:self withObject:nil];
}
- (IBAction)usingBlock:(id)sender {
    [self showDeterminateHUDWithText:@"Update.." determinateMode:NHHUDDeterminateModeDeterminateHorizontalBar];
    [self hideHUDAfterExcutedBlock:^{
        [self myProgressTask];
    }];

}
- (IBAction)onWindow:(id)sender {
    [self showHUDInView:self.view.window];
    [self hideHUDAfterDelay:2];
}
- (IBAction)dimBackground:(id)sender {
    [self showHUDOnlyText:@"Ni hao.." detailText:@"Being.."];
}


- (void)myTask {
    // Do something usefull in here instead of sleeping ...
    sleep(3);
}

- (void)myProgressTask {
    // This just increases the progress indicator in a loop
    float progress = 0.0f;
    while (progress < 1.0f) {
        progress += 0.01f;
//        HUD.progress = progress;
        [self setDeterminateHUDProgress:progress];
        usleep(50000);
    }
}

- (void)myMixedTask {
    // Indeterminate mode
    sleep(2);
    // Switch to determinate mode
    [self showDeterminateHUDWithText:@"Progress.." determinateMode:NHHUDDeterminateModeDeterminate];
//    HUD.mode = MBProgressHUDModeDeterminate;
//    HUD.labelText = @"Progress";
    float progress = 0.0f;
    while (progress < 1.0f)
    {
        progress += 0.01f;
//        HUD.progress = progress;
        [self setDeterminateHUDProgress:progress];
        usleep(50000);
    }
    // Back to indeterminate mode
    [self showHUDWithText:@"Cleaning up"];
//    HUD.mode = MBProgressHUDModeIndeterminate;
//    HUD.labelText = @"Cleaning up";
    sleep(2);
    // UIImageView is a UIKit class, we have to initialize it on the main thread
    __block UIImageView *imageView;
    dispatch_sync(dispatch_get_main_queue(), ^{
        UIImage *image = [UIImage imageNamed:@"37x-Checkmark.png"];
        imageView = [[UIImageView alloc] initWithImage:image];
    });
//    HUD.customView = [imageView autorelease];
//    HUD.mode = MBProgressHUDModeCustomView;
//    HUD.labelText = @"Completed";
    [self showHUDWithCustomView:imageView text:@"Completed"];
    sleep(2);
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
