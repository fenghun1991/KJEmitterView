//
//  NSString+KJStringDebug.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/6/18.
//  Copyright © 2019 杨科军. All rights reserved.
//  解决字典 或者 数组 每次都崩溃到 Main函数，无法定位到位置的问题

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KJStringDebug)
#if DEBUG // 调试模式

- (void)objectForKey:(NSString*)str;
- (void)objectAtIndex:(NSInteger)intergaer;

#endif

@end

NS_ASSUME_NONNULL_END
