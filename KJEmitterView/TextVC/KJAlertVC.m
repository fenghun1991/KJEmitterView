//
//  KJAlertViewController.m
//  KJEmitterView
//
//  Created by 杨科军 on 2018/12/2.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJAlertVC.h"

@interface KJAlertVC ()

@end

@implementation KJAlertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)ClickCenter:(UIButton *)sender {
    KJAlertView *view = [[KJAlertView alloc] initWithTitle:nil Content:@"是否清理缓存" whitTitleArray:@[@"取消",@"确定"] withType:@"center"];
    [view showAlertView:^(NSInteger index) {
        if (index == 1) {
            
        }
    }];
    [self.view addSubview:view];
}
- (IBAction)ClickBottom:(UIButton *)sender {
    KJAlertView *view = [[KJAlertView alloc] initWithTitle:@"Name" Content:nil whitTitleArray:@[@"拍照",@"相册选择",@"取消"] withType:@"bottom"];
    [view showAlertView:^(NSInteger index) {
        if (index == 0){ // 选择相机
            
        }
        else if (index == 1){ // 选择相册
            
        }
    }];
    [[[UIApplication sharedApplication] keyWindow] addSubview:view];
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
