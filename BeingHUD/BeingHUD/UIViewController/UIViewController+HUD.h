//
//  UIViewController+HUD.h
//  Being
//
//  Created by Wilson Yuan on 15/10/28.
//  Copyright © 2015年 Being Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NHProgressHUD-Header.h"

@class MBProgressHUD;

@interface UIViewController (HUD)

#pragma mark - show in self.view

/**
 *  Shown using Indicator view
 */
- (void)showHUD;

/**
 *  shown using Indicator view & text
 */

- (void)showHUDWithText:(NSString *)text;

/**
 *  shown using Indicator view & text & detailText
 *
 *  @param text       text
 *  @param detailText detail text
 */

- (void)showHUDWithText:(NSString *)text deatailText:(NSString *)detailText;

/**
 *  shown only using text -> did't have indicator view
 *  this mode will auto hide
 */
- (void)showHUDOnlyText:(NSString *)text;

/**
 *  shown only using text and detail text  -> did't have indicator view
 *  this mode will auto hide
 */
- (void)showHUDOnlyText:(NSString *)text detailText:(NSString *)detailText;

/**
 *  shown using progress type
 *
 *  @param mode determinate mode
 */
- (void)showDeterminateHUDWithText:(NSString *)text determinateMode:(NHHUDDeterminateMode)mode;

/**
 *  set determinate mode progress
 *
 *  @param progress a progress
 */
- (void)setDeterminateHUDProgress:(CGFloat)progress;

/**
 *  shown with custom view like a imageView or else
 *  this mode will auto hide
 */
- (void)showHUDWithCustomView:(UIView *)customView;

/**
 *  shown with custom view like a imageView or else
 *  this mode will auto hide
 *  @param text add some text for show
 */
- (void)showHUDWithCustomView:(UIView *)customView text:(NSString *)text;

#pragma mark - Show in custom view

/**
 *  show hud in a custom view eg: self.view / self.navigationController.view ...
 *
 *  @param view a custom view
 */
- (void)showHUDInView:(UIView *)view;

- (void)showHUDInView:(UIView *)view text:(NSString *)text;

- (void)showHUDInView:(UIView *)view onlyText:(NSString *)text;

- (void)showHUDInView:(UIView *)view onlyText:(NSString *)text detailText:(NSString *)detailText;

- (void)showHUDInView:(UIView *)view withText:(NSString *)text deatailText:(NSString *)detailText;

- (void)showDeterminateHUDInView:(UIView *)view withText:(NSString *)text determinateMode:(NHHUDDeterminateMode)mode;

- (void)showHUDInView:(UIView *)view withCustomView:(UIView *)customView;

- (void)showHUDInView:(UIView *)view withCustomView:(UIView *)customView text:(NSString *)text;

#pragma mark - Hide HUD view
- (void)hideHUD;

- (void)hideHUDAfterDelay:(NSTimeInterval)dealy;

/**
 *  Hide hud after execute a method
 */
- (void)hideHUDAfterExecuted:(SEL)method onTarget:(id)target withObject:(id)object;

/**
 *  hide hud after execute a block
 *
 */
- (void)hideHUDAfterExecutedBlock:(dispatch_block_t)block;

/**
 *  hide hud after execute a block
 *
 *  @param block block
 *  @param completion after the block be executed the completion will be invoke
 */
- (void)hideHUDAfterExecutedBlock:(dispatch_block_t)block completionBlock:(dispatch_block_t)completion;

/**
 *  hide hud after execute a block
 *
 *  @param block block
 *  @param queue a special queue
 */
- (void)hideHUDAfterExecutedBlock:(dispatch_block_t)block onQueue:(dispatch_queue_t)queue;

/**
 *  hide hud after execute a block
 *  @param block      block
 *  @param queue      a special queue
 *  @param completion after the block be executed the completion will be invoke
 */
- (void)hideHUDAfterExecutedBlock:(dispatch_block_t)block onQueue:(dispatch_queue_t)queue completionBlock:(dispatch_block_t)completion;

@end
