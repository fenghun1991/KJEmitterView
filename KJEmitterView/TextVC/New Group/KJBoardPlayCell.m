//
//  KJBoardPlayCell.m
//  iSchool
//
//  Created by 杨科军 on 2018/12/13.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJBoardPlayCell.h"
#import "KJBoardPlayModel.h"

@interface KJBoardPlayCell ()

@property (nonatomic , readwrite , weak) UIImageView *imageView;
@property (nonatomic , readwrite , weak) UILabel *label;
@property (nonatomic , readwrite , weak) UILabel *num_label;

@end

@implementation KJBoardPlayCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self _setSubview];
    }
    return self;
}

- (void)setModel:(NSObject *)model{
    KJBoardPlayModel *m = (KJBoardPlayModel*)model;
    self.imageView.image = [UIImage imageNamed:m.imageString];
    _label.text = m.placeString;
    _num_label.text = m.numString;
}

- (void)_setSubview{
    self.contentView.backgroundColor = UIColor.whiteColor;
//    [KJTools makeCornerRadius:3 borderColor:nil layer:self.contentView.layer borderWidth:0];
    
    CGFloat bottom_w = self.contentView.frame.size.width;
    UIImageView *imageView = [[UIImageView alloc]init];
    self.imageView = imageView;
    imageView.frame = CGRectMake(12, 4, bottom_w-24, bottom_w-24);
    
//    [KJTools makeCornerRadius:5 borderColor:nil layer:imageView.layer borderWidth:0];
    [self.contentView addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] init];
    self.label = label;
    label.frame = CGRectMake(0, 0, bottom_w, 11);
    label.center = CGPointMake(imageView.center.x, imageView.bottom+14);
    label.textAlignment = NSTextAlignmentCenter;
    
    label.font = SystemFontSize(11);
    label.textColor = UIColorHexFromRGB(0x666666);
    [self.contentView addSubview:label];
    
    UILabel *num_label = [[UILabel alloc] init];
    self.num_label = num_label;
    num_label.frame = CGRectMake(0, 0, bottom_w-26, 15);
    num_label.center = CGPointMake(imageView.center.x, label.bottom+14);
//    [KJTools makeCornerRadius:7.5 borderColor:nil layer:num_label.layer borderWidth:0];
    num_label.textAlignment = NSTextAlignmentCenter;
    num_label.font = SystemFontSize(11);
    num_label.textColor = UIColorHexFromRGB(0xffffff);
    num_label.backgroundColor = UIColorHexFromRGB(0x8dcbf2);
    [self.contentView addSubview:num_label];
}

@end
