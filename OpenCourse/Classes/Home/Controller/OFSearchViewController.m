//
//  OFSearchViewController.m
//  OpenCourse
//
//  Created by Oneself on 16/6/9.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OFSearchViewController.h"
// v
#import "OFSearchView.h"
// category
#import "UIView+Extension.h"

@interface OFSearchViewController ()

@property (nonatomic, strong) OFSearchView *searchView;

@end

extern const CGFloat kUIViewExtensionViewMargin;
extern const CGFloat kUINavigationBarExtensionSystemNavBarHeight;

@implementation OFSearchViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationItem *navigationItem = self.navigationItem;
    
    // 隐藏返回按钮
    navigationItem.hidesBackButton = YES;
    
    navigationItem.titleView = self.searchView;
    
    navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemDidClicked)];
}

#pragma mark - event response
- (void)rightBarButtonItemDidClicked {
    [self.searchView resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getters and setters
- (OFSearchView *)searchView {
    if (!_searchView) {
        _searchView = [[OFSearchView alloc] init];
        _searchView.size = CGSizeMake(kMainScreenBounds.size.width, kUINavigationBarExtensionSystemNavBarHeight - 2 * kUIViewExtensionViewMargin);
        
        [self.searchView becomeFirstResponder];
    }
    return _searchView;
}

@end
