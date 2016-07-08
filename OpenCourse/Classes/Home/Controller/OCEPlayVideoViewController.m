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

@property(atomic, retain) id<IJKMediaPlayback> player;

@end

@implementation OCEPlayVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    self.player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:@"http://mov.bn.netease.com/open-movie/nos/mp4/2016/06/08/SBO4ABD6H_sd.mp4" withOptions:options];
    _player.view.frame = CGRectMake(0, [[UIApplication sharedApplication] statusBarFrame].size.height, AYLMainScreenBounds.size.width, 250);
    [self.navigationController.view addSubview:_player.view];
    
    self.navigationController.navigationBar.hidden = YES;
    self.tableView.contentInset = UIEdgeInsetsMake(_player.view.ayl_bottom, 0, 0, 0);
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView.backgroundColor = [UIColor greenColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.player prepareToPlay];
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
        cell.backgroundColor = [UIColor orangeColor];
    }
    
    cell.textLabel.text = @"haha";
    
    return cell;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
