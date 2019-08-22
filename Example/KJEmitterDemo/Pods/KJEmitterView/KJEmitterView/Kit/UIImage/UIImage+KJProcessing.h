//
//  UIImage+KJProcessing.h
//  KJEmitterView
//
//  Created by 杨科军 on 2018/12/1.
//  Copyright © 2018 杨科军. All rights reserved.
//  图片加工处理

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KJProcessing)

/** 屏幕截图 返回一张截图 */
+ (UIImage*)kj_captureScreen:(UIView *)view;

/** 返回圆形图片 直接操作layer.masksToBounds = YES 会比较卡顿 */
- (UIImage *)kj_circleImage;

/** 图片旋转 radians:旋转角度 */
- (UIImage *)kj_rotateInRadians:(CGFloat)radians;

/** 改变Image的任何的大小 size:目的大小 */
- (UIImage *)kj_cropImageWithAnySize:(CGSize)size;

/** 裁剪和拉升图片 targetSize:裁剪尺寸 */
- (UIImage*)kj_scalingAndCroppingForTargetSize:(CGSize)targetSize;

/** 通过比例来缩放图片 scale:缩放比例 */
- (UIImage *)kj_transformImageScale:(CGFloat)scale;

/** 画水印 给图片添加水印 */
- (UIImage*)kj_waterMark:(UIImage *)mark InRect:(CGRect)rect;

/** 旋转图片 orientation 图片旋转方向 */
- (UIImage*)kj_rotationImageWithOrientation:(UIImageOrientation)orientation;

/* 拼接图片 masterImage:主图片 headImage:头图片 footImage:尾图片 */
+ (UIImage *)kj_jointImageWithMasterImage:(UIImage *)masterImage HeadImage:(UIImage *)headImage FootImage:(UIImage *)footImage;

/* 图片多次合成处理 useImage:当前图片 maskImage:要合成的图片 loopTimes:要合成的次数 orientation:当前的方向 */
+ (UIImage *)kj_imageCompoundWithLocalImage:(UIImage*)useImage MsakImage:(UIImage*)maskImage LoopNums:(NSInteger)loopTimes Orientation:(UIImageOrientation)orientation;

@end

NS_ASSUME_NONNULL_END
