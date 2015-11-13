//
//  NHProgressHUD-Header.h
//  BeingHUD
//
//  Created by Wilson Yuan on 15/11/13.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#ifndef NHProgressHUD_Header_h
#define NHProgressHUD_Header_h

typedef NS_ENUM(NSInteger, NHHUDDeterminateMode) {
    /** Progress is shown using a round, pie-chart like, progress view. */
    NHHUDDeterminateModeDefault,
    /** Progress is shown using a horizontal progress bar */
    NHHUDDeterminateModeHorizontalBar,
    /** Progress is shown using a ring-shaped progress view. */
    NHHUDDeterminateModeAnnular,
};



typedef NS_ENUM(NSInteger, NHHUDViewMode) {
    /** Progress is shown using an UIActivityIndicatorView. This is the default. */
    NHHUDViewModeIndeterminate,
    /** Progress is shown using progress view. */
    NHHUDViewModeDeterminate,
    /** Shows a custom view */
    NHHUDViewModeCustomView,
    /** Shows only labels */
    NHHUDViewModeText,
};
#endif /* NHProgressHUD_Header_h */
