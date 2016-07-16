//
//  AYLMacro.h
//  OpenCourse
//
//  Created by Oneself on 16/7/14.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#ifndef AYLMacro_h
#define AYLMacro_h

/* log */
#ifdef DEBUG
#define AYLLog(...) NSLog(__VA_ARGS__)
#else
#define AYLLog(...)
#endif
/* device */
#define AYLStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define SCREEN_BOUNDS      [UIScreen mainScreen].bounds
#define SCREEN_SIZE        SCREEN_BOUNDS.size
#define SCREEN_WIDTH       SCREEN_SIZE.width
#define SCREEN_HEIGHT      SCREEN_SIZE.height
/* shareInstance */
#define AYLNotificationCenter [NSNotificationCenter defaultCenter]

#endif /* AYLMacro_h */
