//
//  UITableViewController+AYLExtension.m
//
//  Created by Oneself on 16/6/9.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "UITableViewController+AYLExtension.h"

extern const CGFloat AYLNavigationBarHeight;
extern const CGFloat kOCECourseCellOthersFontSize;

@implementation UITableViewController (AYLExtension)

- (void)ayl_showRefreshResultViewWithObject:(id)object {
    UIButton *btn = [[UIButton alloc] init];
    btn.userInteractionEnabled = NO;
    NSString *title = @"刷新成功";
    if (!object)
        title = @"网络不给力，请稍后重试";
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:kOCECourseCellOthersFontSize];
    [btn setBackgroundImage:[UIImage ayl_resizedImageWithName:@"home_refresh_bg"] forState:UIControlStateNormal];
    UINavigationController *nc = self.navigationController;
    [nc.view insertSubview:btn belowSubview:nc.navigationBar];
    
    CGFloat btnX = 0;
    CGFloat btnH = 30;
    CGFloat btnY = AYLStatusBarHeight + AYLNavigationBarHeight  - btnH;
    CGFloat btnW = SCREEN_WIDTH;
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    [UIView animateWithDuration:0.5 animations:^{
        btn.transform = CGAffineTransformMakeTranslation(0, btnH);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [btn removeFromSuperview];
        }];
    }];
}

@end
