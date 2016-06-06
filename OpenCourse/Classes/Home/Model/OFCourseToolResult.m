//
//  OFCourseToolResult.m
//  OpenCourse
//
//  Created by Oneself on 16/6/5.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OFCourseToolResult.h"
// m
#import "OFCourse.h"

@implementation OFCourseToolResult

+ (NSDictionary *)objectClassInArray
{
    return @{@"courses" : [OFCourse class]};
}

@end
