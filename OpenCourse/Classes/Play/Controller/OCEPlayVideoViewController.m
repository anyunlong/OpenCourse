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
// framework
#import <IJKMediaFramework/IJKMediaFramework.h>
#import <AFNetworking.h>
// catrgory
#import "UIView+AYLExtension.h"

@interface OCEPlayVideoViewController ()

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIView *playerView;
@property (nonatomic, strong) UIView *statusBarBackground;

@property (atomic, retain) id<IJKMediaPlayback> player;

@end

extern const CGFloat kUIViewAYLExtensionViewMargin;

@implementation OCEPlayVideoViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    
    [self loadNetworkData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CGSize screenSize = AYLMainScreenBounds.size;
    
    CGFloat playerViewH = screenSize.width / screenSize.height * screenSize.width;
    _playerView.frame = CGRectMake(0, 0, screenSize.width, playerViewH);
    
    _statusBarBackground.frame = CGRectMake(0, 0, _playerView.ayl_width, [[UIApplication sharedApplication] statusBarFrame].size.height);
    
    _player.view.frame = CGRectMake(0, _statusBarBackground.ayl_bottom, _statusBarBackground.ayl_width, _playerView.ayl_height - _statusBarBackground.ayl_height);
    
    CGFloat backButtonX = kUIViewAYLExtensionViewMargin;
    _backButton.ayl_orign = CGPointMake(backButtonX, _statusBarBackground.ayl_bottom + backButtonX);
    _backButton.ayl_size = _backButton.currentBackgroundImage.size;
    
    self.tableView.contentInset = UIEdgeInsetsMake(_playerView.ayl_bottom, 0, 0, 0);
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
    [self.navigationController.view addSubview:self.playerView];
    
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
        }
        
        IJKFFOptions *options = [IJKFFOptions optionsByDefault];
        self.player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:m3u8SdUrl withOptions:options];
        [self.playerView addSubview:_player.view];
        [self.player prepareToPlay];
        
        [self viewWillAppear:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        AYLLog(@"%@", error);
    }];
}

#pragma mark - event response
- (void)backButtonDidClicked {
    [_player shutdown];
    [self.backButton removeFromSuperview];
    [self.playerView removeFromSuperview];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
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

- (UIView *)playerView {
    if (!_playerView) {
        _playerView = [[UIView alloc] init];
        [_playerView addSubview:self.statusBarBackground];
    }
    return _playerView;
}

- (UIView *)statusBarBackground {
    if (!_statusBarBackground) {
        _statusBarBackground = [[UIView alloc] init];
        _statusBarBackground.backgroundColor = [UIColor blackColor];
    }
    return _statusBarBackground;
}


@end
