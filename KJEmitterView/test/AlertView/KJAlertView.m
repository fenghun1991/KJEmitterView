//
//  KJAlertView.m
//  MoLiao
//
//  Created by 杨科军 on 2018/7/25.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJAlertView.h"

#define UIColorFromHEXA(hex,a)    [UIColor colorWithRed:((hex&0xFF0000)>>16)/255.0f green:((hex&0xFF00)>>8)/255.0f blue:(hex&0xFF)/255.0f alpha:a]
#define SystemFontSize(fontsize)  [UIFont systemFontOfSize:(fontsize)]

// 判断是否为iPhone X 系列  这样写消除了在Xcode10上的警告。
#define iPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})
// 屏幕总尺寸
#define kScreenWidth        [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight       [[UIScreen mainScreen] bounds].size.height
// 没有tabar 距 底边高度
#define kBOTTOM_SPACE_HEIGHT (iPhoneX?34.0f:0.0f)

@interface KJAlertView ()<UITableViewDelegate,UITableViewDataSource>{
    __block CGFloat bottomHeader;
}

@property (nonatomic, strong) NSString   *title;// 提示标题
@property (nonatomic, strong) NSString   *contentStr;// 提示内容
@property (nonatomic, strong) NSArray    *titleArray;// 按钮标题数组


@property (nonatomic, strong) UIButton     *bgView;
@property (nonatomic, strong) UIView       *centerView;
@property (nonatomic, strong) UITableView  *bottomView;

@end

@implementation KJAlertView

- (void)_config{
    bottomHeader = 0.1;
    self.lineColor = UIColorFromHEXA(0xeeeeee, 1);
    self.spaceColor = UIColorFromHEXA(0xe8e8e8, 1);
    self.centerViewColor = [UIColor whiteColor];
    self.bottomViewColor = UIColor.whiteColor;
    self.cancleColor = [UIColor redColor];
    self.textColor = UIColor.blueColor;
    self.titleColor = UIColor.blackColor;
    
    self.backgroundColor = UIColorFromHEXA(0x333333, 0.3);
}

- (instancetype)initWithTitle:(NSString *)title Content:(NSString *)contentStr whitTitleArray:(NSArray *)titleArray withType:(NSString *)type{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.title = title;
        self.contentStr = contentStr;
        self.titleArray = titleArray;
        self.type = type;
        
        [self _config];
        
        [self setUI];
    }
    return self;
}

- (void)setUI{
    if (self.titleArray == nil || self.type == nil) {
        return;
    }
    [self addSubview:self.bgView];
    
    if ([self.type isEqualToString:@"center"]) {
        [self createAlertViewCenter];
    }
    else if ([self.type isEqualToString:@"bottom"]){
        [self createAlertViewBottom];
    }
}

//获取字符串大小
- (CGRect)getStringFrame:(NSString *)str withFont:(NSInteger)fontSize withMaxSize:(CGSize)size{
    CGRect rect = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:SystemFontSize(fontSize)} context:nil];
    return rect;
}

#pragma mark - AlertViewCenter
- (void)createAlertViewCenter {
    _centerView = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth-(270))/2, (kScreenHeight-(120))/2, (270), (120))];
    _centerView.backgroundColor = self.centerViewColor;
    _centerView.layer.masksToBounds = YES;
    _centerView.layer.cornerRadius = (10);
    [_bgView addSubview:_centerView];
    
    CGFloat titleHeight;
    CGFloat contentLabY;
    
    if ([self.title isEqualToString:@""] || self.title == nil) {
        titleHeight = 0;
        contentLabY = (25);
    }
    else{
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake((20), (15), _centerView.width-(20)*2, 20)];
        titleLab.text = self.title;
        titleLab.textColor = self.titleColor;
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.font = [UIFont systemFontOfSize:(16)];
        [_centerView addSubview:titleLab];
        
        titleHeight = titleLab.frame.size.height;
        contentLabY = titleLab.frame.origin.y + titleLab.frame.size.height+(10);
    }
    
    CGRect rect = [self getStringFrame:self.contentStr withFont:15 withMaxSize:CGSizeMake(_centerView.width-(20)*2, MAXFLOAT)];
    UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake((_centerView.width-rect.size.width)/2, contentLabY, rect.size.width, rect.size.height)];
    contentLab.text = self.contentStr;
    contentLab.textColor = self.textColor;
    contentLab.textAlignment = NSTextAlignmentCenter;
    contentLab.font = SystemFontSize(15);
    contentLab.numberOfLines = 0;
    [_centerView addSubview:contentLab];
    
    UIImageView *imageLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, contentLab.y+contentLab.height+(25)-0.5, kScreenWidth, 0.5)];
    imageLine.backgroundColor = self.lineColor;
    [_centerView addSubview:imageLine];
    
    for (int i = 0; i < self.titleArray.count; i ++) {
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        titleBtn.tag = 2000+i;
        titleBtn.backgroundColor = [UIColor clearColor];
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleBtn setTitle:self.titleArray[i] forState:UIControlStateNormal];
        titleBtn.titleLabel.font = SystemFontSize(15);
        
        if (self.titleArray.count == 1) {
            titleBtn.frame = CGRectMake(_centerView.width/self.titleArray.count*i, contentLab.y+contentLab.height+(25), _centerView.width, (45));
            [titleBtn setTitleColor:self.textColor forState:UIControlStateNormal];
        }
        else{
            titleBtn.frame = CGRectMake(_centerView.width/self.titleArray.count*i, contentLab.y+contentLab.height+(25), _centerView.width/self.titleArray.count-0.5, (45));
            if (i == 0) {
                [titleBtn setTitleColor:self.cancleColor forState:UIControlStateNormal];
            }
            else{
                [titleBtn setTitleColor:self.textColor forState:UIControlStateNormal];
                
                UIImageView *centerLine = [[UIImageView alloc] initWithFrame:CGRectMake(_centerView.width/self.titleArray.count*i-0.5, titleBtn.y, 0.5, titleBtn.height)];
                centerLine.backgroundColor = self.lineColor;
                [_centerView addSubview:centerLine];
            }
            
            if (self.titleArray.count > 2) {
                [titleBtn setTitleColor:self.textColor forState:UIControlStateNormal];
            }
        }
        
        [_centerView addSubview:titleBtn];
    }
    
    _centerView.frame = CGRectMake((kScreenWidth-(270))/2, (kScreenHeight-(120))/2, (270), contentLab.y+contentLab.height+(25)+(45));
}


