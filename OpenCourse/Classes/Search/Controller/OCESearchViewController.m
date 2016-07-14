//
//  OCESearchViewController.m
//  OpenCourse
//
//  Created by Oneself on 16/6/9.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCESearchViewController.h"
#import "OCESearchResultViewController.h"
// v
#import "OCESearchView.h"
#import "OCESearchHotCell.h"
#import "OCESearchTableHeaderView.h"
// m
#import "OCESearchDataToolResult.h"
#import "OCEHotKeyword.h"

@interface OCESearchViewController ()

@property (nonatomic, strong) OCESearchView *searchView;
@property (nonatomic, strong) UIView *tableHeaderView;

@end

extern const CGFloat AYLViewsMargin;
extern const CGFloat AYLNavigationBarHeight;

@implementation OCESearchViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationItem *navigationItem = self.navigationItem;
    
    // 隐藏返回按钮
    navigationItem.hidesBackButton = YES;
    
    navigationItem.titleView = self.searchView;
    
    navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemDidClicked)];
    
    self.tableView.tableHeaderView = self.tableHeaderView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.searchView.ayl_size = CGSizeMake(SCREEN_WIDTH, AYLNavigationBarHeight - AYLViewsMargin);
    
    self.tableHeaderView.ayl_size = CGSizeMake(0, _tableHeaderView.ayl_height);
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.hotKeywords.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OCESearchHotCell *cell = [OCESearchHotCell cellWithTable:tableView indexPath:indexPath];
    
    cell.hotKeyword = _data.hotKeywords[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OCESearchResultViewController *searchResultViewController = [[OCESearchResultViewController alloc] init];
    searchResultViewController.keyword = [_data.hotKeywords[indexPath.row] value];
    
    [self.navigationController pushViewController:searchResultViewController animated:NO];
}

#pragma mark - event response
- (void)rightBarButtonItemDidClicked {
    [self.searchView resignFirstResponder];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - getters and setters
- (OCESearchView *)searchView {
    if (!_searchView) {
        _searchView = [[OCESearchView alloc] init];
        _searchView.customPlaceholder = _data.searchKeyword;
        
        [self.searchView becomeFirstResponder];
    }
    return _searchView;
}

- (UIView *)tableHeaderView {
    if (!_tableHeaderView) {
        _tableHeaderView = [[OCESearchTableHeaderView alloc] init];
    }
    return _tableHeaderView;
}

@end
