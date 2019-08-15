//
//  UIView+KJFrame.h
//  CategoryDemo
//
//  Created by 杨科军 on 2018/7/12.
//  Copyright © 2018年 杨科军. All rights reserved.
//  一套轻量级布局

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface UIView (KJFrame)
//右边距离
@property(nonatomic,assign) CGFloat right;
//底部
@property(nonatomic,assign) CGFloat bottom;
//x坐标属性
@property (nonatomic,assign)CGFloat x;
//y坐标
@property (nonatomic,assign)CGFloat y;
//宽度
@property (nonatomic,assign)CGFloat width;
//高度
@property (nonatomic,assign)CGFloat height;
//大小
@property (nonatomic,assign)CGSize size;
//位置
@property (nonatomic,assign)CGPoint origin;
//中心点x
@property (nonatomic,assign)CGFloat centerX;
//中心点y
@property (nonatomic,assign)CGFloat centerY;
/** x + width */
@property (nonatomic,assign)CGFloat maxX;
/** y + height */
@property (nonatomic,assign)CGFloat maxY;

@end
NS_ASSUME_NONNULL_END
