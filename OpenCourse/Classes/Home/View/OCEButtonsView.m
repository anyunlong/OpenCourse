//
//  OCEButtonsView.m
//  OpenCourse
//
//  Created by Oneself on 16/6/1.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCEButtonsView.h"
// category
#import "UIView+AYLExtension.h"

extern const CGFloat kUIViewAYLExtensionViewMargin;

@implementation OCEButtonsView

+ (instancetype)buttonsViewWithImgNames:(NSArray<NSString *> *)imgNames height:(CGFloat)height {
    CGFloat nextButtonX = 0;
    OCEButtonsView *rightButtonsView = [[OCEButtonsView alloc] init];
    // buttons间距
    CGFloat buttonMargin = kUIViewAYLExtensionViewMargin;
    // 初始化所有按钮并加到rightButtonsView中
    for (int count = 0; count<imgNames.count; ++count) {
        UIImage *image = [UIImage imageNamed:imgNames[count]];
        CGSize imageSize = CGSizeMake(image.size.width, image.size.height);
        
        UIButton *button = [[UIButton alloc] init];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        button.ayl_size = CGSizeMake(imageSize.width, imageSize.height);
        button.center = CGPointMake(nextButtonX + imageSize.width / 2, height / 2);
        nextButtonX += imageSize.width + buttonMargin;
        
        [rightButtonsView addSubview:button];
    }
    rightButtonsView.ayl_size = CGSizeMake(nextButtonX - buttonMargin, height);
    
    return rightButtonsView;
}

@end
