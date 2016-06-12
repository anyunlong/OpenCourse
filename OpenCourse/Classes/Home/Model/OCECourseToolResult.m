//
//  OCECourseToolResult.m
//  OpenCourse
//
//  Created by Oneself on 16/6/5.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCECourseToolResult.h"
// m
#import "OCECourse.h"

@implementation OCECourseToolResult

+ (NSDictionary *)objectClassInArray
{
    return @{@"courses" : [OCECourse class]};
}

@end
