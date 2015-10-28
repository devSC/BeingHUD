//
//  UIViewController+HUD.h
//  Being
//
//  Created by Wilson Yuan on 15/10/28.
//  Copyright © 2015年 Being Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NHHUDDeterminateMode) {
    /** Progress is shown using an UIActivityIndicatorView. This is the default. */
    NHHUDDeterminateModeIndeterminate,
    /** Progress is shown using a round, pie-chart like, progress view. */
    NHHUDDeterminateModeDeterminate = 1,
    /** Progress is shown using a horizontal progress bar */
    NHHUDDeterminateModeDeterminateHorizontalBar,
    /** Progress is shown using a ring-shaped progress view. */
    NHHUDDeterminateModeAnnularDeterminate,
    /** Shows a custom view */
    NHHUDDeterminateModeCustomView,
    /** Shows only labels */
    NHHUDDeterminateModeText,
};

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
 */
- (void)showHUDOnlyText:(NSString *)text;

/**
 *  shown only
 */
- (void)showHUDOnlyText:(NSString *)text detailText:(NSString *)detailText;

- (void)showDeterminateHUDWithText:(NSString *)text determinateMode:(NHHUDDeterminateMode)mode;

- (void)setDeterminateHUDProgress:(CGFloat)progress;

- (void)showHUDWithCustomView:(UIView *)customView;

- (void)showHUDWithCustomView:(UIView *)customView text:(NSString *)text;

#pragma mark - Show in custom view
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

- (void)hideHUDAfterExcuted:(SEL)method onTarget:(id)target withObject:(id)object;

- (void)hideHUDAfterExcutedBlock:(dispatch_block_t)block;

- (void)hideHUDAfterExcutedBlock:(dispatch_block_t)block completionBlock:(dispatch_block_t)completion;

- (void)hideHUDAfterExcutedBlock:(dispatch_block_t)block onQueue:(dispatch_queue_t)queue;

- (void)hideHUDAfterExcutedBlock:(dispatch_block_t)block onQueue:(dispatch_queue_t)queue completionBlock:(dispatch_block_t)completion;


#if DEBUG
- (void)autoHiddenAfter2s; //2s
#endif
@end
