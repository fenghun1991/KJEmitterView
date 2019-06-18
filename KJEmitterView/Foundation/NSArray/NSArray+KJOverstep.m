//
//  NSArray+Overstep.m
//  MoLiao
//
//  Created by 杨科军 on 2018/8/28.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "NSArray+KJOverstep.h"
#import <objc/runtime.h>

@implementation NSArray (KJOverstep)

+ (void)load {
    // 利用GCD只执行一次，防止多线程问题
    static dispatch_once_t onceToken;
    // 调用原方法以及新方法进行交换，处理崩溃问题。
    dispatch_once(&onceToken, ^{
        // 获得不可变数组objectAtIndex的selector
        SEL A_sel = @selector(objectAtIndex:);
        // 自己实现的将要被交换的方法的selector
        SEL B_sel = @selector(kj_objectAtIndex:);
        // 两个方法的Method
        Method A_Method = class_getInstanceMethod(objc_getClass("__NSArrayI"), A_sel);
        // 自己实现的将要被交换的方法的selector
        Method B_Method = class_getInstanceMethod(objc_getClass("__NSArrayI"), B_sel);
        
        // 首先动态添加方法，实现是被交换的方法，返回值表示添加成功还是失败
        BOOL isAdd = class_addMethod(self, A_sel, method_getImplementation(B_Method), method_getTypeEncoding(B_Method));
        if (isAdd) {
            // 如果成功，说明类中不存在这个方法的实现
            // 将被交换方法的实现替换到这个并不存在的实现
            class_replaceMethod(self, B_sel, method_getImplementation(A_Method), method_getTypeEncoding(A_Method));
        }else{
            // 否则，交换两个方法的实现
            method_exchangeImplementations(A_Method, B_Method);
        }
    });
    
}

- (id)kj_objectAtIndex:(NSUInteger)index{
    if (index < self.count) {
        // 这时候调用自己，看起来像是死循环
        // 但是其实自己的实现已经被替换了
        return [self kj_objectAtIndex:index];
    }
    return nil; // 越界返回为nil
}

@end

@implementation NSMutableArray (Overstep)

+ (void)load {
    // 利用GCD只执行一次，防止多线程问题
    static dispatch_once_t onceToken;
    // 调用原方法以及新方法进行交换，处理崩溃问题。
    dispatch_once(&onceToken, ^{
        Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:));
        Method toMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(kj_objectAtIndex:));
        method_exchangeImplementations(fromMethod, toMethod);
    });
}

- (id)kj_objectAtIndex:(NSUInteger)index {
    if (self.count - 1 < index) {
        @try {
            return [self kj_objectAtIndex:index];
        }
        @catch (NSException *exception) {
            //            NSLog(@"-------- %s Crash Because Method %s -------\n",class_getName(self.class),__func__);
            //            NSLog(@"%@", [exception callStackSymbols]);
            return nil;
        }
        @finally {
            
        }
    }else {
        return [self kj_objectAtIndex:index];
    }
}


@end

