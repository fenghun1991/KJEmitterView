//
//  KJMenuCollectionTool.m
//  iSchool
//
//  Created by 杨科军 on 2018/12/13.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJMenuCollectionTool.h"

@interface KJMenuCollectionTool ()

@property(nonatomic,strong) UILabel *label;
@property(nonatomic,strong) NSString *labelText;

@end

@implementation KJMenuCollectionTool

- (instancetype)initWithFrame:(CGRect)frame withDissplayTitle:(NSString *)kj_title{
    self = [super initWithFrame:frame];
    if (self) {
        if (!kj_title) {
            kj_title = @"";
        }
        
        self.labelText = kj_title;
        _controlPoint = CGPointMake(self.frame.size.width, self.frame.size.height/2);
        [self creatSubViewControlPoint:_controlPoint];
    }
    return self;
}

#pragma mark - set
- (void)setControlPoint:(CGPoint)controlPoint{
    _controlPoint = controlPoint;
    [self creatSubViewControlPoint:_controlPoint];
}

#pragma mark - 内部方法
/// 给字符串的每个字后面加 换行符(\n)
- (NSString *)verticalString:(NSString *)text{
    NSMutableString * str = [[NSMutableString alloc] initWithString:text];
    NSInteger count = str.length;
    for (int i = 1; i < count; i ++) {
        [str insertString:@"\n" atIndex:i*2 - 1];
    }
    return str;
}

/// 绘制弧形曲线
- (void)creatSubViewControlPoint:(CGPoint)controlPoint{
    [self clearDisplayView];
    
    // 重新规划X的位置
    CGRect frame = self.label.frame;
    frame.origin.x = _controlPoint.x/3.0;
    self.label.frame = frame;
    
    //贝塞尔曲线的画法是由起点、终点、控制点三个参数来画的，为了解释清楚这个点，我写了几行代码来解释它
    CGPoint startPoint   = CGPointMake(self.frame.size.width, 0);
    CGPoint endPoint     = CGPointMake(self.frame.size.width, self.frame.size.height);
    
    CALayer *layer1 = [CALayer layer];
    layer1.frame = CGRectMake(startPoint.x, startPoint.y, 5, 5);
    
    CALayer *layer2 = [CALayer layer];
    layer2.frame = CGRectMake(endPoint.x, endPoint.y, 5, 5);
    
    CALayer *layer3 = [CALayer layer];
    layer3.frame = CGRectMake(_controlPoint.x, _controlPoint.y, 5, 5);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    [path moveToPoint:startPoint];
    [path addQuadCurveToPoint:endPoint controlPoint:_controlPoint];
    layer.path = path.CGPath;
    layer.fillColor = _brColor.CGColor;
    layer.strokeColor = _brColor.CGColor;
    
    [self.layer addSublayer:layer];
    [self.layer addSublayer:layer1];
    [self.layer addSublayer:layer2];
    [self.layer addSublayer:layer3];
}

/// 清除Layer
- (void)clearDisplayView{
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
}

#pragma mark - 布局
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self addSubview:self.label];
    
    NSString *verText = [self verticalString:self.labelText];
    self.label.textColor = _textColor;
    self.label.font = [UIFont systemFontOfSize:_textSize];
    self.label.text = verText;
}

- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 20, self.frame.size.height))];
        _label.numberOfLines = 0;
    }
    return _label;
}

@end
