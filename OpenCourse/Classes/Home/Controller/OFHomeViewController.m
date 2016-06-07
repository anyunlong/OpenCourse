//
//  OFHomeViewController.m
//  OpenCourse
//
//  Created by Oneself on 16/5/31.
//  Copyright © 2016年 CCUT. All rights reserved.
//

// c
#import "OFHomeViewController.h"
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
#import "UIImage+Extension.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
// tool
#import "OFCourseTool.h"
// framework
#import <MJRefresh.h>

extern const CGFloat kUINavigationBarExtensionSystemNavBarHeight;
extern const CGFloat kOFCourseCellOthersFontSize;
static const int kAnimationPullImagesStartCount = 32;
static const int kAnimationPullImagesEndCount = 58;

@interface OFHomeViewController ()

@property (nonatomic, strong) NSMutableArray *courseFrames;

@end

@implementation OFHomeViewController

- (NSMutableArray *)courseFrames {
    if (!_courseFrames) {
        _courseFrames = [NSMutableArray array];
    }
    return _courseFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor systemTableViewBackgroundColor];
    
    // homeIconView
    CGFloat homeIconHeight = [self setupHomeIconView];
    
    // navBarTitleView
    [self setupNavBarTitleViewWithHeight:homeIconHeight];
    
    // rightBarButtonItem
    [self setupRightBarButtonItem];
    
    // 初始化上下拉刷新
    [self setupRefresh];
    
    // 刷新首页
    [self.tableView.mj_header beginRefreshing];
}

- (CGFloat)setupHomeIconView {
    UIImage *homeIcon = [UIImage imageNamed:@"home_logo"];
    CGSize homeIconSize = CGSizeMake(homeIcon.size.width, homeIcon.size.height);
    UIImageView *homeIconView = [[UIImageView alloc] init];
    homeIconView.size = CGSizeMake(homeIconSize.width, homeIconSize.height);
    homeIconView.image = homeIcon;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:homeIconView];
    
    return homeIconSize.height;
}

- (void)setupNavBarTitleViewWithHeight:(CGFloat)height {
    OFSearchView *searchView = [OFSearchView searchView];
    searchView.size = CGSizeMake(kMainScreenBounds.size.width, height);
    self.navigationItem.titleView = searchView;
}

- (void)setupRightBarButtonItem {
    OFButtonsView *rightButtonsView = [OFButtonsView buttonsViewWithImgNames:@[@"home_history", @"home_download"] height:kUINavigationBarExtensionSystemNavBarHeight];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButtonsView];
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

// 像服务器请求course数据并对其处理
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
        if (!param) [selfVc showRefreshResultViewWithCourseFrames:_courseFrames];
    } failure:^(NSError *error) {
        if (!param) [selfVc showRefreshResultViewWithCourseFrames:_courseFrames];
    }];
}

- (void)showRefreshResultViewWithCourseFrames:(NSArray<OFCourseFrame *> *)courseFrames;
{
    UIButton *btn = [[UIButton alloc] init];
    btn.userInteractionEnabled = NO;
    NSString *title = @"刷新成功";
    if (!courseFrames)
        title = @"网络不给力，请稍后重试";
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:kOFCourseCellOthersFontSize];
    [btn setBackgroundImage:[UIImage resizedImageWithName:@"home_refresh_bg"] forState:UIControlStateNormal];
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    
    CGFloat btnX = 0;
    CGFloat btnH = 30;
    CGFloat btnY = [UIApplication sharedApplication].statusBarFrame.size.height + kUINavigationBarExtensionSystemNavBarHeight  - btnH;
    CGFloat btnW = kMainScreenBounds.size.width;
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    [UIView animateWithDuration:0.5 animations:^{
        btn.transform = CGAffineTransformMakeTranslation(0, btnH);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [btn removeFromSuperview];
        }];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.courseFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OFCourseCell *courseCell = [OFCourseCell cellWithTableView:tableView];
    
    courseCell.courseFrame = _courseFrames[indexPath.row];
    
    return courseCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [_courseFrames[indexPath.row] cellHeight];
}

@end
