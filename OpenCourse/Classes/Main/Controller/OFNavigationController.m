//
//  OFNavigationController.m
//  OpenCourse
//
//  Created by Oneself on 16/5/31.
//  Copyright © 2016年 CCUT. All rights reserved.
//

// c
#import "OFNavigationController.h"
// category
#import "UIColor+Extension.h"

@interface OFNavigationController ()

@end

@implementation OFNavigationController

+ (void)initialize {
    [self setupNavBarTheme];
}

// 设置导航栏主题
+ (void)setupNavBarTheme
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    // 标题文字颜色
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [navBar setTitleTextAttributes:attrs];
    // 背景颜色
    [navBar setBarTintColor:[UIColor appColor]];
}

@end
