//
//  UIView+KJRectCorner.m
//  CategoryDemo
//
//  Created by 杨科军 on 2018/7/12.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "UIView+KJRectCorner.h"
#import <objc/runtime.h>

static NSString * const kcornerRadius = @"kj_rectCornerRadius";
static NSString * const krectCorner = @"kj_rectCorner";


@implementation UIView (KJRectCorner)

- (void)setKj_Radius:(CGFloat)kj_Radius{
    CGFloat Radius = [objc_getAssociatedObject(self, &kcornerRadius) floatValue];
    if (Radius != kj_Radius) {
        [self willChangeValueForKey:kcornerRadius];
        objc_setAssociatedObject(self, &kcornerRadius, @(kj_Radius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self didChangeValueForKey:kcornerRadius];
        [self kj_rectCornerWithCornerRadius:kj_Radius Corner:self.kj_RectCorner];
    }
}
- (CGFloat)kj_Radius{
    if (!objc_getAssociatedObject(self, &kcornerRadius)) {
        [self setKj_Radius:5];  // 设置默认值
    }
    return [objc_getAssociatedObject(self, &kcornerRadius) floatValue];
}

- (void)setKj_RectCorner:(UIRectCorner)kj_RectCorner{
    [self willChangeValueForKey:krectCorner];
    objc_setAssociatedObject(self, &krectCorner, @(kj_RectCorner), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:krectCorner];
    
    [self kj_rectCornerWithCornerRadius:self.kj_Radius Corner:kj_RectCorner];
}
- (UIRectCorner)kj_RectCorner{
    return [objc_getAssociatedObject(self, &krectCorner) intValue];
}

/// 内部方法
- (void)kj_rectCornerWithCornerRadius:(CGFloat)cornerRadius Corner:(UIRectCorner)corner{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

#pragma mark - 渐变相关
- (CAGradientLayer *)kj_GradientLayerWithColors:(NSArray *)colors Frame:(CGRect)frm Locations:(NSArray *)locations StartPoint:(CGPoint)startPoint EndPoint:(CGPoint)endPoint{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    if (colors == nil || [colors isKindOfClass:[NSNull class]] || colors.count == 0){
        return nil;
    }
    if (locations == nil || [locations isKindOfClass:[NSNull class]] || locations.count == 0){
        return nil;
    }
    NSMutableArray *colorsTemp = [NSMutableArray new];
    for (UIColor *color in colors) {
        if ([color isKindOfClass:[UIColor class]]) {
            [colorsTemp addObject:(__bridge id)color.CGColor];
        }
    }
    gradientLayer.colors = colorsTemp;
    gradientLayer.locations = locations;
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    gradientLayer.frame =  frm;
    return gradientLayer;
}

- (void)kj_GradientBgColorWithColors:(NSArray *)colors Locations:(NSArray *)locations StartPoint:(CGPoint)startPoint EndPoint:(CGPoint)endPoint{
    CAGradientLayer *gradientLayer = [self kj_GradientLayerWithColors:colors Frame:self.bounds Locations:locations StartPoint:startPoint EndPoint:endPoint];
    
    [self.layer insertSublayer:gradientLayer atIndex:0];
}

- (void)kj_BorderAndCornerWithRadius:(CGFloat)redius BorderWidth:(CGFloat)width BorderColor:(UIColor *)color{
    [self.layer setCornerRadius:redius];
    [self.layer setMasksToBounds:YES];
    [self.layer setBorderWidth:width];
    [self.layer setBorderColor:[color CGColor]];
}

- (void)kj_BorderTop:(BOOL)top Left:(BOOL)left Bottom:(BOOL)bottom Right:(BOOL)right BorderColor:(UIColor *)color BorderWidth:(CGFloat)width{
    if (top) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, self.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    if (left) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, width, self.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    if (bottom) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, self.frame.size.height - width, self.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    if (right) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(self.frame.size.width - width, 0, width, self.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
}

//虚线边框
- (void)kj_DashedLineColor:(UIColor *)lineColor lineWidth:(CGFloat)lineWidth spaceAry:(NSArray<NSNumber *> *)spaceAry {
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.bounds = CGRectMake(0, 0, self.width , self.height);
    borderLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    //不带圆角
    //    borderLayer.path = [UIBezierPath bezierPathWithRect:borderLayer.bounds].CGPath;
    //带圆角
    borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:borderLayer.bounds cornerRadius:self.layer.cornerRadius].CGPath;
    borderLayer.lineWidth = lineWidth / [[UIScreen mainScreen] scale];
    //虚线边框
    borderLayer.lineDashPattern = spaceAry;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = lineColor.CGColor;
    [self.layer addSublayer:borderLayer];
}

@end
