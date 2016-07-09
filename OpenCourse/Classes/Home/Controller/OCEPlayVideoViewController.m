//
//  OCEPlayVideoViewController.m
//  OpenCourse
//
//  Created by Oneself on 16/7/8.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCEPlayVideoViewController.h"
// framework
#import <IJKMediaFramework/IJKMediaFramework.h>
// catrgory
#import "UIView+AYLExtension.h"

@interface OCEPlayVideoViewController ()

@property (nonatomic, weak) UIView *playerView;
@property (nonatomic, weak) UIView *statusBarBackground;
@property (nonatomic, weak) UIButton *backButton;

@property(atomic, retain) id<IJKMediaPlayback> player;

@end

extern const CGFloat kUIViewAYLExtensionViewMargin;

@implementation OCEPlayVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    self.player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:@"http://mov.bn.netease.com/open-movie/nos/mp4/2016/06/08/SBO4AK6DG_sd.m3u8" withOptions:options];
    
    UIView *playerView = [[UIView alloc] init];
    [self.navigationController.view addSubview:playerView];
    
    UIView *statusBarBackground = [[UIView alloc] init];
    statusBarBackground.backgroundColor = [UIColor blackColor];
    self.statusBarBackground = statusBarBackground;
    [playerView addSubview:statusBarBackground];
    
    self.playerView = playerView;
    
    [playerView addSubview:_player.view];
    
    UIImage *backImage = [UIImage imageNamed:@"player_back_black"];
    UIButton *backButton = [[UIButton alloc] init];
    [backButton addTarget:self action:@selector(backButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    self.backButton = backButton;
    [backButton setBackgroundImage:backImage forState:UIControlStateNormal];
    [self.navigationController.view addSubview:backButton];
    
    self.navigationController.navigationBar.hidden = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.hidesBackButton = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.player prepareToPlay];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // cell标识
    static NSString *ID = @"cell";
    // 从缓存池中取可用cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    cell.textLabel.text = @"haha";
    
    return cell;
}

- (void)backButtonDidClicked {
    [_player shutdown];
    [self.backButton removeFromSuperview];
    [self.playerView removeFromSuperview];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
