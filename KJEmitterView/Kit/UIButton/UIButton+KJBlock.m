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
