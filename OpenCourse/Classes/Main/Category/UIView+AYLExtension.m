//
//  UIView+Extension.m
//  OpenCourse
//
//  Created by Oneself on 16/6/1.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "UIView+AYLExtension.h"

@implementation UIView (AYLExtension)

/**
 *  get or set view's location.
 */
/* get or set view's x & y */
- (CGFloat)ayl_centerX {
    return self.center.x;
}
- (void)setAyl_centerX:(CGFloat)ayl_centerX {
    CGPoint center = self.center;
    center.x = ayl_centerX;
    self.center = center;
}
- (CGFloat)ayl_centerY {
    return self.center.y;
}
- (void)setAyl_centerY:(CGFloat)ayl_centerY {
    CGPoint center = self.center;
    center.y = ayl_centerY;
    self.center = center;
}
- (CGFloat)ayl_x {
    return self.frame.origin.x;
}
- (void)setAyl_x:(CGFloat)ayl_x {
    CGRect frame = self.frame;
    frame.origin.x = ayl_x;
    self.frame = frame;
}
- (CGFloat)ayl_y {
    return self.frame.origin.y;
}
- (void)setAyl_y:(CGFloat)ayl_y {
    CGRect frame = self.frame;
    frame.origin.y = ayl_y;
    self.frame = frame;
}
- (CGPoint)ayl_orign {
    return self.frame.origin;
}
- (void)setAyl_orign:(CGPoint)ayl_orign {
    CGRect frame = self.frame;
    frame.origin = ayl_orign;
    self.frame = frame;
}
/* get or set view's left & right & top & button. */
- (CGFloat)ayl_left {
    return self.ayl_x;
}
- (void)setAyl_left:(CGFloat)ayl_left {
    self.ayl_x = ayl_left;
}
- (CGFloat)ayl_right {
    return self.ayl_x + self.ayl_width;
}
- (void)setAyl_right:(CGFloat)ayl_right {
    self.ayl_x = ayl_right - self.ayl_width;
}
- (CGFloat)ayl_top {
    return self.ayl_y;
}
- (void)setAyl_top:(CGFloat)ayl_top {
    self.ayl_y = ayl_top;
}
- (CGFloat)ayl_bottom {
    return self.ayl_y + self.ayl_height;
}
- (void)setAyl_bottom:(CGFloat)ayl_bottom {
    self.ayl_y = ayl_bottom - self.ayl_height;
}

/**
 *  get or set view's size.
 */
- (CGFloat)ayl_width {
    return self.ayl_size.width;
}
- (void)setAyl_width:(CGFloat)ayl_width {
    CGRect frame = self.frame;
    frame.size.width = ayl_width;
    self.frame = frame;
}
- (CGFloat)ayl_height {
    return self.ayl_size.height;
}
- (void)setAyl_height:(CGFloat)ayl_height {
    CGRect frame = self.frame;
    frame.size.height = ayl_height;
    self.frame = frame;
}
- (CGSize)ayl_size {
    return self.frame.size;
}
- (void)setAyl_size:(CGSize)ayl_size {
    CGRect frame = self.frame;
    frame.size = ayl_size;
    self.frame = frame;
}

/**
 *  set view's style.
 */
- (void)ayl_circleView {
    [self ayl_circularBeadViewWithRadius:self.ayl_width / 2];
}
- (void)ayl_circularBeadViewWithRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}
- (void)ayl_setBackgroundImageWithImageName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    self.layer.contents = (id)image.CGImage;
}

/**
 *  get a specific view.
 */
+ (AYLDivider *)ayl_divider {
    return [[AYLDivider alloc] init];
}

@end
