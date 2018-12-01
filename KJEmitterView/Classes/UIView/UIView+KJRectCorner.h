//
//  UIView+KJRectCorner.h
//  CategoryDemo
//
//  Created by 杨科军 on 2018/7/12.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (KJRectCorner)

/** 圆角半径 默认 5 */
@property(nonatomic,assign)CGFloat kj_Radius;

/** 圆角方位 */
@property(nonatomic,assign)UIRectCorner kj_RectCorner;

@end
