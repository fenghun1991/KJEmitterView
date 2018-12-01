//
//  UIImage+KJFilter.h
//  KJEmitterView
//
//  Created by 杨科军 on 2018/12/1.
//  Copyright © 2018 杨科军. All rights reserved.
//  滤镜相关，特效渲染

#import <UIKit/UIKit.h>

@interface UIImage (KJFilter)

#pragma mark - 特效渲染
/** 颜色加深 color 加深的颜色*/
- (UIImage *)kj_drawingWithColorizeImageWithcolor:(UIColor *)color;

/** 马赛克化 */
- (UIImage *)kj_drawingWithMosaic;

/** 高斯模糊 blur 模糊等级 0~1 */
- (UIImage *)kj_drawingWithGaussianBlurNumber:(CGFloat)blur;

/** 边缘锐化 */
- (UIImage *)kj_drawingWithEdgeDetection;

/** 浮雕 */
- (UIImage *)kj_drawingWithEmboss;

/** 锐化 */
- (UIImage *)kj_drawingWithSharpen;

/** 进一步锐化 */
- (UIImage *)kj_drawingWithNnsharpen;

/** 获得灰度图 */
- (UIImage*)kj_drawingWithGrayImage;


#pragma mark - 形态学图像渲染
/** 形态膨胀/扩张 */
- (UIImage *)kj_drawingWithDilate;

/** 形态多倍膨胀/扩张 */
- (UIImage *)kj_drawingWithDilateIterations:(int)iterations;

/** 侵蚀 */
- (UIImage *)kj_drawingWithErode;

/** 多倍侵蚀 */
- (UIImage *)kj_drawingWithErodeIterations:(int)iterations;

/** 均衡运算 */
- (UIImage *)kj_drawingWithEqualization;

/** 梯度 */
- (UIImage *)kj_drawingWithGradientIterations:(int)iterations;

/** 顶帽运算 */
- (UIImage *)kj_drawingWithTophatIterations:(int)iterations;

/** 黑帽运算 */
- (UIImage *)kj_drawingWithBlackhatIterations:(int)iterations;

@end

