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
// v
#import "OCEPlayTopView.h"
#import "OCEMediaControl.h"

@interface OCEPlayVideoViewController ()

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) OCEPlayTopView *topView;

@property (nonatomic, strong) VLCMediaPlayer *player;
@property (nonatomic, strong) IBOutlet OCEMediaControl *mediaControl;

@end

extern const CGFloat AYLViewsMargin;

@implementation OCEPlayVideoViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    
    [self loadNetworkData];
    
    UIButton *testButton = [[UIButton alloc] init];
    testButton.backgroundColor = [UIColor orangeColor];
    [testButton addTarget:self action:@selector(onClickTestButton) forControlEvents:UIControlEventTouchUpInside];
    testButton.frame = CGRectMake(0, 0, 100, 100);
    [self.tableView addSubview:testButton];
}

- (void)onClickTestButton {
    AYLLog(@"%d", self.player.time);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CGSize screenSize = SCREEN_SIZE;
    
    CGFloat topViewH = screenSize.width / screenSize.height * screenSize.width;
    self.topView.frame = CGRectMake(0, 0, screenSize.width, topViewH);
    
    self.mediaControl.frame = CGRectMake(0, AYLStatusBarHeight, _topView.ayl_width, topViewH - AYLStatusBarHeight);
    
    CGFloat backButtonX = AYLViewsMargin;
    self.backButton.ayl_orign = CGPointMake(backButtonX, AYLStatusBarHeight + backButtonX);
    self.backButton.ayl_size = self.backButton.currentBackgroundImage.size;
    
    self.tableView.contentInset = UIEdgeInsetsMake(self.topView.ayl_bottom, 0, 0, 0);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
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
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    cell.textLabel.text = @"haha";
    
    return cell;
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
        NSArray *videoDicts = responseObject[@"data"][@"videoList"];
        NSString *m3u8SdUrl;
        for (NSDictionary *videoDict in videoDicts) {
            if ([_course.rid isEqualToString:videoDict[@"mid"]]) {
                m3u8SdUrl = videoDict[@"m3u8SdUrl"];
            }
            
            self.player.media = [VLCMedia mediaWithURL:[NSURL URLWithString:m3u8SdUrl]];
            [self.player play];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        AYLLog(@"%@", error);
    }];
}

#pragma mark - event response
- (void)backButtonDidClicked {
    [self.navigationController popToRootViewControllerAnimated:YES];
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

@end
