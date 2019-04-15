//
//  KJButtonVC2.m
//  KJEmitterView
//
//  Created by 杨科军 on 2018/12/1.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJButtonVC.h"

@interface KJButtonVC ()
@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong)NSArray *segmentedTitleArray;
@property(nonatomic,strong)NSArray *NameArray;
@property(nonatomic,strong)NSMutableArray <UILabel *>*labelArray;

@end

@implementation KJButtonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.button];
    
    [self createSegmented];
}
// 重写SET传值，需要在图文元素确定后才能设置布局，之后参数即可动态调整
- (void)clicksegmented:(UISegmentedControl *)sender{    // 两排控制布局的选择器
    NSInteger tag = sender.tag - 100;
    NSArray *arr = self.segmentedTitleArray[tag];
    switch (tag) {
        case 0:
            self.button.kj_ButtonContentLayoutType = sender.selectedSegmentIndex;
            [self.button setTitle:arr[sender.selectedSegmentIndex] forState:UIControlStateNormal];
        break;
        case 1:
            self.button.kj_ButtonContentLayoutType = sender.selectedSegmentIndex + 4;
            [self.button setTitle:arr[sender.selectedSegmentIndex] forState:UIControlStateNormal];
        break;
        default: break;
    }
}
- (void)slidingSlider:(UISlider *)sender{
    NSInteger tag = sender.tag - 100;
    switch (tag) {
            case 2:
            self.button.kj_Padding = sender.value;
            [self.labelArray objectAtIndex:0].text = [NSString stringWithFormat: @"%@：\t%.0f",self.NameArray[tag], sender.value];
            break;
            case 3:
            self.button.kj_PaddingInset = sender.value;
            [self.labelArray objectAtIndex:1].text = [NSString stringWithFormat: @"%@：\t%.0f",self.NameArray[tag], sender.value];
            break;
        default: break;
    }
}



#pragma mark - 懒加载区
- (UIButton *)button{
    if (!_button) {
        UIColor *iosSystemBlue = [UIColor colorWithRed:0.0f green:0.49f blue:0.96f alpha:1.0f];
        _button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-150, 80)];
        _button.center = CGPointMake(SCREEN_WIDTH/2, 180);
        _button.backgroundColor = UIColor.whiteColor;
        _button.layer.borderWidth = 1;
        _button.layer.borderColor = [iosSystemBlue CGColor];
        _button.layer.masksToBounds = YES;
        _button.layer.cornerRadius = 5;
        _button.titleLabel.font = [UIFont systemFontOfSize:14];
        [_button setTitleColor:iosSystemBlue forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_button setImage:[UIImage imageNamed:@"wode_nor"] forState:UIControlStateNormal];
        // 设置初始参数
        _button.kj_ButtonContentLayoutType = KJButtonContentLayoutStyleNormal;
        [_button setTitle:@"居中-图左文右" forState:UIControlStateNormal];
    }
    return _button;
}

- (void)createSegmented{
    NSArray *defaultParameters = @[@"",@"",@"0",@"5"];
    
    for (int i = 0; i < 4; i ++) {
        CGFloat width = 150;
        CGFloat Y = i * 40 + self.button.frame.origin.y + CGRectGetHeight(self.button.frame) + 50;
        if (i < self.segmentedTitleArray.count) {
            UISegmentedControl *segmented = [[UISegmentedControl alloc] initWithItems:self.segmentedTitleArray[i]];
            segmented.frame = CGRectMake(10, Y + i*10, SCREEN_WIDTH - 20, 40);
            segmented.tag = 100 + i;
            segmented.momentary = YES;
            UIFont *font = [UIFont boldSystemFontOfSize:12];
            NSDictionary *attributes = @{NSFontAttributeName:font};
            [segmented setTitleTextAttributes:attributes forState:UIControlStateNormal];
            [segmented addTarget:self action:@selector(clicksegmented:) forControlEvents:UIControlEventValueChanged];
            [self.view addSubview:segmented];
        }
        
        if (i >= 2) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, Y+30, width, 30)];
            label.text = self.NameArray[i];
            label.textColor = UIColor.blueColor;
            label.font = [UIFont systemFontOfSize:14];
            [self.view addSubview:label];
            [self.labelArray addObject:label];
            
            UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(width + 30,Y+30, SCREEN_WIDTH - (width + 40), 30)];
            [slider addTarget:self action:@selector(slidingSlider:)
             forControlEvents:UIControlEventValueChanged];
            slider.minimumValue = 0;
            slider.maximumValue = 30;
            slider.value = [defaultParameters[i] floatValue];
            slider.tag = i + 100;
            [self.view addSubview:slider];
            label.text =  [NSString stringWithFormat:@"%@:\t%@",self.NameArray[i],defaultParameters[i]];
        }
    }
}
- (NSArray *)NameArray{
    if (!_NameArray) {
        _NameArray = @[@"",@"",@"图文间距",@"图文边界间距"];
    }
    return _NameArray;
}
- (NSMutableArray *)labelArray{
    if (!_labelArray) {
        _labelArray = [NSMutableArray array];
    }
    return _labelArray;
}
- (NSArray *)segmentedTitleArray{
    if (!_segmentedTitleArray) {
        _segmentedTitleArray = @[@[@"居中-图左文右",@"居中-图右文左",@"居中-图上文下",@"居中-图下文上"],
                                 @[@"居左-图左文右",@"居左-图右文左",@"居右-图左文右",@"居右-图右文左"]];
    }
    return _segmentedTitleArray;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

