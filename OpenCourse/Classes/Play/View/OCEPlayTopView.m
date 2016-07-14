//
//  OCEPlayTopView.m
//  OpenCourse
//
//  Created by Oneself on 16/7/13.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCEPlayTopView.h"
#import "OCEMediaControl.h"

@interface OCEPlayTopView()

@property (nonatomic, weak) OCEMediaControl *mediaControl;

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
        
        OCEMediaControl *mediaControl = [[OCEMediaControl alloc] init];
        [self.playView addSubview:mediaControl];
        self.mediaControl = mediaControl;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat statusBarBackgroundHeight = AYLStatusBarHeight;
    self.statusBarBackground.frame = CGRectMake(0, 0, self.ayl_width, AYLStatusBarHeight);
    
    self.playView.frame = CGRectMake(0, statusBarBackgroundHeight, self.statusBarBackground.ayl_width, self.ayl_height - statusBarBackgroundHeight);
    
    [self.mediaControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading .equalTo(self.playView.mas_leading );
        make.trailing.equalTo(self.playView.mas_trailing);
        make.top     .equalTo(self.playView.mas_top     );
        make.bottom  .equalTo(self.playView.mas_bottom  );
    }];
}

@end
