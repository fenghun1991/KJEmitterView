//
//  KJTagTextView.h
//  AAA
//
//  Created by 杨科军 on 2018/7/25.
//  Copyright © 2018年 杨科军. All rights reserved.
//  个性标签

#import <UIKit/UIKit.h>
typedef NS_ENUM (NSInteger, KJTagTextViewType){
    KJTagTextViewTypeLeft     = 0,  // 左对齐
};
typedef void(^KJTagTextViewBlock)(NSInteger index);

@interface KJTagTextView : UIView
// 初始化
+ (instancetype)createTagTextViewWithType:(KJTagTextViewType)type TagArray:(NSArray*)array Block:(void(^)(KJTagTextView *obj))block;

/// 点击回掉
@property (nonatomic, copy) KJTagTextViewBlock Block;

/// 以下属性均有默认值
@property(nonatomic,strong,readonly) KJTagTextView *(^KJTagSize)(CGFloat textFont,CGFloat marginX,CGFloat marginY,CGFloat wordH);
@property(nonatomic,strong,readonly) KJTagTextView *(^KJTagColor)(UIColor *layerColor,UIColor *bgColor,UIColor *textColor);

/// 必须View相关的属性
@property(nonatomic,strong,readonly) KJTagTextView *(^KJTag)(NSInteger);
@property(nonatomic,strong,readonly) KJTagTextView *(^KJFrame)(CGRect);//frame
@property(nonatomic,strong,readonly) KJTagTextView *(^KJBackgroundColor)(UIColor *);//backgroundColor
@property(nonatomic,strong,readonly) KJTagTextView *(^KJAddView)(UIView *);

@end
