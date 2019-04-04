//
//  UIView+KJFrame.m
//  CategoryDemo
//
//  Created by 杨科军 on 2018/7/12.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "UIView+KJFrame.h"

@implementation UIView (KJFrame)

@dynamic bottom,right,maxX,maxY;

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size{
    return self.frame.size;
}
//origin属性的get,set,用于设置坐标
- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin.x = origin.x;
    frame.origin.y = origin.y;
    self.frame = frame;
}
- (CGPoint)origin{
    return self.frame.origin;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY{
    return self.center.y;
}

- (CGFloat)centerX{
    return self.center.x;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (CGFloat)x{
    return self.frame.origin.x;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (CGFloat)right{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)bottom{
    return self.frame.origin.y + self.frame.size.height;
}


- (CGFloat)maxX{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)maxY{
    return self.frame.origin.y + self.frame.size.height;
}

#pragma mark - equalToView
- (void(^)(UIView *view))kj_centerXEqualToView{
    @kWeakObject(self);
    return ^(UIView *view){
        @kStrongObject(self);
        /// 如果是子父关系
        if ([self.superview isKindOfClass:[view class]]) {
            self.center = CGPointMake(view.center.x - view.x, self.center.y);
        }else{
            self.center = CGPointMake(view.center.x, self.center.y);
        }
    };
}

- (void(^)(UIView *view))kj_centerYEqualToView{
    @kWeakObject(self);
    return ^(UIView *view){
        @kStrongObject(self);
        if ([self.superview isKindOfClass:[view class]]) {
            self.center = CGPointMake(self.center.x, view.center.y - view.y);
        }else{
            self.center = CGPointMake(self.center.x, view.center.y);
        }
    };
}

- (void(^)(UIView *view))kj_centerEqualToView{
    @kWeakObject(self);
    return ^(UIView *view){
        @kStrongObject(self);
        if ([self.superview isKindOfClass:[view class]]) {
            self.center = CGPointMake(view.center.x - view.x , view.center.y - view.y);
        }else{
            self.center = view.center;
        }
    };
}

- (void(^)(UIView *view))kj_leftEqualToView{
    @kWeakObject(self);
    return ^(UIView *view){
        @kStrongObject(self);
        if ([self.superview isKindOfClass:[view class]]) {
            self.center = CGPointMake(view.center.x - view.x,self.center.y);
            self.x = self.centerX - view.width/2;
        }else{
            self.x = view.x;
        }
    };
}

- (void(^)(UIView *view))kj_rightEqualToView{
    @kWeakObject(self);
    return ^(UIView *view){
        @kStrongObject(self);
        if ([self.superview isKindOfClass:[view class]]) {
            self.center = CGPointMake(view.center.x - view.x,self.center.y);
            self.maxX = self.centerX + view.width/2;
        }else{
            self.maxX = view.maxX;
        }
    };
}

- (void(^)(UIView *view))kj_topEqualToView{
    @kWeakObject(self);
    return ^(UIView *view){
        @kStrongObject(self);
        if ([self.superview isKindOfClass:[view class]]) {
            self.center = CGPointMake(self.center.x,view.center.y - view.y);
            self.y = self.centerY - view.height/2;
        }else{
            self.y = view.y;
        }
    };
}


- (void(^)(UIView *view))kj_bottomEqualToView{
    @kWeakObject(self);
    return ^(UIView *view){
        @kStrongObject(self);
        if ([self.superview isKindOfClass:[view class]]) {
            self.center = CGPointMake(self.center.x,view.center.y - view.y);
            self.maxY = self.centerY + view.height/2;
        }else{
            self.maxY = view.maxY;
        }
    };
}

@end
