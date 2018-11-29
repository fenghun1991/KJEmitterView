//
//  ViewController.m
//  KJEmitterView
//
//  Created by 杨科军 on 2018/11/26.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "ViewController.h"
#import "KJHeader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [KJEmitterView createEmitterViewWithType:(KJEmitterTypeStarrySky) Block:^(KJEmitterView *obj) {
        obj.KJFrame(self.view.bounds).KJAddView(self.view).KJBackgroundColor(UIColor.blackColor);
    }];
}


@end
