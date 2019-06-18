//
//  NSArray+Overstep.m
//  MoLiao
//
//  Created by 杨科军 on 2018/8/28.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "NSArray+KJOverstep.h"
#import "NSObject+KJSwizzling.h"

@implementation NSArray (KJOverstep)

+ (void)load {
    static dispatch_once_t onceToken;
    //调用原方法以及新方法进行交换，处理崩溃问题。
    dispatch_once(&onceToken, ^{
        //越界崩溃方式一：[array objectAtIndex:1000];
        [objc_getClass("__NSArrayI") swizzleSelector:@selector(objectAtIndex:)
                                withSwizzledSelector:@selector(safeObjectAtIndex:)];
        
        //越界崩溃方式二：arr[1000];   Subscript n:下标、脚注
        [objc_getClass("__NSArrayI") swizzleSelector:@selector(objectAtIndexedSubscript:)
                                withSwizzledSelector:@selector(safeobjectAtIndexedSubscript:)];
    });
}
- (instancetype)safeObjectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        // 这时候调用自己，看起来像是死循环
        // 但是其实自己的实现已经被替换了
        return [self safeObjectAtIndex:index];
    }
    NSLog(@"数组越界错误");
    return nil; // 越界返回为nil
}

- (instancetype)safeobjectAtIndexedSubscript:(NSUInteger)index{
    if (index < self.count) {
        // 这时候调用自己，看起来像是死循环
        // 但是其实自己的实现已经被替换了
        return [self safeobjectAtIndexedSubscript:index];
    }
    NSLog(@"数组越界错误");
    return nil; // 越界返回为nil
}
@end

@implementation NSMutableArray (Overstep)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //1、提示移除的数据不能为空
        [self swizzleSelector:@selector(removeObject:)
         withSwizzledSelector:@selector(kj_safeRemoveObject:)];
        
        //2、提示数组不能添加为nil的数据
        [objc_getClass("__NSArrayM") swizzleSelector:@selector(addObject:)
                                withSwizzledSelector:@selector(kj_safeAddObject:)];
        //3、移除数据越界
        [objc_getClass("__NSArrayM") swizzleSelector:@selector(removeObjectAtIndex:)
                                withSwizzledSelector:@selector(kj_safeRemoveObjectAtIndex:)];
        //4、插入数据越界
        [objc_getClass("__NSArrayM") swizzleSelector:@selector(insertObject:atIndex:)
                                withSwizzledSelector:@selector(kj_insertObject:atIndex:)];
        
        //5、处理[arr objectAtIndex:1000]这样的越界
        [objc_getClass("__NSArrayM") swizzleSelector:@selector(objectAtIndex:)
                                withSwizzledSelector:@selector(kj_objectAtIndex:)];
        
        //6、处理arr[1000]这样的越界
        [objc_getClass("__NSArrayM") swizzleSelector:@selector(objectAtIndexedSubscript:)
                                withSwizzledSelector:@selector(kj_safeobjectAtIndexedSubscript:)];
        
        //7、替换某个数据越界
        [objc_getClass("__NSArrayM") swizzleSelector:@selector(replaceObjectAtIndex:withObject:)
                                withSwizzledSelector:@selector(kj_safereplaceObjectAtIndex:withObject:)];
        
        //8、添加数据中有nil的情况，剔除掉nil
        [objc_getClass("__NSPlaceholderArray") swizzleSelector:@selector(initWithObjects:count:)
                                          withSwizzledSelector:@selector(kj_initWithObjects:count:)];
    });
}

- (instancetype)kj_initWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt {
    BOOL hasNilObject = NO;
    for (NSUInteger i = 0; i < cnt; i++) {
        if ([objects[i] isKindOfClass:[NSArray class]]) {
            NSLog(@"%@", objects[i]);
        }
        if (objects[i] == nil) {
            hasNilObject = YES;
            /*   __FUNCTION__    输出当前方法   */
            NSLog(@"%s object at index %lu is nil, it will be filtered", __FUNCTION__, i);
        }
    }
    
    // 因为有值为nil的元素，那么我们可以过滤掉值为nil的元素
    if (hasNilObject) {
        id __unsafe_unretained newObjects[cnt];
        NSUInteger index = 0;
        for (NSUInteger i = 0; i < cnt; ++i) {
            if (objects[i] != nil) {
                newObjects[index++] = objects[i];
            }
        }
        NSLog(@"%@", [NSThread callStackSymbols]);
        return [self kj_initWithObjects:newObjects count:index];
    }
    return [self kj_initWithObjects:objects count:cnt];
}

