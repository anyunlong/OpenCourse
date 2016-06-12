//
//  AYLTabBarController.m
//
//  Created by Oneself on 16/5/31.
//  Copyright © 2016年 CCUT. All rights reserved.
//

// c
#import "AYLTabBarController.h"
#import "AYLNavigationController.h"
#import "OCEHomeViewController.h"
#import "OCECategoryViewController.h"
#import "OCEMeViewController.h"
// framework
#import <CYLTabBarController.h>
// category
#import "UIColor+AYLExtension.h"

@interface AYLTabBarController ()

@end

@implementation AYLTabBarController

- (instancetype)init {
    if (self = [super init]) {
        // 初始化控制器
        [self ayl_setupTabBarController];
        
        // 设置tabBar背景颜色
        UITabBar *tabBarAppearance = [UITabBar appearance];
        [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tabbar_bg"]];
        
        // 初始化tabBarItem风格
        [self ayl_setupTabBarItemStyle];
    }
    
    return self;
}

#pragma mark 初始化控制器
- (void)ayl_setupTabBarController {
    // tabBarController所有子控制器
    NSArray *controllers = [self ayl_setupAllSubControllers];
    // tabBarItem内容
    [self ayl_setupTabBarItemContent];
    // addControllers
    [self setViewControllers:controllers];
}
- (NSArray<UIViewController *> *)ayl_setupAllSubControllers {
    OCEHomeViewController *hvc = [[OCEHomeViewController alloc] init];
    AYLNavigationController *hvcNc = [[AYLNavigationController alloc] initWithRootViewController:hvc];
    
    OCECategoryViewController *cvc = [[OCECategoryViewController alloc] init];
    AYLNavigationController *cvcNc = [[AYLNavigationController alloc] initWithRootViewController:cvc];
    
    OCEMeViewController *mvc = [[OCEMeViewController alloc] init];
    mvc.navigationItem.title = @"我";
    AYLNavigationController *mvcNc = [[AYLNavigationController alloc] initWithRootViewController:mvc];
    
    return @[hvcNc, cvcNc, mvcNc];
}
- (void)ayl_setupTabBarItemContent {
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
- (void)ayl_setupTabBarItemStyle {
    // 文字主题
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    // 两种状态文字的颜色
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor ayl_appColor];
    // 设置属性
    [tabBarItem setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

@end
