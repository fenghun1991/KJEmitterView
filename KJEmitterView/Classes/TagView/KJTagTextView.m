//
//  KJTagTextView.m
//  AAA
//
//  Created by 杨科军 on 2018/7/25.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJTagTextView.h"

@interface KJTagTextView (){
    __block CGFloat width,height;
    CGFloat textFont;
    CGFloat marginX,marginY,word_h;
    UIColor *textColor,*tagLayerColor,*tagBGColor;
}

@property(nonatomic,strong) UIScrollView *scroll;

@end

@implementation KJTagTextView

- (void)config{
    textFont = 14;// 字体大小
    marginX = 10; // 左右间距
    marginY = 10; // 上下间距
    word_h = 30;  // 高度
    textColor = UIColor.blackColor;
    tagBGColor = UIColor.whiteColor;
    tagLayerColor = UIColor.blueColor;
}

// 初始化
+ (instancetype)createTagTextViewWithType:(KJTagTextViewType)type TagArray:(NSArray*)array Block:(void(^)(KJTagTextView *obj))block{
    KJTagTextView *obj = [[self alloc] init];
    
    [obj config];
    
    if (block) {
        block(obj);
    }
    
    [obj setUI];
    
    [obj _setSubviewWithTagArray:array];
    
    return obj;
}

- (void)setUI{
    [self addSubview:self.scroll];
}

- (void)_setSubviewWithTagArray:(NSArray*)nameArray{
    CGFloat word_w = 0;   // 宽度
    NSInteger con = 1;
    UIButton *markBtn;
    for (int i = 0; i < nameArray.count; i++) {
        NSString *tagName = nameArray[i];
        word_w = [self calculateString:tagName Width:textFont] + word_h;
        UIButton *tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (!markBtn) {
            tagBtn.frame = CGRectMake(marginX, marginY, word_w, word_h);
        }else{
            if (markBtn.frame.origin.x + markBtn.frame.size.width + marginX + word_w + marginX > width) {
                tagBtn.frame = CGRectMake(marginX, markBtn.frame.origin.y + markBtn.frame.size.height + marginY, word_w, word_h);
                con ++;
            }else{
                tagBtn.frame = CGRectMake(markBtn.frame.origin.x + markBtn.frame.size.width + marginX, markBtn.frame.origin.y, word_w, word_h);
            }
        }
        tagBtn.backgroundColor = tagBGColor;
        [tagBtn setTitle:tagName forState:UIControlStateNormal];
        tagBtn.titleLabel.font = [UIFont systemFontOfSize:textFont];
        [tagBtn setTitleColor:textColor forState:UIControlStateNormal];
        tagBtn.layer.masksToBounds = YES;
        tagBtn.layer.borderWidth = 1;
        tagBtn.layer.borderColor = tagLayerColor.CGColor;
        tagBtn.layer.cornerRadius = 5;
        markBtn = tagBtn;
        tagBtn.tag = 520 + i;
        [tagBtn addTarget:self action:@selector(clickTo:) forControlEvents:UIControlEventTouchUpInside];
        [self.scroll addSubview:markBtn];
    }
    // 设置滚动区域
    CGFloat sh = (word_h + marginY)*con + marginY;
    sh = sh > height ? sh : height;
    self.scroll.contentSize = CGSizeMake(width, sh);
}

-(void)clickTo:(UIButton *)sender{
    if (self.Block) {
        self.Block(sender.tag-520);
    }
}

#pragma mark - 获取文字宽度
- (CGFloat)calculateString:(NSString *)str Width:(NSInteger)font{
    CGSize size = [str boundingRectWithSize:CGSizeMake(self.frame.size.width, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil].size;
    return size.width;
}

#pragma mark - lazzing
- (UIScrollView*)scroll{
    if (!_scroll) {
        _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        _scroll.backgroundColor = self.backgroundColor;
    }
    return _scroll;
}
#pragma mark - 链接编程设置View的一些属性
- (KJTagTextView *(^)(CGRect))KJFrame {
    return ^(CGRect frame) {
        self.frame = frame;
        self->width = frame.size.width;
        self->height = frame.size.height;
        return self;
    };
}
- (KJTagTextView *(^)(UIColor *))KJBackgroundColor {
    return ^(UIColor *color) {
        self.backgroundColor = color;
        return self;
    };
}
- (KJTagTextView *(^)(NSInteger))KJTag {
    return ^(NSInteger tag){
        self.tag = tag;
        return self;
    };
}
- (KJTagTextView *(^)(UIView*))KJAddView {
    return ^(UIView *superView){
        [superView addSubview:self];
        return self;
    };
}

/// 以下属性均有默认值
- (KJTagTextView *(^)(CGFloat textFont,CGFloat marginX,CGFloat marginY,CGFloat wordH))KJTagSize {
    return ^(CGFloat textFont,CGFloat marginX,CGFloat marginY,CGFloat wordH){
        if (textFont) {
            self->textFont = textFont;
        }
        if (marginX) {
            self->marginX = marginX;
        }
        if (marginY) {
            self->marginY = marginY;
        }
        if (wordH) {
            self->word_h = wordH;
        }
        return self;
    };
}

- (KJTagTextView *(^)(UIColor *layerColor,UIColor *bgColor,UIColor *textColor))KJTagColor {
    return ^(UIColor *layerColor,UIColor *bgColor,UIColor *textColor){
        if (layerColor) {
            self->tagLayerColor = layerColor;
        }
        if (bgColor) {
            self->tagBGColor = bgColor;
        }
        if (textColor) {        
            self->textColor = textColor;
        }
        return self;
    };
}

@end
