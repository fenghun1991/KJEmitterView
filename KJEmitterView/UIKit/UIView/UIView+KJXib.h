//
//  UIView+KJXib.h
//  KJEmitterView
//
//  Created by 杨科军 on 2018/12/1.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (KJXib)

/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)kj_isShowingOnKeyWindow;

/**
 * xib创建的view
 */
+ (instancetype)kj_viewFromXib;

/**
 * xib创建的view
 */
+ (instancetype)kj_viewFromXibWithFrame:(CGRect)frame;

/** 设置了这几个属性，xib创建的view右上角才有这几个选项
 * xib中显示的属性
 */
@property (nonatomic)IBInspectable UIColor *borderColor;
@property (nonatomic)IBInspectable CGFloat borderWidth;
@property (nonatomic)IBInspectable CGFloat cornerRadius;
@property (nonatomic)IBInspectable BOOL masksToBounds;

@end

NS_ASSUME_NONNULL_END
