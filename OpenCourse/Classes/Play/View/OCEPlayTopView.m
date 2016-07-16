//
//  OCEPlayTopView.m
//  OpenCourse
//
//  Created by Oneself on 16/7/13.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCEPlayTopView.h"

@interface OCEPlayTopView()

@end

@implementation OCEPlayTopView

- (instancetype)init {
    if (self = [super init]) {
        UIView *statusBarBackground = [[UIView alloc] init];
        statusBarBackground.backgroundColor = [UIColor blackColor];
        self.statusBarBackground = statusBarBackground;
        [self addSubview:statusBarBackground];
        
        self.playView = [[UIView alloc] init];
        [self addSubview:self.playView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat statusBarBackgroundHeight = AYLStatusBarHeight;
    self.statusBarBackground.frame = CGRectMake(0, 0, self.ayl_width, AYLStatusBarHeight);
    
    self.playView.frame = CGRectMake(0, statusBarBackgroundHeight, self.statusBarBackground.ayl_width, self.ayl_height - statusBarBackgroundHeight);
}

@end
