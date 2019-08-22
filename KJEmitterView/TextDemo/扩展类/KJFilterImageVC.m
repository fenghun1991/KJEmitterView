//
//  KJFilterImageVC.m
//  KJEmitterView
//
//  Created by 杨科军 on 2019/8/22.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "KJFilterImageVC.h"
#import "UIImage+KJFilter.h"

@interface KJFilterImageVC ()
@property (weak, nonatomic) IBOutlet UIImageView *Image;
@property (weak, nonatomic) IBOutlet UIButton *Button;

@end

@implementation KJFilterImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    __block UIImage *image = self.Image.image;
    _weakself;
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (500 <= obj.tag && obj.tag <= 509) {
            UIButton *button = (UIButton*)obj;
            [button kj_addAction:^(UIButton * _Nonnull kButton) {
                switch (kButton.tag) {
                    case 500:
                        weakself.Image.image = [image kj_drawingWithMosaic];
                        break;
                    case 501:
                        weakself.Image.image = [image kj_drawingWithGaussianBlurNumber:.5];
                        break;
                    case 502:
                        weakself.Image.image = [image kj_drawingWithEdgeDetection];
                        break;
                    case 503:
                        weakself.Image.image = [image kj_drawingWithEmboss];
                        break;
                    case 504:
                        weakself.Image.image = [image kj_drawingWithSharpen];
                        break;
                    case 505:
                        weakself.Image.image = [image kj_drawingWithGrayImage];
                        break;
                    case 506:
                        weakself.Image.image = [image kj_drawingWithErodeIterations:5];
                        break;
                    case 507:
                        weakself.Image.image = [image kj_drawingWithGradientIterations:5];
                        break;
                    case 508:
                        weakself.Image.image = [image kj_drawingWithBlackhatIterations:5];
                        break;
                    case 509:
                        weakself.Image.image = [image kj_drawingWithEqualization];
                        break;
                    default:
                        break;
                }
            }];
        }
    }];
    [self.Button kj_addAction:^(UIButton * _Nonnull kButton) {
        weakself.Image.image = image;
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
