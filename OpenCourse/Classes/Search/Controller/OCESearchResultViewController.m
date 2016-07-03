//
//  OCESearchResultViewController.m
//  OpenCourse
//
//  Created by Oneself on 16/6/27.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCESearchResultViewController.h"
// v
#import "OCESearchResultTableHeaderView.h"
// category
#import "UIView+AYLExtension.h"

@interface OCESearchResultViewController()

@property(nonatomic, strong) UIView *tableHeaderView;

@end

extern const CGFloat kOCESearchResultTableHeaderViewHeight;

@implementation OCESearchResultViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationItem *searchViewControllerNavigationItem = [self.navigationController.viewControllers[1] navigationItem];
    UINavigationItem *navigationItem = self.navigationItem;
    
    navigationItem.hidesBackButton = searchViewControllerNavigationItem.hidesBackButton;
    navigationItem.titleView = searchViewControllerNavigationItem.titleView;
    navigationItem.rightBarButtonItem = searchViewControllerNavigationItem.rightBarButtonItem;
    
    self.tableView.tableHeaderView = self.tableHeaderView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _tableHeaderView.ayl_height = kOCESearchResultTableHeaderViewHeight;
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // cell标识
    static NSString *ID = @"cell";
    // 从缓存池中取可用cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.backgroundColor = [UIColor blueColor];
    }
    
    return cell;
}

#pragma mark - getters and setters
- (UIView *)tableHeaderView {
    if (!_tableHeaderView) {
        _tableHeaderView = [[OCESearchResultTableHeaderView alloc] init];
    }
    return _tableHeaderView;
}

@end
