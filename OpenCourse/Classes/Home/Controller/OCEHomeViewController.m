//
//  OCEHomeViewController.m
//  OpenCourse
//
//  Created by Oneself on 16/5/31.
//  Copyright © 2016年 CCUT. All rights reserved.
//

// c
#import "OCEHomeViewController.h"
#import "OCEPlayVideoViewController.h"
#import "AYLNavigationController.h"
#import "OCESearchViewController.h"
#import "OCEWebViewController.h"
// v
#import "OCEButtonsView.h"
#import "OCESearchView.h"
#import "OCECourseCell.h"
// m
#import "OCESearchDataToolResult.h"
#import "OCECourse.h"
#import "OCECourseFrame.h"
#import "OCECourseToolParam.h"
#import "OCECourseToolResult.h"
// category
#import "UITableViewController+AYLExtension.h"
#import "UIColor+AYLExtension.h"
#import "UIView+AYLExtension.h"
// tool
#import "OCESearchDataTool.h"
#import "OCECourseTool.h"
// framework
#import <MJRefresh.h>

static const int kAnimationPullImagesStartCount = 32;
static const int kAnimationPullImagesEndCount = 58;
extern const CGFloat kUINavigationBarAYLExtensionSystemNavBarHeight;

@interface OCEHomeViewController () <OCECourseCellDelegate, UITextFieldDelegate>

// dataSource
@property (nonatomic, strong) OCESearchDataToolResult *searchDataToolResult;
@property (nonatomic, strong) NSMutableArray *courseFrames;
// view
@property (nonatomic, strong) UIImageView *homeIconView;
@property (nonatomic, strong) OCESearchView *searchView;
@property (nonatomic, strong) OCEButtonsView *buttonsView;

@end

@implementation OCEHomeViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor ayl_systemTableViewBackgroundColor];
    
    [self setupNavigationBar];
    
    [self loadSearchData];
    
    // 初始化上下拉刷新
    [self setupRefresh];
    
    // 刷新首页
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
    
    [super viewWillAppear:animated];
    
    self.homeIconView.ayl_size = _homeIconView.image.size;
    
    self.searchView.ayl_size = CGSizeMake(AYLMainScreenBounds.size.width, _homeIconView.ayl_height);
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.courseFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OCECourseCell *courseCell = [OCECourseCell cellWithTableView:tableView];
    courseCell.delegate = self;
    
    NSInteger row = indexPath.row;
    courseCell.courseFrame = _courseFrames[row];
    courseCell.tag = row;
    
    return courseCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [_courseFrames[indexPath.row] cellHeight];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    OCESearchViewController *svc = [[OCESearchViewController alloc] init];
    svc.data = _searchDataToolResult;
    
    [self.navigationController pushViewController:svc animated:YES];
}

#pragma mark - CustomDelegate
- (void)courseCell:(OCECourseCell *)courseCell didClickedButtonAtIndex:(NSInteger)index {
    OCECourse *course = [_courseFrames[index] course];
    if (course.rtype == OCECourseRtypeH5) {
        OCEWebViewController *webViewController = [[OCEWebViewController alloc] init];
        webViewController.course = course;
        
        AYLNavigationController *nc = [[AYLNavigationController alloc] initWithRootViewController:webViewController];
        [self presentViewController:nc animated:YES completion:nil];
    } else if (course.rtype == OCECourseRtypeVideo) {
        OCEPlayVideoViewController *playVideoViewController = [[OCEPlayVideoViewController alloc] init];
        [self.navigationController pushViewController:playVideoViewController animated:YES];
    }
}

#pragma mark - private methods
#pragma mark load Data
- (void)loadSearchData {
    [OCESearchDataTool searchDataWithProgress:nil success:^(OCESearchDataToolResult *result) {
        self.searchDataToolResult = result;
        
        _searchView.customPlaceholder = _searchDataToolResult.searchKeyword;
    } failure:^(NSError *error) {
        AYLLog(@"%@", error);
    }];
}

#pragma mark setup
- (void)setupNavigationBar {
    // homeIconView
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.homeIconView];
    
    // navBarTitleView
    self.navigationItem.titleView = self.searchView;;
    
    // rightBarButtonItem
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.buttonsView];
}

- (void)setupRefresh {
    // -- 下拉刷新
    // 设置回调(一旦进入刷新状态,就调用target的action,也就是调用self的loadNewData方法)
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 设置普通状态的动画图片
    UIImage *image = [UIImage imageNamed:@"pull_00032"];
    [header setImages:@[image] forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片(一松开就会刷新的状态)
    [header setImages:@[image] forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    NSMutableArray *images = [NSMutableArray array];
    for (int count = kAnimationPullImagesStartCount; count<=kAnimationPullImagesEndCount; ++count) {
        [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"pull_000%d", count]]];
    }
    [header setImages:images forState:MJRefreshStateRefreshing];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
    header.stateLabel.hidden = YES;
    // 设置header
    self.tableView.mj_header = header;
    
    // -- 上拉刷新
    self.tableView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

#pragma mark refresh event response
- (void)loadNewData {
    self.courseFrames = nil; // 清空数据源
    [self loadCourseWithParam:nil];
    [self.tableView.mj_header endRefreshing];
}

- (void)loadMoreData {
    // 网络请求参数model
    OCECourseToolParam *param = [[OCECourseToolParam alloc] init];
    param.cursor = _courseFrames.count;
    // 发送请求
    [self loadCourseWithParam:param];
    // 处理响应后停止上拉刷新
    [self.tableView.mj_footer endRefreshing];
}

// 向服务器请求course数据并对其处理
- (void)loadCourseWithParam:(OCECourseToolParam *)param {
    __weak typeof(self) selfVc = self;
    [OCECourseTool coursesWithParameters:param progress:nil success:^(OCECourseToolResult *result) {
        // 初始化数据源
        for (OCECourse *course in result.courses) {
            OCECourseFrame *courseFrame = [[OCECourseFrame alloc] init];
            courseFrame.course = course;
            
            [selfVc.courseFrames addObject:courseFrame];
        }
        // 刷新tableView
        [selfVc.tableView reloadData];
        // 显示刷新结果view
        if (!param) [selfVc ayl_showRefreshResultViewWithObject:_courseFrames];
    } failure:^(NSError *error) {
        if (!param) [selfVc ayl_showRefreshResultViewWithObject:_courseFrames];
    }];
}

#pragma mark - getters and setters
- (NSMutableArray *)courseFrames {
    if (!_courseFrames) {
        _courseFrames = [NSMutableArray array];
    }
    return _courseFrames;
}

- (UIImageView *)homeIconView {
    if (!_homeIconView) {
        _homeIconView = [[UIImageView alloc] init];
        _homeIconView.image = [UIImage imageNamed:@"home_logo"];
    }
    return _homeIconView;
}

- (OCESearchView *)searchView {
    if (!_searchView) {
        _searchView = [OCESearchView searchView];
        _searchView.delegate = self;
    }
    return _searchView;
}

- (OCEButtonsView *)buttonsView {
    if (!_buttonsView) {
        _buttonsView = [OCEButtonsView buttonsViewWithImgNames:@[@"home_history", @"home_download"] height:kUINavigationBarAYLExtensionSystemNavBarHeight];
    }
    return _buttonsView;
}

@end
