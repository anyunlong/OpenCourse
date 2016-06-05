//
//  OFTabBarController.m
//  OpenCourse
//
//  Created by Oneself on 16/5/31.
//  Copyright © 2016年 CCUT. All rights reserved.
//

// c
#import "OFTabBarController.h"
#import "OFNavigationController.h"
#import "OFHomeViewController.h"
#import "OFCategoryViewController.h"
#import "OFMeViewController.h"
// framework
#import <CYLTabBarController.h>
// category
#import "UIColor+Extension.h"

@interface OFTabBarController ()

@end

@implementation OFTabBarController

- (instancetype)init {
    if (self = [super init]) {
        // 初始化控制器
        [self setupTabBarController];
        
        // 设置tabBar背景颜色
        UITabBar *tabBarAppearance = [UITabBar appearance];
        [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tabbar_bg"]];
        
        // 初始化tabBarItem风格
        [self setupTabBarItemStyle];
    }
    
    return self;
}

#pragma mark 初始化控制器
- (void)setupTabBarController {
    // tabBarController所有子控制器
    NSArray *controllers = [self setupAllSubControllers];
    // tabBarItem内容
    [self setupTabBarItemContent];
    // addControllers
    [self setViewControllers:controllers];
}
- (NSArray<UIViewController *> *)setupAllSubControllers {
    OFHomeViewController *hvc = [[OFHomeViewController alloc] init];
    OFNavigationController *hvcNc = [[OFNavigationController alloc] initWithRootViewController:hvc];
    
    OFCategoryViewController *cvc = [[OFCategoryViewController alloc] init];
    OFNavigationController *cvcNc = [[OFNavigationController alloc] initWithRootViewController:cvc];
    
    OFMeViewController *mvc = [[OFMeViewController alloc] init];
    mvc.navigationItem.title = @"我";
    OFNavigationController *mvcNc = [[OFNavigationController alloc] initWithRootViewController:mvc];
    
    return @[hvcNc, cvcNc, mvcNc];
}
- (void)setupTabBarItemContent {
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"首页",
                            CYLTabBarItemImage : @"tabbar_home",
                            CYLTabBarItemSelectedImage : @"tabbar_home_HL",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"分类",
                            CYLTabBarItemImage : @"tabbar_category",
                            CYLTabBarItemSelectedImage : @"tabbar_category_HL",
                            };
    NSDictionary *dict3 = @{
                            CYLTabBarItemTitle : @"我",
                            CYLTabBarItemImage : @"tabbar_me",
                            CYLTabBarItemSelectedImage : @"tabbar_me_HL",
                            };
    NSArray *tabBarItemsAttrs = @[dict1, dict2, dict3];
    self.tabBarItemsAttributes = tabBarItemsAttrs;
}

#pragma mark 初始化tabBarItem风格
- (void)setupTabBarItemStyle {
    // 文字主题
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    // 两种状态文字的颜色
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor appColor];
    // 设置属性
    [tabBarItem setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

@end
