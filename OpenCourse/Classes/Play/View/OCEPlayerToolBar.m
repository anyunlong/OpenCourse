//
//  OCEPlayerToolBar.m
//  OpenCourse
//
//  Created by Oneself on 16/7/9.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCEPlayerToolBar.h"

@interface OCEPlayerToolBar()

@property (weak, nonatomic) IBOutlet UIButton *downloadView;
@property (weak, nonatomic) IBOutlet UIButton *likeView;
@property (weak, nonatomic) IBOutlet UIButton *shareView;

@end

@implementation OCEPlayerToolBar

- (instancetype)init {
    if (self = [super init]) {
        self = [[NSBundle mainBundle] loadNibNamed:@"OCEPlayerToolBar" owner:nil options:nil][0];
        
        [self.downloadView addTarget:self action:@selector(obClickDownloadButton) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.downloadView.ayl_size = _downloadView.currentBackgroundImage.size;
    self.likeView.ayl_size = _likeView.currentBackgroundImage.size;
    self.shareView.ayl_size = _shareView.currentBackgroundImage.size;
}

- (CGFloat)height {
    return _downloadView.currentBackgroundImage.size.height + 2 * 5;
}

- (void)obClickDownloadButton {
    if ([_delegate respondsToSelector:@selector(onClickDownloadButtonInPlayerToolBar:)]) {
        [_delegate onClickDownloadButtonInPlayerToolBar:self];
    }
}

@end
