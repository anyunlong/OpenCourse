//
//  OCESearchView.m
//  OpenCourse
//
//  Created by Oneself on 16/5/31.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCESearchView.h"
// category
#import "UIImage+AYLExtension.h"
#import "UIView+AYLExtension.h"

static const CGFloat kTitleLableFontSize = 13;
extern const CGFloat kUIViewAYLExtensionViewMargin;

@interface OCESearchView()

@end

@implementation OCESearchView

+ (instancetype)searchView {
    return [[self alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        // 圆角边缘
        [self ayl_circularBeadViewWithRadius:5];
        
        // 背景图片
        self.background = [UIImage ayl_resizedImageWithName:@"search_list_bg"];
        
        // 左边的放大镜图标
        UIImage *iconImg = [UIImage imageNamed:@"search_fdj"];
        UIImageView *iconView = [[UIImageView alloc] initWithImage:iconImg];
        iconView.contentMode = UIViewContentModeCenter;
        self.leftView = iconView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        // 右边的清除按钮
        self.clearButtonMode = UITextFieldViewModeAlways;
        
        // 字体
        self.font = [UIFont systemFontOfSize:kTitleLableFontSize];
        
        // 光标颜色
        self.tintColor = [UIColor whiteColor];
        
        // 文字颜色
        self.textColor = [UIColor whiteColor];
        
        // 设置左边图标的frame
        CGSize iconImgSize = iconImg.size;
        self.leftView.ayl_size = CGSizeMake(iconImgSize.width + kUIViewAYLExtensionViewMargin, self.ayl_height);
    }
    
    return self;
}

- (void)setCustomPlaceholder:(NSString *)customPlaceholder {
    _customPlaceholder = [customPlaceholder copy];
    
    // 设置提醒文字
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:customPlaceholder attributes:attr];
}

@end
