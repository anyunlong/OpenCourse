//
//  OCEMediaControl.h
//  OpenCourse
//
//  Created by Oneself on 16/7/13.
//  Copyright © 2016年 CCUT. All rights reserved.
//

// framework
#import <MobileVLCKit/MobileVLCKit.h>

@interface OCEMediaControl : UIControl

@property (nonatomic, weak) VLCMediaPlayer *player;

@property (strong, nonatomic) IBOutlet UIControl *overlay;

- (void)hide;
- (void)show;
- (void)pause;
- (void)play;

@end
