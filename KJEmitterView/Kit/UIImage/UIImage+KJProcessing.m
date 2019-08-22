//
//  UIImage+KJProcessing.m
//  KJEmitterView
//
//  Created by 杨科军 on 2018/12/1.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "UIImage+KJProcessing.h"
#import <Accelerate/Accelerate.h>
#import <QuartzCore/QuartzCore.h>

@implementation UIImage (KJProcessing)
/** 屏幕截图 */
+ (UIImage*)kj_captureScreen:(UIView *)view{
    // 手动开启图片上下文
    UIGraphicsBeginImageContext(view.bounds.size);
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 渲染上下文到图层
    [view.layer renderInContext:ctx];
    // 从当前上下文获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return newImage;
}

/** 返回圆形图片 直接操作layer.masksToBounds = YES 会比较卡顿 */
- (UIImage *)kj_circleImage{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);/// 图片是否显示通道
    // 获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    // 裁剪
    CGContextClip(ctx);
    // 将图片画上去
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/** 图片旋转 */
- (UIImage *)kj_rotateInRadians:(CGFloat)radians{
    if (!(&vImageRotate_ARGB8888)) return nil;
    const size_t width = self.size.width;
    const size_t height = self.size.height;
    const size_t bytesPerRow = width * 4;
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8, bytesPerRow, space, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(space);
    if (!bmContext) return nil;
    CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, self.CGImage);
    UInt8 *data = (UInt8*)CGBitmapContextGetData(bmContext);
    if (!data){
        CGContextRelease(bmContext);
        return nil;
    }
    vImage_Buffer src  = {data, height, width, bytesPerRow};
    vImage_Buffer dest = {data, height, width, bytesPerRow};
    Pixel_8888 bgColor = {0, 0, 0, 0};
    vImageRotate_ARGB8888(&src, &dest, NULL, radians, bgColor, kvImageBackgroundColorFill);
    CGImageRef rotatedImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage *newImg = [UIImage imageWithCGImage:rotatedImageRef];
    CGImageRelease(rotatedImageRef);
    CGContextRelease(bmContext);
    return newImg;
}

/** 改变Image的任何的大小
 *  @param size 目的大小
 *  @return 修改后的Image
 */
- (UIImage *)kj_cropImageWithAnySize:(CGSize)size{
    float scale = self.size.width/self.size.height;
    CGRect rect = CGRectMake(0, 0, 0, 0);
    
    if (scale > size.width/size.height){
        rect.origin.x = (self.size.width - self.size.height * size.width/size.height)/2;
        rect.size.width  = self.size.height * size.width/size.height;
        rect.size.height = self.size.height;
    }else {
        rect.origin.y = (self.size.height - self.size.width/size.width * size.height)/2;
        rect.size.width  = self.size.width;
        rect.size.height = self.size.width/size.width * size.height;
    }
    CGImageRef imageRef   = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return croppedImage;
}

/** 裁剪和拉升图片 */
- (UIImage*)kj_scalingAndCroppingForTargetSize:(CGSize)targetSize{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize)== NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor > heightFactor)
        scaleFactor = widthFactor; // scale to fit height
        else
        scaleFactor = heightFactor; // scale to fit width
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        if (widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight)* 0.5;
        }
        else if (widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth)* 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil) NSLog(@"=========could not scale image===========");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

/** 通过比例来缩放图片 scale 缩放比例*/
- (UIImage *)kj_transformImageScale:(CGFloat)scale{
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width * scale, self.size.height * scale));
    [self drawInRect:CGRectMake(0, 0, self.size.width * scale, self.size.height * scale)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

// 画水印
- (UIImage*)kj_waterMark:(UIImage *)mark InRect:(CGRect)rect{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    CGRect imgRect = CGRectMake(0, 0, self.size.width, self.size.height);
    [self drawInRect:imgRect];// 原图
    [mark drawInRect:rect];   // 水印图
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newPic;
}

/** 旋转图片 orientation 图片旋转方向 */
- (UIImage*)kj_rotationImageWithOrientation:(UIImageOrientation)orientation{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, self.size.height, self.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, self.size.height, self.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, self.size.width, self.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, self.size.width, self.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), self.CGImage);
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    return newPic;
}

/* Image 拼接
 * masterImage  主图片
 * headImage   头图片
 * footImage   尾图片
 */
+ (UIImage *)kj_jointImageWithMasterImage:(UIImage *)masterImage HeadImage:(UIImage *)headImage FootImage:(UIImage *)footImage{
    CGSize size = CGSizeZero;
    size.width = masterImage.size.width;
    CGFloat headHeight = !headImage ? 0 : headImage.size.height;
    CGFloat footHeight = !footImage ? 0 : footImage.size.height;
    size.height = masterImage.size.height + headHeight + footHeight;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0); /// 图片是否显示通道
    if (headImage) [headImage drawInRect:CGRectMake(0, 0, masterImage.size.width, headHeight)];
    [masterImage drawInRect:CGRectMake(0, headHeight, masterImage.size.width, masterImage.size.height)];
    if (footImage) [footImage drawInRect:CGRectMake(0, masterImage.size.height + headHeight, masterImage.size.width, footHeight)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}
/**把图片多次合成
 @param localImage 当前图片
 @param maskImage 要合成的图片
 @param loopNums 要合成的次数
 @param orientation 当前的方向
 @return 合成完成的图片
 */
+ (UIImage *)kj_imageCompoundWithLocalImage:(UIImage*)localImage MsakImage:(UIImage*)maskImage LoopNums:(NSInteger)loopNums Orientation:(UIImageOrientation)orientation{
    UIGraphicsBeginImageContextWithOptions(localImage.size ,NO, 0.0);
    //四个参数为水印图片的位置
    //如果要多个位置显示，继续drawInRect就行
    switch (orientation) {
        case UIImageOrientationUp:
            for (int i = 0; i < loopNums; i ++){
                CGFloat X = localImage.size.width/loopNums*i;
                CGFloat W = localImage.size.width/loopNums;
                CGFloat H = localImage.size.height;
                CGFloat Y = 0;
                [maskImage drawInRect:CGRectMake(X, Y, W, H)];
            }
            break;
        case UIImageOrientationLeft :
            for (int i = 0; i < loopNums; i ++){
                CGFloat X = 0;
                CGFloat W = localImage.size.width;
                CGFloat H = localImage.size.height / loopNums;
                CGFloat Y = localImage.size.height / loopNums * i;
                [maskImage drawInRect:CGRectMake(X, Y, W, H)];
            }
            break;
        case UIImageOrientationRight:
            for (int i = 0; i < loopNums; i ++){
                CGFloat X = 0;
                CGFloat W = localImage.size.width;
                CGFloat H = localImage.size.height / loopNums;
                CGFloat Y = localImage.size.height / loopNums * i;
                [maskImage drawInRect:CGRectMake(X, Y, W, H)];
            }
            break;
        default:
            break;
    }
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

@end
