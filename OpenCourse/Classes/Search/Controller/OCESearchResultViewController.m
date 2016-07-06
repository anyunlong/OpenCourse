//
//  OCESearchResultViewController.m
//  OpenCourse
//
//  Created by Oneself on 16/6/27.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCESearchResultViewController.h"
// m
#import "OCESearchResultCourse.h"
// v
#import "OCESearchResultTableHeaderView.h"
#import "OCESearchResultCell.h"
#import "OCESearchView.h"
// category
#import "UIView+AYLExtension.h"
// framework
#import <AFNetworking.h>
#import <MJExtension.h>

@interface OCESearchResultViewController()

@property (nonatomic, strong) NSMutableArray *searchResultCourses;

@property(nonatomic, strong) UIView *tableHeaderView;

@end

extern const CGFloat kOCESearchResultTableHeaderViewHeight;

@implementation OCESearchResultViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationItem];
    
    self.tableView.tableHeaderView = self.tableHeaderView;
    
    [self loadSearchResultData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _tableHeaderView.ayl_height = kOCESearchResultTableHeaderViewHeight;
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResultCourses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OCESearchResultCell *searchResultCell = [OCESearchResultCell cellWithTableView:tableView];
    
    searchResultCell.course = _searchResultCourses[indexPath.row];
    
    return searchResultCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [OCESearchResultCell cellHeight];
}

#pragma mark - private methods
#pragma mark setup views
- (void)setupNavigationItem {
    UINavigationItem *searchViewControllerNavigationItem = [self.navigationController.viewControllers[1] navigationItem];
    UINavigationItem *navigationItem = self.navigationItem;
    
    // hidesBackButton
    navigationItem.hidesBackButton = searchViewControllerNavigationItem.hidesBackButton;
    // titleView
    OCESearchView *searchView = [[OCESearchView alloc] init];
    
    searchView.customPlaceholder = _keyword;
    searchView.ayl_size = searchViewControllerNavigationItem.titleView.ayl_size;
    
    navigationItem.titleView = searchView;
    // rightBarButtonItem
    navigationItem.rightBarButtonItem = searchViewControllerNavigationItem.rightBarButtonItem;
}

#pragma mark load Data
- (void)loadSearchResultData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *para = @{
                           @"keyword"  : _keyword,
                           @"pagesize" : @(20)
                           };
    [manager POST:@"http://c.open.163.com/mob/search/keyword.do" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *searchResultCourseDicts = responseObject[@"data"][@"courses"];
        self.searchResultCourses = [OCESearchResultCourse mj_objectArrayWithKeyValuesArray:searchResultCourseDicts];
        
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        AYLLog(@"%@", error);
    }];
}

#pragma mark - getters and setters
- (NSMutableArray *)searchResultCourses {
    if (!_searchResultCourses) {
        _searchResultCourses = [NSMutableArray array];
    }
    return _searchResultCourses;
}

- (UIView *)tableHeaderView {
    if (!_tableHeaderView) {
        _tableHeaderView = [[OCESearchResultTableHeaderView alloc] init];
    }
    return _tableHeaderView;
}

@end
