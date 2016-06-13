//
//  OCESearchDataTool.h
//  OpenCourse
//
//  Created by Oneself on 16/6/13.
//  Copyright © 2016年 CCUT. All rights reserved.
//

@class OCESearchDataToolResult;

@interface OCESearchDataTool : NSObject

+ (void)searchDataWithProgress:(void (^)(NSProgress *downloadProgress))progress success:(void (^)(OCESearchDataToolResult *result))success failure:(void (^)(NSError *error))failure;

@end
