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

@end
