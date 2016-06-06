//
//  OFCourseTool.h
//  OpenCourse
//
//  Created by Oneself on 16/6/5.
//  Copyright © 2016年 CCUT. All rights reserved.
//

@class OFCourseToolParam, OFCourseToolResult;

@interface OFCourseTool : NSObject

// 请求course数据
+ (void)coursesWithParameters:(OFCourseToolParam *)param progress:(void (^)(NSProgress *downloadProgress))progress success:(void (^)(OFCourseToolResult *result))success failure:(void (^)(NSError *error))failure;

@end
