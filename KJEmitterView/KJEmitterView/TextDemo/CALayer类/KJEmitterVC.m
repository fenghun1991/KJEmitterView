//
//  KJEmitterVC.m
//  KJEmitterView
//
//  Created by 杨科军 on 2018/12/1.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJEmitterVC.h"
#import "KJEmitterView.h"

@interface KJEmitterVC ()

@end

@implementation KJEmitterVC
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    /// 重置
    [self.navigationController.navigationBar kj_reset];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.kj_BackgroundColor = [UIColor.whiteColor colorWithAlphaComponent:0.3];

    [KJEmitterView createEmitterViewWithType:(KJEmitterTypeStarrySky) Block:^(KJEmitterView *obj) {
        obj.KJFrame(self.view.bounds).KJAddView(self.view).KJBackgroundColor(UIColor.blackColor);
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
