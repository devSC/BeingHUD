//
//  NHProgressHUD.m
//  BeingHUD
//
//  Created by Wilson Yuan on 15/11/13.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "NHProgressHUD.h"
#import <MBProgressHUD.h>

@interface MBProgressHUD ()<MBProgressHUDDelegate>

@property (strong, nonatomic) MBProgressHUD *mbProgressHUD;

@property (assign, nonatomic) NHHUDViewMode hudViewMode;

@property (assign, nonatomic) NHHUDDeterminateMode determinateMode;

@end

@implementation NHProgressHUD

+ (NHProgressHUD *)shareInstance {
    static dispatch_once_t onceToken;
    static NHProgressHUD *hud;
    dispatch_once(&onceToken, ^{
        hud = [[NHProgressHUD alloc] init];
    });
    return hud;
}



- (void)showHUD {
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
    [self showDeterminateHUDInView:view withText:text detailText:detailText customView:nil determinateMode:NHHUDViewModeText];
}


- (void)showHUDInView:(UIView *)view withText:(NSString *)text deatailText:(NSString *)detailText {
    [self showDeterminateHUDInView:view withText:text detailText:detailText customView:nil determinateMode:NHHUDViewModeIndeterminate];
}

- (void)showDeterminateHUDInView:(UIView *)view withText:(NSString *)text determinateMode:(NHHUDDeterminateMode)mode {
    
    //Save the determinate mode
    self.determinateMode = mode;
    [self showDeterminateHUDInView:view withText:text detailText:nil customView:nil determinateMode:NHHUDViewModeDeterminate];
}



- (void)showHUDInView:(UIView *)view withCustomView:(UIView *)customView {
    [self showHUDInView:view withCustomView:customView text:nil];
}

- (void)showHUDInView:(UIView *)view withCustomView:(UIView *)customView text:(NSString *)text {
    [self showDeterminateHUDInView:view withText:text detailText:nil customView:customView determinateMode:NHHUDViewModeCustomView];
}


- (void)showDeterminateHUDInView:(UIView *)view withText:(NSString *)text detailText:(NSString *)detailText customView:(UIView *)customView determinateMode:(NHHUDViewMode)mode {
    
    if (!self.mbProgressHUD) {
        self.mbProgressHUD = [[MBProgressHUD alloc] initWithView:view];
        self.mbProgressHUD.delegate = self;
        self.mbProgressHUD.minSize = NHHUDMinSize;
        
        [view addSubview:self.mbProgressHUD];
        [self.mbProgressHUD show:YES];
    }
    
    self.mbProgressHUD.mode = [self mbProgressHUDModeWithNHHUDViewMode:mode];
    self.mbProgressHUD.customView = customView ? customView : nil;
    self.mbProgressHUD.labelText = text ? text : nil;
    self.mbProgressHUD.detailsLabelText = detailText ? detailText : nil;
    self.hudViewMode = mode;
    
    //if view mode is NHHUDViewModeCustomView or NHHUDViewModeText mode, the hud view will Auto hidden
    if (mode == NHHUDViewModeCustomView || mode == NHHUDViewModeText) {
        [self hideHUDAfterDelay:[self displayDurationForString:text]];
    }
}

