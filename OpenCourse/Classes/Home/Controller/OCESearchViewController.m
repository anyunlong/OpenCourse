//
//  OCESearchViewController.m
//  OpenCourse
//
//  Created by Oneself on 16/6/9.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCESearchViewController.h"
// v
#import "OCESearchView.h"
// category
#import "UIView+AYLExtension.h"

@interface OCESearchViewController ()

@property (nonatomic, strong) OCESearchView *searchView;

@end

extern const CGFloat kUIViewAYLExtensionViewMargin;
extern const CGFloat kUINavigationBarAYLExtensionSystemNavBarHeight;

@implementation OCESearchViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationItem *navigationItem = self.navigationItem;
    
    // 隐藏返回按钮
    navigationItem.hidesBackButton = YES;
    
    navigationItem.titleView = self.searchView;
    
    navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemDidClicked)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.searchView.ayl_size = CGSizeMake(AYLMainScreenBounds.size.width, kUINavigationBarAYLExtensionSystemNavBarHeight - 2 * kUIViewAYLExtensionViewMargin);
}

#pragma mark - event response
- (void)rightBarButtonItemDidClicked {
    [self.searchView resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getters and setters
- (OCESearchView *)searchView {
    if (!_searchView) {
        _searchView = [[OCESearchView alloc] init];
        [self.searchView becomeFirstResponder];
    }
    return _searchView;
}

@end
