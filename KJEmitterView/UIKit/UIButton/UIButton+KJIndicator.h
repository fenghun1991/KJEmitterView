//
//  UIButton+KJIndicator.h
//  KJEmitterView
//
//  Created by 杨科军 on 2018/12/1.
//  Copyright © 2018 杨科军. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UIButton (KJIndicator)
/**
 This method will show the activity indicator in place of the button text.
 */
- (void)kj_showIndicator;

/**
 This method will remove the indicator and put thebutton text back in place.
 */
- (void)kj_hideIndicator;

@end

NS_ASSUME_NONNULL_END
