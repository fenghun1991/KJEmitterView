//
//  KJMenuCollectionVC.m
//  KJEmitterView
//
//  Created by 杨科军 on 2018/12/13.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJMenuCollectionVC.h"
#import "KJBoardPlayModel.h"
#import "KJBoardPlayCell.h"

@implementation KJMenuCollectionVC

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self _setPlayView];
}

- (void)_setPlayView{
    CGFloat bottom_sp = 9;
    CGFloat bottom_w = (kScreenW-3*bottom_sp-30-40)/4;
    CGFloat bottom_h = 109;
    
    KJMenuCollectionView *view = [KJMenuCollectionView createMenuCollectionViewWithItemClass:[KJBoardPlayCell class] Block:^(KJMenuCollectionView *obj) {
        obj.KJFrame(CGRectMake(20, 200, kScreenW-40, 200)).KJAddView(self.view).KJBackgroundColor(UIColor.yellowColor);
    }];
    view.kj_minimumLineSpacing = bottom_sp;
    view.kj_itemSize = CGSizeMake(bottom_w, bottom_h);
    view.kj_sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    view.kj_textSize = 13;
    view.kj_bgColor = UIColorHexFromRGB(0xeeeeee);
    view.kj_textColor = UIColorHexFromRGB(0x9d87ef);
    view.kj_maxPopDistance = 65;
    view.kj_dissplayTitle = @"显示更多";
    
    /// 显示
    [view kj_showCollectionView];
    
    NSMutableArray *arr = [NSMutableArray array];
    NSArray *bottom_nameArr = @[@"地点1",@"地点2",@"地点3",@"地点4",@"地点5",@"地点6",@"地点7"];
    NSArray *bottom_numArr = @[@"1/3",@"2/5",@"3/3",@"1/4",@"2/5",@"3/3",@"1/4"];
    NSArray *bottom_imageArr = @[@"badahu",@"zuqiu",@"pikaqiu",@"zuqiu",@"pikaqiu",@"badahu",@"pikaqiu"];
    
    for (NSInteger i=0; i<bottom_numArr.count; i++) {
        KJBoardPlayModel *obj = [[KJBoardPlayModel alloc]init];
        obj.imageString = bottom_imageArr[i];
        obj.placeString = bottom_nameArr[i];
        obj.numString = bottom_numArr[i];
        [arr addObject:obj];
    }
    view.dataArray = arr;
    
    view.ScrollBottomBlock = ^{
        NSLog(@"123567");
    };
}


@end
