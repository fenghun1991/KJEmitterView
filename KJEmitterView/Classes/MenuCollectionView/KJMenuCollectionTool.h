//
//  KJMenuCollectionTool.h
//  iSchool
//
//  Created by 杨科军 on 2018/12/13.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KJMenuCollectionTool : UIView

/** 加载更多的背景色 */
@property (strong, nonatomic)UIColor *brColor;
/** 加载更多字体的背景色 */
@property (strong, nonatomic)UIColor *textColor;
/** 加载更多字体的大小 */
@property (assign, nonatomic)CGFloat textSize;

/// 初始化方法   kj_title:显示文字
- (instancetype)initWithFrame:(CGRect)frame withDissplayTitle:(NSString *)kj_title;
/** 中心点坐标 */
@property (assign, nonatomic)CGPoint controlPoint;

@end
