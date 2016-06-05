//
//  OFButtonsView.m
//  OpenCourse
//
//  Created by Oneself on 16/6/1.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OFButtonsView.h"
#import "UIView+Extension.h"

extern const CGFloat kUIViewExtensionViewMargin;

@implementation OFButtonsView

+ (instancetype)buttonsViewWithImgNames:(NSArray<NSString *> *)imgNames height:(CGFloat)height {
    CGFloat nextButtonX = 0;
    OFButtonsView *rightButtonsView = [[OFButtonsView alloc] init];
    // buttons间距
    CGFloat buttonMargin = kUIViewExtensionViewMargin * 2;
    // 初始化所有按钮并加到rightButtonsView中
    for (int count = 0; count<imgNames.count; ++count) {
        UIImage *image = [UIImage imageNamed:imgNames[count]];
        CGSize imageSize = CGSizeMake(image.size.width, image.size.height);
        
        UIButton *button = [[UIButton alloc] init];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        button.size = CGSizeMake(imageSize.width, imageSize.height);
        button.center = CGPointMake(nextButtonX + imageSize.width / 2, height / 2);
        nextButtonX += imageSize.width + buttonMargin;
        
        [rightButtonsView addSubview:button];
    }
    rightButtonsView.size = CGSizeMake(nextButtonX - buttonMargin, height);
    
    return rightButtonsView;
}

@end
