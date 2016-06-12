//
//  OCECourseTool.m
//  OpenCourse
//
//  Created by Oneself on 16/6/5.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCECourseTool.h"
// m
#import "OCECourse.h"
#import "OCECourseToolParam.h"
#import "OCECourseToolResult.h"
// main-tool
#import "AYLHttpTool.h"
// framework
#import <MJExtension.h>

@implementation OCECourseTool

+ (void)coursesWithParameters:(OCECourseToolParam *)param progress:(void (^)(NSProgress *downloadProgress))progress success:(void (^)(OCECourseToolResult *result))success failure:(void (^)(NSError *error))failure {
    [AYLHttpTool ayl_getWithURL:@"http://c.open.163.com/mob/home/list.do" parameters:param.mj_keyValues progress:^(NSProgress *downloadProgress) {
        AYLLog(@"%@", @"progress");
    } success:^(id responseObject) {
        if (success) {
            [OCECourse mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{
                         @"desc"    : @"description"
                         };
            }];
            OCECourseToolResult *result = [[OCECourseToolResult alloc] init];
            result.courses = [OCECourse mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }  
    }];
}

@end