#pragma mark - AlertViewBottom
- (void)createAlertViewBottom{
    if ([self.title isEqualToString:@""] || self.title == nil) {
        bottomHeader = 0.1;
    }
    else{
        bottomHeader = (50);
    }
    _bottomView = [[UITableView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, self.titleArray.count*(50)+(10)+kBOTTOM_SPACE_HEIGHT+bottomHeader) style:UITableViewStyleGrouped];
    _bottomView.delegate = self;
    _bottomView.dataSource = self;
    _bottomView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _bottomView.scrollEnabled = NO;
    _bottomView.backgroundColor = self.spaceColor;
    [_bgView addSubview:_bottomView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.titleArray.count-1;
    }
    else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.backgroundColor = self.bottomViewColor;
    }
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-(150))/2, ((50)-(15))/2, (150), (15))];
    titleLab.font = SystemFontSize(15);
    titleLab.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:titleLab];
    
    if (indexPath.section == 0) {
        titleLab.text = self.titleArray[indexPath.row];
        titleLab.textColor = self.textColor;
    }
    else{
        titleLab.text = [self.titleArray lastObject];
        titleLab.textColor = self.cancleColor;
    }
    
    UIImageView *imageLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, (50)-0.5, kScreenWidth, 0.5)];
    imageLine.backgroundColor = self.lineColor;
    [cell.contentView addSubview:imageLine];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (50);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return bottomHeader;
    }
    else{
        return (10);
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section==0) {
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, (50))];
        titleLab.text = self.title;
        titleLab.backgroundColor = [self.bottomViewColor colorWithAlphaComponent:0.8];
        titleLab.textColor = self.titleColor;
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.font = SystemFontSize(15);
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(2, (50), kScreenWidth-4, 1)];
        line.backgroundColor = [self.bottomViewColor colorWithAlphaComponent:0.9];
        [titleLab addSubview:line];
        return titleLab;
    }else{
        return nil;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.myBlock) {
        
        [self dissmis];
        
        if (indexPath.section == 0) {
            self.myBlock(indexPath.row);
        }
        else{
            self.myBlock(self.titleArray.count-1);
        }
    }
    
    [self dissmis];
}

#pragma mark - 公用方法
- (void)show{
    if ([self.type isEqualToString:@"center"]) {
        UIWindow *window = [UIApplication sharedApplication].windows[0];
        [window addSubview:self];
        [self exChangeOut:_centerView dur:0.5];
    }
    else if ([self.type isEqualToString:@"bottom"]){
        UIWindow *window = [UIApplication sharedApplication].windows[0];
        [window addSubview:self];
        __weak typeof(self)weakself = self;
        [UIView animateWithDuration:0.25 animations:^{
            weakself.bottomView.frame = CGRectMake(0, kScreenHeight - weakself.titleArray.count * (50) - (10) - kBOTTOM_SPACE_HEIGHT - self->bottomHeader, kScreenWidth, weakself.titleArray.count * (50) + (10) + kBOTTOM_SPACE_HEIGHT + self->bottomHeader);
        }];
    }
}

- (void)dissmis{
    if ([self.type isEqualToString:@"center"]) {
        [self removeFromSuperview];
    }
    else if ([self.type isEqualToString:@"bottom"]){
        __weak typeof(self)weakself = self;
        [UIView animateWithDuration:0.25 animations:^{
            weakself.bottomView.frame = CGRectMake(0, kScreenHeight, kScreenHeight, self.titleArray.count*(50)+(10)+kBOTTOM_SPACE_HEIGHT);
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

- (void)titleBtnClick:(UIButton *)btn{
    if (self.myBlock) {
        self.myBlock(btn.tag-2000);
    }
    [self dissmis];
}

- (void)showAlertView:(alertBlock)myBlock{
    [self show];
    self.myBlock = myBlock;
}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [UIButton buttonWithType:UIButtonTypeCustom];
        _bgView.frame = [UIScreen mainScreen].bounds;
        [_bgView addTarget:self action:@selector(butChack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgView;
}

- (void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = dur;
    //animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    [changeOutView.layer addAnimation:animation forKey:nil];
}

- (void)butChack{
    [self removeFromSuperview];
}

-(void)dissmissView{
    [self removeFromSuperview];
    if (self.myBlock){
        self.myBlock(0);
    }
}

@end

