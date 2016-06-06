//
//  OFCourseTool.m
//  OpenCourse
//
//  Created by Oneself on 16/6/5.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OFCourseTool.h"
// m
#import "OFCourse.h"
#import "OFCourseToolParam.h"
#import "OFCourseToolResult.h"
// main-tool
#import "OFHttpTool.h"
// framework
#import <MJExtension.h>

@implementation OFCourseTool

+ (void)coursesWithParameters:(OFCourseToolParam *)param progress:(void (^)(NSProgress *downloadProgress))progress success:(void (^)(OFCourseToolResult *result))success failure:(void (^)(NSError *error))failure {
    [OFHttpTool getWithURL:@"http://c.open.163.com/mob/home/list.do" parameters:param.mj_keyValues progress:^(NSProgress *downloadProgress) {
        OFLog(@"%@", @"progress");
    } success:^(id responseObject) {
        if (success) {
            [OFCourse mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{
                         @"desc"    : @"description"
                         };
            }];
            OFCourseToolResult *result = [[OFCourseToolResult alloc] init];
            result.courses = [OFCourse mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
