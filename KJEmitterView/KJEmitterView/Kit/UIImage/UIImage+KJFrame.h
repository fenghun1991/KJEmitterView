//
//  UIImage+KJFrame.h
//  KJEmitterView
//
//  Created by 杨科军 on 2018/12/1.
//  Copyright © 2018 杨科军. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KJFrame)

/** 屏幕截图 返回一张截图*/
+ (UIImage*)kj_captureScreen:(UIView *)view;

/** 返回圆形图片 直接操作layer.masksToBounds = YES 会比较卡顿 */
- (UIImage *)kj_circleImage;

/** 图片旋转 radians 旋转角度*/
- (UIImage *)kj_rotateInRadians:(CGFloat)radians;

/** 改变Image的任何的大小 size 目的大小*/
- (UIImage *)kj_cropImageWithAnySize:(CGSize)size;

/** 裁剪和拉升图片 targetSize 裁剪尺寸*/
- (UIImage*)kj_scalingAndCroppingForTargetSize:(CGSize)targetSize;

/** 通过比例来缩放图片 scale 缩放比例*/
- (UIImage *)kj_transformImageScale:(CGFloat)scale;

/** 合并两张图片 */
+ (UIImage*)kj_mergeImageWithFirstImage:(UIImage*)firstImage SecondImage:(UIImage*)secondImage;

/** 画水印 给图片添加水印 */
- (UIImage*)kj_waterMark:(UIImage *)mark InRect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
