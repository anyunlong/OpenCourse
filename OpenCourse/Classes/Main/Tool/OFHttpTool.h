//
//  OFHttpTool.h
//  OpenCourse
//
//  Created by Oneself on 16/6/5.
//  Copyright © 2016年 CCUT. All rights reserved.
//

@interface OFHttpTool : NSObject

// 封装AFN-GET方法
+ (void)getWithURL:(NSString *)url parameters:(NSDictionary *)parameters progress:(void (^)(NSProgress *downloadProgress))progress success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
