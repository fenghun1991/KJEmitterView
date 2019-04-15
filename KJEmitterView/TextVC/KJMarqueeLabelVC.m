//
//  KJMarqueeLabelVC.m
//  KJEmitterView
//
//  Created by 杨科军 on 2019/4/14.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "KJMarqueeLabelVC.h"

@interface KJMarqueeLabelVC ()

@end

@implementation KJMarqueeLabelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    KJMarqueeLabel *animatedLabel = [[KJMarqueeLabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    animatedLabel.center = self.view.center;
    animatedLabel.backgroundColor = UIColor.blueColor;
    animatedLabel.textColor = UIColor.whiteColor;
    animatedLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:animatedLabel];
    [animatedLabel animateWithWords:@[@"KJButtonVC",
                                      @"KJViewVC",
                                      @"KJTextViewVC",
                                      @"KJFloodImageVC",
                                      @"KJEmitterVC",
                                      @"KJErrorVC"
                                      ]
                        forDuration:1.0f withAnimation:KJAnimationLabelTypeSlideTopInBottomOut];
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
