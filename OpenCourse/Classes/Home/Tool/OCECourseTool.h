//
//  OCECourseTool.h
//  OpenCourse
//
//  Created by Oneself on 16/6/5.
//  Copyright © 2016年 CCUT. All rights reserved.
//

@class OCECourseToolParam, OCECourseToolResult;

@interface OCECourseTool : NSObject

// 请求course数据
+ (void)coursesWithParameters:(OCECourseToolParam *)param progress:(void (^)(NSProgress *downloadProgress))progress success:(void (^)(OCECourseToolResult *result))success failure:(void (^)(NSError *error))failure;

@end
