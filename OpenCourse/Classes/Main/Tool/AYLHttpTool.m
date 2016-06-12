//
//  AYLHttpTool.m
//
//  Created by Oneself on 16/6/5.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "AYLHttpTool.h"
// framework
#import <AFNetworking.h>

@implementation AYLHttpTool

+ (void)ayl_getWithURL:(NSString *)url parameters:(NSDictionary *)parameters progress:(void (^)(NSProgress *downloadProgress))progress success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        AYLLog(@"%@", @"progress");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success)
            success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure)
            failure(error);
    }];
}

@end
