//
//  KJMenuCollectionView.h
//  iSchool
//
//  Created by 杨科军 on 2018/12/13.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KJMenuCollectionViewCell.h"

@interface KJMenuCollectionView : UIView

// 初始化 - 所有使用该方法的 CollectionCell 都必须继承 KJMenuCollectionViewCell
+ (instancetype)createMenuCollectionViewWithItemClass:(Class)itemClass Block:(void(^)(KJMenuCollectionView *obj))block;

/// 相关参数传递完毕之后，展示
- (void)kj_showCollectionView;

/// 滚动到底部
@property(nonatomic,readwrite,copy) void(^ScrollBottomBlock)(void);

/// 点击index
@property(nonatomic,readwrite,copy) void(^ClickIndexBlock)(NSInteger index);

/// 数据源
@property(nonatomic,strong) NSArray *dataArray;

/***************** Item相关属性 ****************************/
/// 滚动方向  默认水平方向
@property(nonatomic,assign) UICollectionViewScrollDirection kj_direction;
/// 行间距(左右之间的间距) 默认为0
@property(nonatomic,assign) CGFloat kj_minimumLineSpacing;
/// 列间距(上下之间的间距) 默认为0
@property(nonatomic,assign) CGFloat kj_minimumInteritemSpacing;
/// Item尺寸 默认为10
@property(nonatomic,assign) CGSize kj_itemSize;
/// 外框间距 默认为0
@property(nonatomic,assign) UIEdgeInsets kj_sectionInset;

/***************** 右边加载更多相关属性 ****************************/
/// 显示文字
@property(nonatomic,strong) NSString *kj_dissplayTitle;
/// 右边加载更多的最大距离 默认30
@property(nonatomic,assign) CGFloat kj_maxPopDistance;
/// 右边加载更多的距离 默认10
@property(nonatomic,assign) CGFloat kj_popDistance;
/// 加载更多的背景色 默认白色
@property (strong, nonatomic)UIColor *kj_bgColor;
/// 加载更多字体的背景色 默认黑色
@property (strong, nonatomic)UIColor *kj_textColor;
/// 加载更多字体的大小  默认12
@property (assign, nonatomic)CGFloat kj_textSize;


// 必须设置相关属性，tag除外
@property(nonatomic,strong,readonly) KJMenuCollectionView *(^KJTag)(NSInteger);
@property(nonatomic,strong,readonly) KJMenuCollectionView *(^KJFrame)(CGRect);//frame
@property(nonatomic,strong,readonly) KJMenuCollectionView *(^KJBackgroundColor)(UIColor *);//backgroundColor
@property(nonatomic,strong,readonly) KJMenuCollectionView *(^KJAddView)(UIView *);

@end

