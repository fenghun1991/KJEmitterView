//
//  KJHeader.h
//  KJEmitterDemo
//
//  Created by 杨科军 on 2018/11/26.
//  Copyright © 2018 杨科军. All rights reserved.
//
/*
 Github地址：https://github.com/yangKJ
 简书地址：https://www.jianshu.com/u/c84c00476ab6
 博客地址：https://blog.csdn.net/qq_34534179
 */

#ifndef KJHeader_h
#define KJHeader_h

// 项目打包上线都不会打印日志，因此可放心。
#ifdef DEBUG
#define KJLog(s, ... ) NSLog( @"[%@ in line %d] 😎😎 =====>%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define KJLog(s, ... )
#endif

/******************* UIKit ******************************/
#import "KJEmitterView.h"    // 粒子效果
#import "KJErrorView.h"      // 错误效果
#import "KJAlertView.h"      // 提示选择框
#import "KJTagTextView.h"    // 标签

/******************* Category ******************************/
#import "UIButton+KJIndicator.h"
#import "UIButton+KJButtonContentLayout.h"  // 图文混排

#import "UIView+KJXib.h"   // Xib
#import "UIView+KJFrame.h" // Frame
#import "UIView+KJRectCorner.h" // 切圆角

#import "UINavigationBar+KJExtension.h" // 设置NavigationBar背景
#import "UIBarButtonItem+KJExtension.h" // 设置BarButtonItem

#import "UITextView+KJPlaceHolder.h"  // 输入框扩展
#import "UITextView+KJLimitCounter.h" // 限制字数

#import "UIImage+KJFloodFill.h" /// 图片泛洪算法
#import "UIImage+KJFrame.h"     /// 处理图片尺寸相关
#import "UIImage+KJFilter.h"    /// 处理图片滤镜，渲染相关

/******************* Foundation ******************************/
#import "NSArray+KJLog.h"
#import "NSDictionary+KJLog.h"  /// Xcode控制台打印中文问题，调试模式打印

#endif /* KJHeader_h */
