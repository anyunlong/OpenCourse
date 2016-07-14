//
//  OCEMediaControl.m
//  OpenCourse
//
//  Created by Oneself on 16/7/13.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCEMediaControl.h"

@interface OCEMediaControl()

@property (strong, nonatomic) IBOutlet UIView   *overlay;
@property (strong, nonatomic) IBOutlet UIView   *bottomPanel;
@property (strong, nonatomic) IBOutlet UIView   *topPanel;
@property (strong, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) IBOutlet UIButton *pauseButton;
@property (strong, nonatomic) IBOutlet UIProgressView *mediaProgressSlider;
@property (strong, nonatomic) IBOutlet UILabel  *currentTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel  *totalDurationLabel;
@property (strong, nonatomic) IBOutlet UIButton *fullButton;

@end

@implementation OCEMediaControl

- (instancetype)init {
    if (self = [super init]) {
        self = [[NSBundle mainBundle] loadNibNamed:@"OCEMediaControl" owner:nil options:nil][0];
        
        UIImage *topPanelBgImg = [UIImage imageNamed:@"player_control_top"];
        self.topPanel.layer.contents = (id)topPanelBgImg.CGImage;
        
        UIImage *buttonPanelBgImg = [UIImage imageNamed:@"player_control_bottom"];
        self.bottomPanel.layer.contents = (id)buttonPanelBgImg.CGImage;
    }
    return self;
}

@end
