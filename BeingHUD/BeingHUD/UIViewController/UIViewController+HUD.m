//
//  UIViewController+HUD.m
//  Being
//
//  Created by Wilson Yuan on 15/10/28.
//  Copyright © 2015年 Being Inc. All rights reserved.
//

#import "UIViewController+HUD.h"
#import <MBProgressHUD.h>
#import <objc/runtime.h>

@interface UIViewController ()<MBProgressHUDDelegate>

@end

@implementation UIViewController (HUD) 

#pragma mark - show in self.view
- (void)showHUD
{
    [self showHUDWithText:nil];
}

- (void)showHUDWithText:(NSString *)text {
    [self showHUDWithText:text deatailText:nil];
}

- (void)showHUDWithText:(NSString *)text deatailText:(NSString *)detailText {
    [self showHUDInView:self.view withText:text deatailText:detailText];
}

- (void)showHUDOnlyText:(NSString *)text {
    [self showHUDOnlyText:text detailText:nil];
}

- (void)showHUDOnlyText:(NSString *)text detailText:(NSString *)detailText {
    [self showHUDInView:self.view onlyText:text detailText:detailText];
}

- (void)showDeterminateHUDWithText:(NSString *)text determinateMode:(NHHUDDeterminateMode)mode {
    [self showDeterminateHUDInView:self.view withText:text determinateMode:mode];
}

- (void)showHUDWithCustomView:(UIView *)customView {
    [self showHUDWithCustomView:customView text:nil];
}

- (void)showHUDWithCustomView:(UIView *)customView text:(NSString *)text {
    [self showHUDInView:self.view withCustomView:customView text:text];
}

#pragma mark - Show in custom view
- (void)showHUDInView:(UIView *)view {
    [self showHUDInView:view text:nil];
}

- (void)showHUDInView:(UIView *)view text:(NSString *)text {
    [self showHUDInView:view withText:text deatailText:nil];
}

- (void)showHUDInView:(UIView *)view onlyText:(NSString *)text {
    [self showHUDInView:view onlyText:text detailText:nil];
}

- (void)showHUDInView:(UIView *)view onlyText:(NSString *)text detailText:(NSString *)detailText {
    [self showDeterminateHUDInView:view withText:text detailText:detailText customView:nil determinateMode:NHHUDDeterminateModeText];
}


- (void)showHUDInView:(UIView *)view withText:(NSString *)text deatailText:(NSString *)detailText {
    [self showDeterminateHUDInView:view withText:text detailText:detailText customView:nil determinateMode:NHHUDDeterminateModeIndeterminate];
}

- (void)showDeterminateHUDInView:(UIView *)view withText:(NSString *)text determinateMode:(NHHUDDeterminateMode)mode {
    [self showDeterminateHUDInView:view withText:text detailText:nil customView:nil determinateMode:mode];
}



- (void)showHUDInView:(UIView *)view withCustomView:(UIView *)customView {
    [self showHUDInView:view withCustomView:customView text:nil];
}

- (void)showHUDInView:(UIView *)view withCustomView:(UIView *)customView text:(NSString *)text {
    [self showDeterminateHUDInView:view withText:text detailText:nil customView:customView determinateMode:NHHUDDeterminateModeCustomView];
}


- (void)showDeterminateHUDInView:(UIView *)view withText:(NSString *)text detailText:(NSString *)detailText customView:(UIView *)customView determinateMode:(NHHUDDeterminateMode)mode {
    
    MBProgressHUD *mbProgressHUD = [self mbProgressHUD];
    
    if (!mbProgressHUD) {
        mbProgressHUD = [[MBProgressHUD alloc] initWithView:view];
        mbProgressHUD.delegate = self;
        [view addSubview:mbProgressHUD];
        mbProgressHUD.minSize = CGSizeMake(150, 80);
        [self associateHudView:mbProgressHUD];
        [mbProgressHUD show:YES];
    }
    
    mbProgressHUD.mode = [self mbProgressHUBModeWithMode:mode];
    mbProgressHUD.customView = customView ? customView : nil;
    mbProgressHUD.labelText = text ? text : nil;
    mbProgressHUD.detailsLabelText = detailText ? detailText : nil;
    
    [self associateHUDDeterminteModel:mode];
    
    if (mode == NHHUDDeterminateModeCustomView || mode == NHHUDDeterminateModeText) {
        [self hideHUDAfterDelay:[self displayDurationForString:text]];
    }
}

