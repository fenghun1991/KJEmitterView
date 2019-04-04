//
//  UILabel+KJAttributedString.m
//  KJEmitterView
//
//  Created by 杨科军 on 2019/4/4.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "UILabel+KJAttributedString.h"

@implementation UILabel (KJAttributedString)

- (void)kj_AttributedStringTextFont:(UIFont *)font Range:(NSRange)range{
    [self kj_AttributedStringTextAttributes:@{NSFontAttributeName:font} Range:range];
}

- (void)kj_AttributedStringTextColor:(UIColor *)color Range:(NSRange)range{
    [self kj_AttributedStringTextAttributes:@{NSForegroundColorAttributeName:color} Range:range];
}

- (void)kj_AttributedStringTextLineSpace:(CGFloat)space Range:(NSRange)range{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    self.attributedText = attributedString;
    [self sizeToFit];
}

- (void)kj_AttributedStringTextFont:(UIFont *)font TextColor:(UIColor *)color Range:(NSRange)range{
    [self kj_AttributedStringTextAttributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:color} Range:range];
}

- (void)kj_AttributedStringTextAttributes:(NSDictionary *)attributes Range:(NSRange)range{
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    for (NSString *name in attributes){
        [mutableAttributedString addAttribute:name value:[attributes objectForKey:name] range:range];
    }
    self.attributedText = mutableAttributedString;
}

@end

