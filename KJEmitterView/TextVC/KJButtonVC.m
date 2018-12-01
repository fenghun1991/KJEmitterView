//
//  KJButtonVC.m
//  KJEmitterView
//
//  Created by 杨科军 on 2018/12/1.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJButtonVC.h"

@interface KJButtonVC ()

@property(nonatomic, strong)UIButton *button;

@end

@implementation KJButtonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.button];
     
//    [self.button kj_showIndicator];
}

- (void)getVerificationCode{
    self.button.enabled = NO; // 关闭触发
    
    [self settingRunBtn:self.button]; // 设置倒计时中的颜色
    
    // 开始发起倒计时
    [self.button kj_CountDownWithTimeInterval:10 CountDownFormat:@"%zd秒后重试"];
    __weak typeof(self) weakSelf = self;
    // 倒计时结束后的Block回调
    self.button.kj_ButtonTimeStoppedCallback = ^{
        weakSelf.button.enabled = YES; // 设置启用触发
        
        [weakSelf settingBtn:weakSelf.button]; // 设置初始的颜色等
        NSLog(@"倒计时完毕");
    };
}

- (void)settingRunBtn:(UIButton *)sender{
    sender.backgroundColor = UIColor.lightGrayColor;
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sender.layer.borderColor = [[UIColor blackColor] CGColor];
}

- (void)settingBtn:(UIButton *)sender{
    UIColor *iosSystemBlue = UIColor.blueColor;
    sender.backgroundColor = [UIColor clearColor];
    sender.layer.borderColor = [iosSystemBlue CGColor];
    [sender setTitleColor:iosSystemBlue forState:UIControlStateNormal];
    [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
}

#pragma mark - 懒加载区
- (UIButton *)button{
    if (!_button) {
        _button = [[UIButton alloc] init];
        _button.frame = CGRectMake(0, 0, 200, 50);
        _button.center = self.view.center;
        
        _button.layer.borderWidth = 1;
        _button.layer.masksToBounds = YES;
        _button.layer.cornerRadius = 5;
        _button.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [_button addTarget:self action:@selector(getVerificationCode) forControlEvents:UIControlEventTouchUpInside];
        [self settingBtn:_button];
    }
    return _button;
}

@end
