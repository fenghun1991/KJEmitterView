//
//  UIButton+KJButtonCountDown.h
//  CategoryDemo
//
//  Created by 杨科军 on 2018/7/13.
//  Copyright © 2017年 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (KJButtonCountDown)

/**
 * 倒计时结束的回调
 */
@property (nonatomic, copy) void(^kj_ButtonTimeStoppedCallback)(void);

/**
 设置倒计时的间隔和倒计时文案

 @param duration 倒计时时间
 @param format 可选，传nil默认为 @"%zd秒"
 */
- (void)kj_CountDownWithTimeInterval:(NSTimeInterval)duration CountDownFormat:(NSString*)format;

/** 
 * invalidate timer
 */
- (void)kj_CancelTimer;

@end
