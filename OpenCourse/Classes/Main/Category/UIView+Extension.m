//
//  UIView+Extension.m
//  OpenCourse
//
//  Created by Oneself on 16/6/1.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "UIView+Extension.h"

// views之间的间距
const CGFloat kUIViewExtensionViewMargin = 5;

@implementation UIView (Extension)

// *************************
- (CGFloat)centerX {
    return self.center.x;
}
- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)centerY {
    return self.center.y;
}
- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (CGFloat)x {
    return self.frame.origin.x;
}
- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)y {
    return self.frame.origin.y;
}
- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGPoint)orign {
    return self.frame.origin;
}
- (void)setOrign:(CGPoint)orign {
    CGRect frame = self.frame;
    frame.origin = orign;
    self.frame = frame;
}

// *************************
- (CGFloat)left {
    return self.x;
}
- (void)setLeft:(CGFloat)left {
    self.x = left;
}
- (CGFloat)right {
    return self.x + self.width;
}
- (void)setRight:(CGFloat)right {
    self.x = right - self.width;
}
- (CGFloat)top {
    return self.y;
}
- (void)setTop:(CGFloat)top {
    self.y = top;
}
- (CGFloat)bottom {
    return self.y + self.height;
}
- (void)setBottom:(CGFloat)bottom {
    self.y = bottom - self.height;
}

// *************************
- (CGFloat)width {
    return self.size.width;
}
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)height {
    return self.size.height;
}
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGSize)size {
    return self.frame.size;
}
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

// *************************
- (void)circleView {
    [self circularBeadViewWithRadius:self.width / 2];
}

- (void)circularBeadViewWithRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

@end
