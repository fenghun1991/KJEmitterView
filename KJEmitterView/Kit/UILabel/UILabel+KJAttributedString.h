//
//  UILabel+KJAttributedString.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/4/4.
//  Copyright © 2019 杨科军. All rights reserved.
//  富文本

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (KJAttributedString)
/* Range之间文字大小 */
- (void)kj_AttributedStringTextFont:(UIFont *)font Range:(NSRange)range;
/* Range之间文字颜色 */
- (void)kj_AttributedStringTextColor:(UIColor *)color Range:(NSRange)range;
/* Range之间文字行间距 */
- (void)kj_AttributedStringTextLineSpace:(CGFloat)space Range:(NSRange)range;
/* Range之间文字大小 和 颜色 */
- (void)kj_AttributedStringTextFont:(UIFont *)font TextColor:(UIColor *)color Range:(NSRange)range;
/* Range之间文字相关属性 */
- (void)kj_AttributedStringTextAttributes:(NSDictionary *)attributes Range:(NSRange)range;

@end

NS_ASSUME_NONNULL_END
