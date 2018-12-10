//
//  KJAlertView.h
//  MoLiao
//
//  Created by 杨科军 on 2018/7/25.
//  Copyright © 2018年 杨科军. All rights reserved.
//  提示,确认框

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, KJAlertViewType){
    KJAlertViewTypeCenter     = 0,  // 中间位置
    KJAlertViewTypeBottom     = 1,  // 底部位置
};

typedef void(^KJAlertBlock)(NSInteger index);

@interface KJAlertView : UIView

/// 初始化
+ (instancetype)createAlertViewWithType:(KJAlertViewType)type Title:(NSString *)title Content:(NSString *)content DataArray:(NSArray *)array Block:(void(^)(KJAlertView *obj))objblock AlertBlock:(KJAlertBlock)block;

/// 移出
- (void)kj_Dissmiss;

/// 必须View相关的属性
@property(nonatomic,strong,readonly) KJAlertView *(^KJTag)(NSInteger);
@property(nonatomic,strong,readonly) KJAlertView *(^KJAddView)(UIView *);
@property(nonatomic,strong,readonly) KJAlertView *(^KJBackgroundColor)(UIColor *);//backgroundColor


/************************** 颜色属性，以下属性均有默认值 **************************/
/// 公共颜色属性
@property(nonatomic,strong,readonly) KJAlertView *(^KJComColor)(UIColor *lineColor,UIColor *titleColor,UIColor *textColor,UIColor *cancleColor);

/// Center
@property(nonatomic,strong,readonly) KJAlertView *(^KJCenterColor)(UIColor *centerViewColor);

/// Bottom
@property(nonatomic,strong,readonly) KJAlertView *(^KJBottomColor)(UIColor *bottomViewColor,UIColor *spaceColor);

@end