- (void)setDeterminateHUDProgress:(CGFloat)progress {
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

- (void)hideHUDAfterExecuted:(SEL)method onTarget:(id)target withObject:(id)object {
    [[self mbProgressHUD] showWhileExecuting:method onTarget:target withObject:object animated:YES];
}

- (void)hideHUDAfterExecutedBlock:(dispatch_block_t)block {
    [[self mbProgressHUD] showAnimated:YES whileExecutingBlock:block];
}

- (void)hideHUDAfterExecutedBlock:(dispatch_block_t)block completionBlock:(dispatch_block_t)completion {
    [[self mbProgressHUD] showAnimated:YES whileExecutingBlock:block completionBlock:completion];
}

- (void)hideHUDAfterExecutedBlock:(dispatch_block_t)block onQueue:(dispatch_queue_t)queue {
    [[self mbProgressHUD] showAnimated:YES whileExecutingBlock:block onQueue:queue];
}

- (void)hideHUDAfterExecutedBlock:(dispatch_block_t)block onQueue:(dispatch_queue_t)queue completionBlock:(dispatch_block_t)completion {
    [[self mbProgressHUD] showAnimated:YES whileExecutingBlock:block onQueue:queue completionBlock:completion];
}

#pragma mark - MBProgressHUD delegate
- (void)hudWasHidden:(MBProgressHUD *)hud {
    [self removeHUDAssociate];
}


#pragma mark - Pravite Method
/**
 *  @param mode 当前HUDMode
 *
 *  @return 返回MBProgressHUDMode
 */
- (MBProgressHUDMode)mbProgressHUDModeWithNHHUDViewMode:(NHHUDViewMode)mode {
    switch (mode) {
        case NHHUDViewModeIndeterminate: {
            return MBProgressHUDModeIndeterminate;
        } break;
        case NHHUDViewModeDeterminate: {
            return [self mbProgressDeterminateMode];
        } break;
        case NHHUDViewModeCustomView: {
            return MBProgressHUDModeCustomView;
        } break;
        case NHHUDViewModeText: {
            return MBProgressHUDModeText;
        } break;
        default:
            break;
    }
}

/**
 *  当前HUD是进度条模式
 *
 *  @return MBProgressHUD对应的进度条Mode
 */
- (MBProgressHUDMode)mbProgressDeterminateMode {
    switch (self.determinateMode) {
        case NHHUDDeterminateModeDefault: {
            return MBProgressHUDModeDeterminate;
        } break;
        case NHHUDDeterminateModeHorizontalBar: {
            return MBProgressHUDModeDeterminateHorizontalBar;
        } break;
        case NHHUDDeterminateModeAnnular: {
            return MBProgressHUDModeAnnularDeterminate;
        } break;
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
    return self.hudViewMode == NHHUDViewModeDeterminate ? YES : NO;
}


/**
 *  当HUDMode是Custom view 和 onlyText时 计算hud view显示时间
 *
 *  @param string text
 *
 *  @return 延迟隐藏hud时间 最小为2s
 */
- (NSTimeInterval)displayDurationForString:(NSString*)string {
    CGFloat duration = MIN((CGFloat)string.length*0.06 + 0.5, 5.0);
    if (duration < 2.0) {
        duration = 2.0;
    }
    return duration;
}


#pragma mark - Setter & Getter
- (void)setMbProgressHUD:(MBProgressHUD *)mbProgressHUD {
    objc_setAssociatedObject(self, @selector(mbProgressHUD), mbProgressHUD, OBJC_ASSOCIATION_RETAIN);
}

- (MBProgressHUD *)mbProgressHUD {
    return objc_getAssociatedObject(self, _cmd);
}


- (void)setHudViewMode:(NHHUDViewMode)hudViewMode {
    objc_setAssociatedObject(self, @selector(hudViewMode), @(hudViewMode), OBJC_ASSOCIATION_ASSIGN);
}

- (NHHUDViewMode)hudViewMode {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setDeterminateMode:(NHHUDDeterminateMode)determinateMode {
    objc_setAssociatedObject(self, @selector(determinateMode), @(determinateMode), OBJC_ASSOCIATION_ASSIGN);
}

- (NHHUDDeterminateMode)determinateMode {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

/**
 *  when the hud hidden the associate should be set to nil
 */
- (void)removeHUDAssociate {
    objc_setAssociatedObject(self, @selector(mbProgressHUD), nil, OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, @selector(hudViewMode), nil, OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self, @selector(determinateMode), nil, OBJC_ASSOCIATION_ASSIGN);
}

@end
