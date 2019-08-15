//
//  UIView+KJGestureBlock.m
//  KJEmitterView
//
//  Created by 杨科军 on 2019/6/4.
//  Copyright © 2019 杨科军. All rights reserved.
//  

#import "UIView+KJGestureBlock.h"
#import <objc/runtime.h>

static const char *KJGestureBlockKey;
@implementation UIView (KJGestureBlock)
- (UIGestureRecognizer *)kj_AddGestureRecognizer:(KJGestureType)type block:(KJGestureRecognizerBlock)block{
    self.userInteractionEnabled = YES; /// 开启可交互
    if (block) {
        NSDictionary *dic = @{@"0":@"UITapGestureRecognizer",
                              @"1":@"UILongPressGestureRecognizer",
                              @"2":@"UISwipeGestureRecognizer",
                              @"3":@"UIPanGestureRecognizer",
                              @"4":@"UIRotationGestureRecognizer",
                              @"5":@"UIPinchGestureRecognizer"};
        NSString *string = dic[@(type).stringValue];
        UIGestureRecognizer *gesture = [[NSClassFromString(string) alloc] initWithTarget:self action:@selector(gestureAction:)];
        [self addGestureRecognizer:gesture];
        NSMutableDictionary *blockDic = objc_getAssociatedObject(self, KJGestureBlockKey);
        if (!blockDic) {
            blockDic = @{}.mutableCopy;
            objc_setAssociatedObject(self, KJGestureBlockKey, blockDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        [blockDic setObject:block forKey:string];
        return gesture;
    }
    return nil;
}

- (void)gestureAction:(UIGestureRecognizer *)gesture{
    NSMutableDictionary *blockDic = objc_getAssociatedObject(gesture.view, KJGestureBlockKey);
    KJGestureRecognizerBlock block = blockDic[NSStringFromClass([gesture class])];
    !block?:block(gesture.view, gesture);
}

/// 单击手势
- (UIGestureRecognizer *)kj_AddTapGestureRecognizerBlock:(KJGestureRecognizerBlock)block{
    return [self kj_AddGestureRecognizer:KJGestureTypeTap block:^(UIView * _Nonnull view, UIGestureRecognizer * _Nonnull gesture) {
        !block?:block(view,gesture);
    }];
}

@end
