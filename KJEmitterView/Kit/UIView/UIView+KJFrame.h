//
//  UIView+KJFrame.h
//  CategoryDemo
//
//  Created by 杨科军 on 2018/7/12.
//  Copyright © 2018年 杨科军. All rights reserved.
//  一套轻量级布局

#import <UIKit/UIKit.h>

// 弱引用
#ifndef kWeakObject
#if DEBUG
#if __has_feature(objc_arc)
#define kWeakObject(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define kWeakObject(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define kWeakObject(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define kWeakObject(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef kStrongObject
#if DEBUG
#if __has_feature(objc_arc)
#define kStrongObject(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define kStrongObject(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define kStrongObject(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define kStrongObject(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif


@interface UIView (KJFrame)

@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;
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

/*********************** 布局相关 ***************************/
/// 需要注意的是 兼容含子父关系的view布局要求，布局需要先添加view再进行布局
/** centerX等于View的centerX */
- (void(^)(UIView *view))kj_centerXEqualToView;
/** centerY等于View的centerY */
- (void(^)(UIView *view))kj_centerYEqualToView;
/** center等于View的center */
- (void(^)(UIView *view))kj_centerEqualToView;
/** left等于View的left */
- (void(^)(UIView *view))kj_leftEqualToView;
/** right等于View的right */
- (void(^)(UIView *view))kj_rightEqualToView;
/** top等于View的top */
- (void(^)(UIView *view))kj_topEqualToView;
/** bottom等于View的bottom */
- (void(^)(UIView *view))kj_bottomEqualToView;

@end

