//
//  OCEMediaControl.m
//  OpenCourse
//
//  Created by Oneself on 16/7/13.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCEMediaControl.h"

@interface OCEMediaControl()

@property (strong, nonatomic) IBOutlet UIView   *bottomPanel;
@property (strong, nonatomic) IBOutlet UIView   *topPanel;
@property (strong, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) IBOutlet UIButton *pauseButton;
@property (strong, nonatomic) IBOutlet UIProgressView *mediaProgressSlider;
@property (strong, nonatomic) IBOutlet UILabel  *currentTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel  *totalDurationLabel;
@property (strong, nonatomic) IBOutlet UIButton *fullButton;
@property (strong, nonatomic) IBOutlet UIButton *reportButton;

@end

@implementation OCEMediaControl

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIImage *topPanelBgImg = [UIImage imageNamed:@"player_control_top"];
    self.topPanel.layer.contents = (id)topPanelBgImg.CGImage;
    
    UIImage *buttonPanelBgImg = [UIImage imageNamed:@"player_control_bottom"];
    self.bottomPanel.layer.contents = (id)buttonPanelBgImg.CGImage;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.playButton.ayl_size             = _playButton.currentBackgroundImage.size;
    
    self.pauseButton.ayl_size            = _playButton.ayl_size;
    
    self.fullButton.ayl_size             = _fullButton.currentBackgroundImage.size;
    
    self.mediaProgressSlider.ayl_centerY = _playButton.ayl_centerY;
    self.mediaProgressSlider.ayl_x       = _currentTimeLabel.ayl_right + _playButton.ayl_x;
    CGFloat mediaProgressSliderW         = _totalDurationLabel.ayl_x - _mediaProgressSlider.ayl_x - _playButton.ayl_x;
    self.mediaProgressSlider.ayl_width   = mediaProgressSliderW;
    
    self.reportButton.ayl_size           = _reportButton.currentBackgroundImage.size;
}

- (void)hide {
    self.overlay.hidden = YES;
}

- (void)show {
    self.overlay.hidden = NO;
}

- (void)pause {
    [self.player pause];
    [self refreshMediaControl];
}

- (void)play {
    [self.player play];
    [self refreshMediaControl];
}

- (void)refreshMediaControl {
    BOOL isPlaying = _player.isPlaying;
    self.pauseButton.hidden = isPlaying;
    self.playButton.hidden = !isPlaying;
}

@end
