//
//  UIButton+KJBlock.m
//  KJEmitterView
//
//  Created by 杨科军 on 2019/4/4.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "UIButton+KJBlock.h"
#import <objc/runtime.h>

@implementation UIButton (KJBlock)
/// 方法名交换
static void kj_Swizzle(Class c, SEL orig, SEL new) {
    Method origMethod = class_getInstanceMethod(c, orig);
    Method newMethod = class_getInstanceMethod(c, new);
    if (class_addMethod(c, orig, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))){
        class_replaceMethod(c, new, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, newMethod);
    }
}

+ (void)load {
    kj_Swizzle(self, @selector(pointInside:withEvent:), @selector(kj_PointInside:withEvent:));
}

- (BOOL)kj_PointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (UIEdgeInsetsEqualToEdgeInsets(self.kj_touchExtendInset, UIEdgeInsetsZero) || self.hidden ||
        ([self isKindOfClass:UIControl.class] && !((UIControl *)self).enabled)) {
        return [self kj_PointInside:point withEvent:event]; // original implementation
    }
    CGRect hitFrame = UIEdgeInsetsInsetRect(self.bounds, self.kj_touchExtendInset);
    hitFrame.size.width = MAX(hitFrame.size.width, 0); // don't allow negative sizes
    hitFrame.size.height = MAX(hitFrame.size.height, 0);
    return CGRectContainsPoint(hitFrame, point);
}

static char touchExtendInsetKey;
- (void)setKj_touchExtendInset:(UIEdgeInsets)kj_touchExtendInset {
    objc_setAssociatedObject(self, &touchExtendInsetKey, [NSValue valueWithUIEdgeInsets:kj_touchExtendInset], OBJC_ASSOCIATION_RETAIN);
}

- (UIEdgeInsets)kj_touchExtendInset {
    return [objc_getAssociatedObject(self, &touchExtendInsetKey) UIEdgeInsetsValue];
}



/*********************** Block ************************/
static char ActionTag;
/** button 添加点击事件 默认点击方式UIControlEventTouchUpInside */
- (void)kj_addAction:(KJButtonBlock)block {
    objc_setAssociatedObject(self, &ActionTag, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
}

/** button 添加事件 controlEvents 点击的方式 */
- (void)kj_addAction:(KJButtonBlock)block forControlEvents:(UIControlEvents)controlEvents {
    objc_setAssociatedObject(self, &ActionTag, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(action:) forControlEvents:controlEvents];
}

/** button 事件的响应方法 */
- (void)action:(id)sender {
    KJButtonBlock blockAction = (KJButtonBlock)objc_getAssociatedObject(self, &ActionTag);
    if (blockAction) {
        blockAction(self);
    }
}
@end
