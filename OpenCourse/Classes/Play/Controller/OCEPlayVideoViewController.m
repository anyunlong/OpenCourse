//
//  OCEPlayVideoViewController.m
//  OpenCourse
//
//  Created by Oneself on 16/7/8.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCEPlayVideoViewController.h"
// m
#import "OCECourse.h"
#import "OCECourseFrame.h"
// v
#import "OCEPlayTopView.h"
#import "OCEMediaControl.h"
#import "OCECourseCell.h"
// c
#import "OCEWebViewController.h"
#import "AYLNavigationController.h"
@interface OCEPlayVideoViewController () <OCECourseCellDelegate>

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) OCEPlayTopView *topView;

@property (nonatomic, strong) VLCMediaPlayer *player;
@property (nonatomic, strong) IBOutlet OCEMediaControl *mediaControl;

@property (nonatomic, strong) NSMutableArray *courseFrames;

@end

extern const CGFloat AYLViewsMargin;

@implementation OCEPlayVideoViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    
    [self loadNetworkData];
    
//    UIButton *testButton = [[UIButton alloc] init];
//    testButton.backgroundColor = [UIColor orangeColor];
//    [testButton addTarget:self action:@selector(onClickTestButton) forControlEvents:UIControlEventTouchUpInside];
//    testButton.frame = CGRectMake(0, 0, 100, 100);
//    [self.tableView addSubview:testButton];
}

- (void)onClickTestButton {
//    NSURL *url = [NSURL URLWithString:@"http://mov.bn.netease.com/open-movie/nos/mp4/2016/07/19/SBRDPMSEP_sd.mp4"];
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//        NSString *file = [caches stringByAppendingPathComponent:response.suggestedFilename];
//        
//        NSFileManager *mgr = [NSFileManager defaultManager];
//        [mgr moveItemAtPath:location.path toPath:file error:nil];
//        
//        AYLLog(@"%@", file);
//    }];
//    
//    [downloadTask resume];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.mediaControl.frame = CGRectMake(0, AYLStatusBarHeight, _topView.ayl_width, _topView.playView.ayl_height);
    
    CGFloat backButtonX = AYLViewsMargin;
    self.backButton.ayl_orign = CGPointMake(backButtonX, AYLStatusBarHeight + backButtonX);
    self.backButton.ayl_size = self.backButton.currentBackgroundImage.size;
    
    self.tableView.contentInset = UIEdgeInsetsMake(_topView.ayl_height, 0, 0, 0);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    [self.backButton removeFromSuperview];
    [self.topView removeFromSuperview];
    [self.mediaControl removeFromSuperview];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.player stop];
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
        playVideoViewController.course = course;
        
        [self.navigationController pushViewController:playVideoViewController animated:YES];
    }
}

#pragma mark - private methods
- (void)setupViews {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // top views
    [self.navigationController.view addSubview:self.backButton];
    [self.navigationController.view insertSubview:self.topView belowSubview:self.backButton];
    OCEMediaControl *mediaControl = self.mediaControl;
    mediaControl.player = self.player;
    self.mediaControl.player.delegate = mediaControl;
    [self.navigationController.view insertSubview:mediaControl belowSubview:self.backButton];
    
    // navigationBar
    self.navigationController.navigationBar.hidden = YES;
    self.navigationItem.hidesBackButton = YES;
}

- (void)loadNetworkData {
    AFHTTPSessionManager *magager = [AFHTTPSessionManager manager];
    
    NSString *urlString = [NSString stringWithFormat:@"http://c.open.163.com/mob/%@/getMoviesForIpad.do", _course.plid];
    [magager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = responseObject[@"data"];
        NSString *m3u8SdUrl;
        for (NSDictionary *videoDict in data[@"videoList"]) {
            if (_course.rid == nil) {
                m3u8SdUrl = videoDict[@"m3u8SdUrl"];
                self.player.media = [VLCMedia mediaWithURL:[NSURL URLWithString:m3u8SdUrl]];
                
                break;
            } else {
                if ([_course.rid isEqualToString:videoDict[@"mid"]]) {
                    m3u8SdUrl = videoDict[@"m3u8SdUrl"];
                    self.player.media = [VLCMedia mediaWithURL:[NSURL URLWithString:m3u8SdUrl]];
                    
                    break;
                }
            }
        }
        [self.player play];
        
        for (NSDictionary *courseDict in data[@"recommendList"]) {
            OCECourseFrame *courseFrame = [[OCECourseFrame alloc] init];
            courseFrame.course = [OCECourse mj_objectWithKeyValues:courseDict];
            [self.courseFrames addObject:courseFrame];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        AYLLog(@"%@", error);
    }];
}

#pragma mark - event response
- (void)backButtonDidClicked {
    if (_course.rid == nil) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (IBAction)onClickMediaControl {
    [self.mediaControl show];
}

- (IBAction)onClickOverlay {
    [self.mediaControl hide];
}

- (IBAction)onClickPlay:(id)sender {
    [self.mediaControl play];
}

- (IBAction)onClickPause:(id)sender {
    [self.mediaControl pause];
}
- (IBAction)didSliderTouchUpInside:(id)sender {
    [self.mediaControl changeCurrentPlayTime];
}

#pragma mark - getters and setters
- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [[UIButton alloc] init];
        [_backButton addTarget:self action:@selector(backButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
        [_backButton setBackgroundImage:[UIImage imageNamed:@"player_back_black"] forState:UIControlStateNormal];
    }
    return _backButton;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[OCEPlayTopView alloc] init];
    }
    return _topView;
}

- (VLCMediaPlayer *)player {
    if (!_player) {
        _player = [[VLCMediaPlayer alloc] init];
        _player.drawable = self.topView.playView;
    }
    return _player;
}

- (OCEMediaControl *)mediaControl {
    if (!_mediaControl) {
        _mediaControl = [[OCEMediaControl alloc] init];
    }
    return _mediaControl;
}

- (NSMutableArray *)courseFrames {
    if (!_courseFrames) {
        _courseFrames = [NSMutableArray array];
    }
    return _courseFrames;
}

@end
