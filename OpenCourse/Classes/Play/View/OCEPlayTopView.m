//
//  OCEPlayTopView.m
//  OpenCourse
//
//  Created by Oneself on 16/7/13.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCEPlayTopView.h"
#import "OCEPlayerToolBar.h"

@interface OCEPlayTopView()

@property (nonatomic, strong) OCEPlayerToolBar *toolBar;

@end

@implementation OCEPlayTopView

- (instancetype)init {
    if (self = [super init]) {
        UIView *statusBarBackground = [[UIView alloc] init];
        statusBarBackground.backgroundColor = [UIColor blackColor];
        self.statusBarBackground = statusBarBackground;
        [self addSubview:statusBarBackground];
        
        self.playView = [[UIView alloc] init];
        [self addSubview:_playView];
        
        self.toolBar = [[OCEPlayerToolBar alloc] init];
        [self addSubview:_toolBar];
        
        
        self.statusBarBackground.frame = CGRectMake(0, 0, SCREEN_WIDTH, AYLStatusBarHeight);
        
        CGFloat playViewH = SCREEN_WIDTH / SCREEN_HEIGHT * SCREEN_WIDTH;
        self.playView.frame = CGRectMake(0, _statusBarBackground.ayl_bottom, _statusBarBackground.ayl_width, playViewH);
        
        self.toolBar.frame = CGRectMake(0, _playView.ayl_bottom, _playView.ayl_width, 20);
        
        self.ayl_size = CGSizeMake(_statusBarBackground.ayl_width, _toolBar.ayl_bottom);
    }
    
    return self;
}

@end
