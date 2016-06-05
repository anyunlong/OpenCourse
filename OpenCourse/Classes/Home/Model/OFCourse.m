//
//  OFCourse.m
//  OpenCourse
//
//  Created by Oneself on 16/6/1.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OFCourse.h"
// category
#import "NSData+Extension.h"

@implementation OFCourse

- (void)setDbCreateTime:(NSString *)dbCreateTime {
    // 请求返回的时间戳删除后三位(返回的时间戳后三位是000,不知道做什么的-_-!)
    NSString *timestamp = [dbCreateTime substringToIndex:dbCreateTime.length - 3];
    // 时间戳转日期
    _dbCreateTime = [[NSData dataStringWithTimestamp:timestamp] copy];
}

@end
