//
//  OFSearchView.m
//  OpenCourse
//
//  Created by Oneself on 16/5/31.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OFSearchView.h"
// category
#import "UIImage+Extension.h"

extern const CGFloat kUIViewExtensionViewMargin;
static const CGFloat kTitleLableFontSize = 13;

@interface OFSearchView()

@end

@implementation OFSearchView

+ (instancetype)searchView {
    return [[self alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        // 背景图片
        [self setBackgroundImage:[UIImage resizedImageWithName:@"search_list_bg"] forState:UIControlStateNormal];
        // 放大镜图片
        [self setImage:[UIImage imageNamed:@"search_fdj"] forState:UIControlStateNormal];
        self.imageView.contentMode = UIViewContentModeCenter;
        // 文字
        [self setTitle:@"农村学子哈佛毕业演讲" forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:kTitleLableFontSize];
        // 圆角边缘
        [self.layer setMasksToBounds:YES];
        [self.layer setCornerRadius:5]; //设置矩形四个圆角半径
    }
    
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, 0, [UIImage imageNamed:@"search_fdj"].size.width + 2 * kUIViewExtensionViewMargin, contentRect.size.height);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat imageViewW = self.imageView.frame.size.width;
    return CGRectMake(imageViewW, 0, contentRect.size.width - imageViewW - kUIViewExtensionViewMargin, contentRect.size.height);
}

@end
