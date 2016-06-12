//
//  NSData+AYLExtension.m
//
//  Created by Oneself on 16/6/2.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "NSData+AYLExtension.h"

@implementation NSData (AYLExtension)

+ (NSString *)ayl_dataStringWithTimestamp:(NSString *)timestamp {
    NSString *str = timestamp; //时间戳
    NSTimeInterval time = [str doubleValue] + 28800; // 因为时差问题要加8小时 == 28800 sec
    NSDate *detailDate = [NSDate dateWithTimeIntervalSince1970:time];
    // 实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *dateStr = [dateFormatter stringFromDate:detailDate];
    
    return dateStr;
}

@end
