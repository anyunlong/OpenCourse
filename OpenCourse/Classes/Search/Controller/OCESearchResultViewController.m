//
//  OCESearchResultViewController.m
//  OpenCourse
//
//  Created by Oneself on 16/6/27.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCESearchResultViewController.h"

@implementation OCESearchResultViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationItem *searchViewControllerNavigationItem = [self.navigationController.viewControllers[1] navigationItem];
    UINavigationItem *navigationItem = self.navigationItem;
    
    navigationItem.hidesBackButton = searchViewControllerNavigationItem.hidesBackButton;
    navigationItem.titleView = searchViewControllerNavigationItem.titleView;
    navigationItem.rightBarButtonItem = searchViewControllerNavigationItem.rightBarButtonItem;
}

@end