- (void)kj_safeAddObject:(id)obj {
    if (obj == nil) {
        NSLog(@"%s can add nil object into NSMutableArray", __FUNCTION__);
    } else {
        [self kj_safeAddObject:obj];
    }
}

- (void)kj_safeRemoveObject:(id)obj {
    if (obj == nil) {
        NSLog(@"%s call -removeObject:, but argument obj is nil", __FUNCTION__);
        return;
    }
    [self kj_safeRemoveObject:obj];
}

- (void)kj_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject == nil) {
        NSLog(@"%s can't insert nil into NSMutableArray", __FUNCTION__);
    } else if (index > self.count) {
        NSLog(@"%s index is invalid", __FUNCTION__);
    } else {
        [self kj_insertObject:anObject atIndex:index];
    }
}

- (id)kj_objectAtIndex:(NSUInteger)index {
    if (self.count == 0) {
        NSLog(@"%s can't get any object from an empty array", __FUNCTION__);
        return nil;
    }
    if (index > self.count) {
        NSLog(@"%s index out of bounds in array", __FUNCTION__);
        return nil;
    }
    return [self kj_objectAtIndex:index];
}

- (void)kj_safeRemoveObjectAtIndex:(NSUInteger)index {
    if (self.count <= 0) {
        NSLog(@"%s can't get any object from an empty array", __FUNCTION__);
        return;
    }
    
    if (index >= self.count) {
        NSLog(@"%s index out of bound", __FUNCTION__);
        return;
    }
    [self kj_safeRemoveObjectAtIndex:index];
}

// 1、索引越界 2、移除索引越界 3、替换索引越界
- (instancetype)kj_safeobjectAtIndexedSubscript:(NSUInteger)index{
    if (index > (self.count - 1)) { // 数组越界
        NSLog(@"索引越界");
        return nil;
    }else { // 没有越界
        return [self kj_safeobjectAtIndexedSubscript:index];
    }
    
}

- (instancetype)kj_safereplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject{
    if (index > (self.count - 1)) { // 数组越界
        NSLog(@"移除索引越界");
        return nil;
    }else { // 没有越界
        return [self kj_safeobjectAtIndexedSubscript:index];
    }
}

//+ (void)load {
//    // 利用GCD只执行一次，防止多线程问题
//    static dispatch_once_t onceToken;
//    // 调用原方法以及新方法进行交换，处理崩溃问题。
//    dispatch_once(&onceToken, ^{
//        Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:));
//        Method toMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(safeObjectAtIndex:));
//        method_exchangeImplementations(fromMethod, toMethod);
//
//        Method methodAdd = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(addObject:));
//        Method _methodAdd = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(safeAddObject:));
//        method_exchangeImplementations(methodAdd, _methodAdd);
//    });
//}
//
//- (instancetype)safeObjectAtIndex:(NSUInteger)index {
//    if (index < self.count) {
//        return [self safeObjectAtIndex:index];
//    }else{
//        NSLog(@"NSMutableArray数组越界错误");
//        return nil; // 越界返回为nil
//        //            @try {
//        //                return [self safeObjectAtIndex:index];
//        //            }
//        //            @catch (NSException *exception) {
//        //                NSLog(@"-------- %s Crash Because Method %s -------\n",class_getName(self.class),__func__);
//        //                NSLog(@"%@", [exception callStackSymbols]);
//        //                return nil;
//        //            }
//        //            @finally {
//        //
//        //            }
//    }
//}
//
//- (void)safeAddObject:(id)obj{
//    if (obj) {
//        [self safeAddObject:obj];
//    }else{
//        NSLog(@"NSMutableArray数组添加空对象");
//    }
//}

@end


