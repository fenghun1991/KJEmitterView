//
//  KJAlertView.h
//  MoLiao
//
//  Created by 杨科军 on 2018/7/25.
//  Copyright © 2018年 杨科军. All rights reserved.
//  提示,确认框

#import <UIKit/UIKit.h>

typedef void(^alertBlock)(NSInteger index);

@interface KJAlertView : UIView

@property (nonatomic, copy) alertBlock myBlock;
@property (nonatomic, strong) NSString *type;

//*****************  颜色相关  *******************
@property(nonatomic,strong) UIColor *lineColor;  // 线颜色
@property(nonatomic,strong) UIColor *cancleColor;  // 取消颜色
@property(nonatomic,strong) UIColor *titleColor;   // 标题颜色
@property(nonatomic,strong) UIColor *textColor;    // 文字颜色
// center
@property(nonatomic,strong) UIColor *centerViewColor;  // 视图颜色

// bottom
@property(nonatomic,strong) UIColor *bottomViewColor;  // 视图颜色
@property(nonatomic,strong) UIColor *spaceColor;   // 间隙颜色

- (instancetype)initWithTitle:(NSString *)title Content:(NSString *)contentStr whitTitleArray:(NSArray *)titleArray withType:(NSString *)type;

- (void)showAlertView:(alertBlock)myBlock;

- (void)dissmis;

@end
