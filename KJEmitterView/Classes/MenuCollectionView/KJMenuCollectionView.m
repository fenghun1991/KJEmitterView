//
//  KJMenuCollectionView.m
//  iSchool
//
//  Created by 杨科军 on 2018/12/13.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJMenuCollectionView.h"
#import "KJMenuCollectionTool.h"

@interface KJMenuCollectionView ()
<UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout,
UIScrollViewDelegate
>{
    NSString *class_name;
}

@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) UICollectionViewFlowLayout *flowLayout;

// 定义 KJMenuCollectionTool 对象
@property(nonatomic,strong) KJMenuCollectionTool *menuTool;
// 用来判断的一个字段(初始值赋为 1)
@property(nonatomic,strong) NSString *judge;

@property(nonatomic,strong) Class kj_itemClazz;

@end

@implementation KJMenuCollectionView

- (void)_config{
    self.kj_itemSize = CGSizeMake(10, 10);
    self.kj_sectionInset = UIEdgeInsetsMake(.0001f, .0001f, .0001f, .0001f);
    self.kj_minimumLineSpacing = 0;
    self.kj_minimumInteritemSpacing = 0;
    self.backgroundColor = UIColor.whiteColor;
    
    self.kj_maxPopDistance = 30;
    self.kj_popDistance = 10;
    
    self.kj_bgColor = UIColor.whiteColor;
    self.kj_textColor = UIColor.blackColor;
    self.kj_textSize = 12.f;
}

// 初始化
+ (instancetype)createMenuCollectionViewWithItemClass:(Class)itemClass Block:(void(^)(KJMenuCollectionView *obj))block{
    KJMenuCollectionView *obj = [[KJMenuCollectionView alloc] init];
    /// 默认信息
    [obj _config];
    
    if (block) {
        block(obj);
    }
    
    obj.kj_itemClazz = itemClass;
    
    return obj;
}

/// 相关参数传递完毕之后，展示
- (void)kj_showCollectionView{
    [self setUICollectionWithItemClass:self.kj_itemClazz];
}

#pragma mark - collection
- (void)setUICollectionWithItemClass:(Class)itemClass{
    //1.UICollectionViewFlowLayout的做布局
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    /**
     *  设置滑动方向
     *  UICollectionViewScrollDirectionHorizontal 水平方向
     *  UICollectionViewScrollDirectionVertical   垂直方向
     */
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout.sectionInset = _kj_sectionInset; /// Item间距
    _flowLayout.minimumLineSpacing = _kj_minimumLineSpacing; /// 行间距(左右之间的间距)
    _flowLayout.minimumInteritemSpacing = _kj_minimumInteritemSpacing; /// 列间距(上下之间的间距)
    
    //3.item的注册
    class_name = NSStringFromClass(itemClass);
    [self.collectionView registerClass:itemClass forCellWithReuseIdentifier:class_name];
    
    self.collectionView.frame = CGRectMake(0,0,self.frame.size.width,self.frame.size.height);
    [self addSubview:self.collectionView];
    
    /// 加载更多相关操作
    self.judge = @"1";
    self.menuTool = [[KJMenuCollectionTool alloc]initWithFrame:CGRectMake(self.frame.size.width, 0, 0, self.frame.size.height) withDissplayTitle:self.kj_dissplayTitle];
    self.menuTool.brColor = self.kj_bgColor;
    self.menuTool.textColor = self.kj_textColor;
    self.menuTool.textSize = self.kj_textSize;
    [self addSubview:self.menuTool];
}

/// 获取数据
- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self.collectionView reloadData];
}
#pragma mark - UICollectionViewDataSource
/* collection的段落 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
/* collection每个段落Item数目 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}
/* Item的宽高设置 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.kj_itemSize;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KJMenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:class_name forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.ClickIndexBlock) {
        self.ClickIndexBlock(indexPath.row);
    }
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = UIColor.clearColor;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

#pragma mark - 滑动的监听
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // scrollView的x偏移量
    double offsetX = scrollView.contentOffset.x;
    if (offsetX<=0) return;
    
    double scrollViewX = offsetX + self.frame.size.width;
    // collectionView的滚动范围的 width
    float collectionContentSizeWidth = scrollView.contentSize.width;
    // 防止在走加载全部再次走下面
    if([self.judge isEqualToString: @"1"]){
        self.judge = @"0";
        return;
    }
    
    if (scrollViewX > collectionContentSizeWidth) {
        self.kj_popDistance = (scrollViewX-collectionContentSizeWidth)*2;
        if (self.kj_popDistance >= self.kj_maxPopDistance) {
            self.kj_popDistance = self.kj_maxPopDistance;
        }
        self.menuTool.controlPoint = CGPointMake(self.menuTool.frame.size.width-self.kj_popDistance, self.menuTool.frame.size.height/2.0);
    }
}
#pragma mark - 松开手的操作
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if (targetContentOffset->x == 0) return;
    
    if (self.kj_popDistance == self.kj_maxPopDistance) {
        self.judge = @"1";
        self.kj_popDistance = 0;
        self.menuTool.controlPoint = CGPointMake(self.menuTool.frame.size.width-1, self.menuTool.frame.size.height/2.0);
        if (self.ScrollBottomBlock) {
            self.ScrollBottomBlock();
        }
    }
}

#pragma mark - 链接编程设置View的一些属性
- (KJMenuCollectionView *(^)(CGRect))KJFrame {
    return ^(CGRect frame) {
        self.frame = frame;
        return self;
    };
}
- (KJMenuCollectionView *(^)(UIColor *))KJBackgroundColor {
    return ^(UIColor *color) {
        self.backgroundColor = color;
        return self;
    };
}
- (KJMenuCollectionView *(^)(NSInteger))KJTag {
    return ^(NSInteger tag){
        self.tag = tag;
        return self;
    };
}
- (KJMenuCollectionView *(^)(UIView*))KJAddView {
    return ^(UIView *superView){
        [superView addSubview:self];
        return self;
    };
}


@end
