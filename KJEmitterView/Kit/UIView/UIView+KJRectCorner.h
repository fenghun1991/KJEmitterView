//
//  UIView+KJRectCorner.h
//  CategoryDemo
//
//  Created by 杨科军 on 2018/7/12.
//  Copyright © 2018年 杨科军. All rights reserved.
//  渐变 - 圆角扩展

#import <UIKit/UIKit.h>

@interface UIView (KJRectCorner)

/** 圆角半径 默认 5 */
@property(nonatomic,assign)CGFloat kj_Radius;

/** 圆角方位 */
@property(nonatomic,assign)UIRectCorner kj_RectCorner;

/**
 返回渐变layer
 @param colors     渐变的颜色
 @param locations  渐变颜色的分割点
 @param startPoint 渐变颜色的方向起点,范围在（0,0）与（1,1）之间,如(0,0)(1,0)代表水平方向渐变,(0,0)(0,1)代表竖直方向渐变
 @param endPoint   渐变颜色的方向终点
 */
- (CAGradientLayer *)kj_GradientLayerWithColors:(NSArray *)colors Frame:(CGRect)frm Locations:(NSArray *)locations StartPoint:(CGPoint)startPoint EndPoint:(CGPoint)endPoint;

/**
 生成渐变背景色
 @param colors     渐变的颜色
 @param locations  渐变颜色的分割点
 @param startPoint 渐变颜色的方向起点,范围在（0，0）与（1,1）之间,如(0,0)(1,0)代表水平方向渐变,(0,0)(0,1)代表竖直方向渐变
 @param endPoint   渐变颜色的方向终点
 */
- (void)kj_GradientBgColorWithColors:(NSArray *)colors Locations:(NSArray *)locations StartPoint:(CGPoint)startPoint EndPoint:(CGPoint)endPoint;

/**
 设置圆角和边框
 @param redius 圆角大小
 @param width  边框宽度
 @param color  边框颜色
 */
- (void)kj_BorderAndCornerWithRadius:(CGFloat)redius BorderWidth:(CGFloat)width BorderColor:(UIColor *)color;


/**
 设置某一条边的边框
 @param top    顶部
 @param left   左侧
 @param bottom 底部
 @param right  右侧
 @param color  边框颜色
 @param width  边框宽度
 */
- (void)kj_BorderTop:(BOOL)top Left:(BOOL)left Bottom:(BOOL)bottom Right:(BOOL)right BorderColor:(UIColor *)color BorderWidth:(CGFloat)width;


@end
