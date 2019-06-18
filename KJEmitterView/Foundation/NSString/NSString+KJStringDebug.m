//
//  NSString+KJStringDebug.m
//  KJEmitterView
//
//  Created by 杨科军 on 2019/6/18.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "NSString+KJStringDebug.h"

@implementation NSString (KJStringDebug)
#if DEBUG // 调试模式

- (void)objectForKey:(NSString*)str{
    assert(NO);
}
- (void)objectAtIndex:(NSInteger)intergaer{
    assert(NO);
}

#endif

@end
