//
//  UIView+Extension.h
//  OpenCourse
//
//  Created by Oneself on 16/6/1.
//  Copyright © 2016年 CCUT. All rights reserved.
//

typedef UIView AYLDivider;

@interface UIView (AYLExtension)

@property (nonatomic, assign) CGFloat ayl_centerX;
@property (nonatomic, assign) CGFloat ayl_centerY;
@property (nonatomic, assign) CGFloat ayl_x;
@property (nonatomic, assign) CGFloat ayl_y;
@property (nonatomic, assign) CGPoint ayl_orign;

@property (nonatomic, assign) CGFloat ayl_left;
@property (nonatomic, assign) CGFloat ayl_right;
@property (nonatomic, assign) CGFloat ayl_top;
@property (nonatomic, assign) CGFloat ayl_bottom;

@property (nonatomic, assign) CGFloat ayl_width;
@property (nonatomic, assign) CGFloat ayl_height;
@property (nonatomic, assign) CGSize ayl_size;

- (void)ayl_circleView;
- (void)ayl_circularBeadViewWithRadius:(CGFloat)radius;

+ (AYLDivider *)ayl_divider;

@end