- (void)setDeterminateHUDProgress:(CGFloat)progress
{
    if ([self isDetermainteMode]) {
        [[self mbProgressHUD] setProgress:progress];
    }
}

#pragma mark - Hide HUD View
- (void)hideHUD {
    [self hideHUDAfterDelay:0];
}

- (void)hideHUDAfterDelay:(NSTimeInterval)dealy {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self mbProgressHUD] hide:YES afterDelay:dealy];
    });
}

- (void)hideHUDAfterExcuted:(SEL)method onTarget:(id)target withObject:(id)object {
    [[self mbProgressHUD] showWhileExecuting:method onTarget:target withObject:object animated:YES];
}

- (void)hideHUDAfterExcutedBlock:(dispatch_block_t)block {
    [[self mbProgressHUD] showAnimated:YES whileExecutingBlock:block];
}

- (void)hideHUDAfterExcutedBlock:(dispatch_block_t)block completionBlock:(dispatch_block_t)completion {
    [[self mbProgressHUD] showAnimated:YES whileExecutingBlock:block completionBlock:completion];
}

- (void)hideHUDAfterExcutedBlock:(dispatch_block_t)block onQueue:(dispatch_queue_t)queue {
    [[self mbProgressHUD] showAnimated:YES whileExecutingBlock:block onQueue:queue];
}

- (void)hideHUDAfterExcutedBlock:(dispatch_block_t)block onQueue:(dispatch_queue_t)queue completionBlock:(dispatch_block_t)completion {
    [[self mbProgressHUD] showAnimated:YES whileExecutingBlock:block onQueue:queue completionBlock:completion];
}

#pragma mark- MBProgressHUD delegate
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [self removeHUDAssociate];
}


#pragma mark - Pravite Method
- (MBProgressHUDMode)mbProgressHUBModeWithMode:(NHHUDDeterminateMode)mode {
    switch (mode) {
        case NHHUDDeterminateModeIndeterminate: {
            return MBProgressHUDModeIndeterminate;
        }break;
        case NHHUDDeterminateModeDeterminate: {
            return MBProgressHUDModeDeterminate;
        }break;
        case NHHUDDeterminateModeDeterminateHorizontalBar: {
            return MBProgressHUDModeDeterminateHorizontalBar;
        }break;
        case NHHUDDeterminateModeAnnularDeterminate: {
            return MBProgressHUDModeAnnularDeterminate;
        }break;
        case NHHUDDeterminateModeCustomView: {
            return MBProgressHUDModeCustomView;
        }break;
        case NHHUDDeterminateModeText: {
            return MBProgressHUDModeText;
        }break;
        default:
            break;
    }
}


/**
 *  当前Mode是否进度条
 *
 *  @return 如果是进度条->YES
 */
- (BOOL)isDetermainteMode {
    switch ([self currentHUDDeterminateMode]) {
        case NHHUDDeterminateModeDeterminate:
        case NHHUDDeterminateModeAnnularDeterminate:
        case NHHUDDeterminateModeDeterminateHorizontalBar: {
            return YES;
        } break;
        default:
            return NO;
            break;
    }
}

- (NSTimeInterval)displayDurationForString:(NSString*)string {
    CGFloat duration = MIN((CGFloat)string.length*0.06 + 0.5, 5.0);
    if (duration < 2.0) {
        duration = 2.0;
    }
    return duration;
}


#pragma mark - Associated Method

- (void)associateHudView: (MBProgressHUD *)hud {
    objc_setAssociatedObject(self, @selector(mbProgressHUD), hud, OBJC_ASSOCIATION_RETAIN);
}
- (MBProgressHUD *)mbProgressHUD {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)removeHUDAssociate
{
    objc_setAssociatedObject(self, @selector(mbProgressHUD), nil, OBJC_ASSOCIATION_RETAIN);
}

- (void)associateHUDDeterminteModel:(NHHUDDeterminateMode)mode {
    objc_setAssociatedObject(self, @selector(currentHUDDeterminateMode), @(mode), OBJC_ASSOCIATION_ASSIGN);
}

- (NHHUDDeterminateMode)currentHUDDeterminateMode {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

//DEBUG
- (void)autoHiddenAfter2s {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideHUD];
    });

}

@end
