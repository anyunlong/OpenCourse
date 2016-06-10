//
//  OFHomeViewController.m
//  OpenCourse
//
//  Created by Oneself on 16/5/31.
//  Copyright © 2016年 CCUT. All rights reserved.
//

// c
#import "OFHomeViewController.h"
#import "OFWebViewController.h"
#import "OFNavigationController.h"
#import "OFSearchViewController.h"
// v
#import "OFButtonsView.h"
#import "OFSearchView.h"
#import "OFCourseCell.h"
// m
#import "OFCourse.h"
#import "OFCourseFrame.h"
#import "OFCourseToolParam.h"
#import "OFCourseToolResult.h"
// category
#import "UITableViewController+Extension.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
// tool
#import "OFCourseTool.h"
// framework
#import <MJRefresh.h>

static const int kAnimationPullImagesStartCount = 32;
static const int kAnimationPullImagesEndCount = 58;
extern const CGFloat kUINavigationBarExtensionSystemNavBarHeight;

@interface OFHomeViewController () <OFCourseCellDelegate, UITextFieldDelegate>

// dataSource
@property (nonatomic, strong) NSMutableArray *courseFrames;
// view
@property (nonatomic, strong) UIImageView *homeIconView;
@property (nonatomic, strong) OFSearchView *searchView;
@property (nonatomic, strong) OFButtonsView *buttonsView;

@end

@implementation OFHomeViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor systemTableViewBackgroundColor];
    
    UINavigationItem *navigationItem = self.navigationItem;
    
    // homeIconView
    navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.homeIconView];
    
    // navBarTitleView
    navigationItem.titleView = self.searchView;;
    
    // rightBarButtonItem
    navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.buttonsView];
    
    // 初始化上下拉刷新
    [self setupRefresh];
    
    // 刷新首页
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.courseFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OFCourseCell *courseCell = [OFCourseCell cellWithTableView:tableView];
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
    OFSearchViewController *svc = [[OFSearchViewController alloc] init];
    [self.navigationController pushViewController:svc animated:YES];
}

#pragma mark - CustomDelegate
- (void)courseCell:(OFCourseCell *)courseCell didClickedButtonAtIndex:(NSInteger)index {
    OFWebViewController *wc = [[OFWebViewController alloc] init];
    wc.course = [_courseFrames[index] course];
    OFNavigationController *nc = [[OFNavigationController alloc] initWithRootViewController:wc];
    
    [self presentViewController:nc animated:YES completion:nil];
}

#pragma mark - private methods
#pragma mark setup refresh
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
    OFCourseToolParam *param = [[OFCourseToolParam alloc] init];
    param.cursor = _courseFrames.count;
    // 发送请求
    [self loadCourseWithParam:param];
    // 处理响应后停止上拉刷新
    [self.tableView.mj_footer endRefreshing];
}

// 向服务器请求course数据并对其处理
- (void)loadCourseWithParam:(OFCourseToolParam *)param {
    __weak typeof(self) selfVc = self;
    [OFCourseTool coursesWithParameters:param progress:nil success:^(OFCourseToolResult *result) {
        // 初始化数据源
        for (OFCourse *course in result.courses) {
            OFCourseFrame *courseFrame = [[OFCourseFrame alloc] init];
            courseFrame.course = course;
            
            [selfVc.courseFrames addObject:courseFrame];
        }
        // 刷新tableView
        [selfVc.tableView reloadData];
        // 显示刷新结果view
        if (!param) [selfVc showRefreshResultViewWithObject:_courseFrames];
    } failure:^(NSError *error) {
        if (!param) [selfVc showRefreshResultViewWithObject:_courseFrames];
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
        UIImage *homeIconImg = [UIImage imageNamed:@"home_logo"];
        _homeIconView.image = homeIconImg;
        
        _homeIconView.size = homeIconImg.size;
    }
    return _homeIconView;
}

- (OFSearchView *)searchView {
    if (!_searchView) {
        _searchView = [OFSearchView searchView];
        _searchView.delegate = self;
        
        _searchView.size = CGSizeMake(kMainScreenBounds.size.width, _homeIconView.height);
    }
    return _searchView;
}

- (OFButtonsView *)buttonsView {
    if (!_buttonsView) {
        _buttonsView = [OFButtonsView buttonsViewWithImgNames:@[@"home_history", @"home_download"] height:kUINavigationBarExtensionSystemNavBarHeight];
    }
    return _buttonsView;
}

@end
