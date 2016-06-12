//
//  AYLNavigationController.m
//
//  Created by Oneself on 16/5/31.
//  Copyright © 2016年 CCUT. All rights reserved.
//

// c
#import "AYLNavigationController.h"
// category
#import "UIColor+AYLExtension.h"

@interface AYLNavigationController ()

@end

@implementation AYLNavigationController

+ (void)initialize {
    // 1.设置导航栏主题
    [self ayl_setupNavBarTheme];
    
    // 2.设置导航栏按钮主题
    [self ayl_setupBarButtonItemTheme];
}

+ (void)ayl_setupNavBarTheme
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    // 标题文字颜色
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [navBar setTitleTextAttributes:attrs];
    // 背景颜色
    [navBar setBarTintColor:[UIColor ayl_appColor]];
}

+ (void)ayl_setupBarButtonItemTheme {
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    // barButtonItem颜色
    item.tintColor = [UIColor whiteColor];
}

@end
