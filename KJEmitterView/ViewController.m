//
//  ViewController.m
//  KJEmitterView
//
//  Created by 杨科军 on 2018/11/26.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *MainTable;
@property(nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic, strong) NSArray *sectionTitleArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.MainTable];
}

#pragma mark - 代理区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionTitleArray.count;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *Arr = self.dataArray[section];
    return Arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"abc"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"abc"];
    }
    NSArray *Arr = self.dataArray[indexPath.section];
    NSDictionary *dic = Arr[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%zi. %@",indexPath.row + 1,dic[@"VCName"]];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = UIColor.redColor;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.detailTextLabel.text = dic[@"describeName"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    cell.detailTextLabel.textColor = UIColor.purpleColor;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *Arr = self.dataArray[indexPath.section];
    NSDictionary *dic = Arr[indexPath.row];
    Class class = NSClassFromString(dic[@"VCName"]);
    BaseViewController *vc = [[class alloc]init];
    vc.title = dic[@"describeName"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.sectionTitleArray[section];
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.textAlignment = NSTextAlignmentCenter;
    header.textLabel.textColor = UIColor.blackColor;
    header.textLabel.font = [UIFont systemFontOfSize:14];
}
#pragma mark - 懒加载
- (UITableView *)MainTable{
    if (!_MainTable) {
        _MainTable = [[UITableView alloc]initWithFrame:self.view.frame];
        _MainTable.delegate = self;
        _MainTable.dataSource = self;
    }
    return _MainTable;
}

- (NSArray *)sectionTitleArray{
    if (!_sectionTitleArray) {
        _sectionTitleArray = @[@"扩展类",@"CALayer类",@"自定义控件"];
    }
    return _sectionTitleArray;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        NSMutableArray *Group1 = [NSMutableArray array];
        [Group1 addObject:@{@"VCName":@"KJButtonVC",@"describeName":@"Button图文布局"}];
        [Group1 addObject:@{@"VCName":@"KJViewVC",@"describeName":@"View快速切圆角"}];
        [Group1 addObject:@{@"VCName":@"KJTextViewVC",@"describeName":@"TextView设置限制字数"}];
        [Group1 addObject:@{@"VCName":@"KJFloodImageVC",@"describeName":@"填充同颜色区域图片"}];
        
        NSMutableArray *Group2 = [NSMutableArray array];
        [Group2 addObject:@{@"VCName":@"KJEmitterVC",@"describeName":@"粒子效果"}];
        [Group2 addObject:@{@"VCName":@"KJErrorVC",@"describeName":@"错误提示效果"}];
        
        NSMutableArray *Group3 = [NSMutableArray array];
        [Group3 addObject:@{@"VCName":@"KJAlertVC",@"describeName":@"两种AlertView"}];
        [Group3 addObject:@{@"VCName":@"KJSelectController",@"describeName":@"自定义一款动画选中控件"}];
        [Group3 addObject:@{@"VCName":@"KJSwitchVC",@"describeName":@"自定义一款可爱的动画Switch控件"}];
        [Group3 addObject:@{@"VCName":@"KJMarqueeLabelVC",@"describeName":@"一款跑马灯Label"}];
        [_dataArray addObject:Group1];
        [_dataArray addObject:Group2];
        [_dataArray addObject:Group3];
    }
    return _dataArray;
}


@end
