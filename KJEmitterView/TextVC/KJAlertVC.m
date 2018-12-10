//
//  KJAlertViewController.m
//  KJEmitterView
//
//  Created by 杨科军 on 2018/12/2.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJAlertVC.h"
#import "KJAlertView.h"      // 
@interface KJAlertVC ()

@end

@implementation KJAlertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)ClickCenter:(UIButton *)sender {
    [KJAlertView createAlertViewWithType:(KJAlertViewTypeCenter) Title:nil Content:@"是否清理缓存" DataArray:@[@"取消",@"确定"] Block:^(KJAlertView *obj) {
//        obj.KJCenterColor(UIColor.redColor);
    } AlertBlock:^(NSInteger index) {
        KJLog(@"%ld",index);
    }];
}
- (IBAction)ClickBottom:(UIButton *)sender {
    [KJAlertView createAlertViewWithType:(KJAlertViewTypeBottom) Title:@"Name" Content:nil DataArray:@[@"拍照",@"相册选择",@"取消"] Block:^(KJAlertView *obj) {
        obj.KJAddView([[UIApplication sharedApplication] keyWindow]);
    } AlertBlock:^(NSInteger index) {
        KJLog(@"%ld",index);
    }];
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
