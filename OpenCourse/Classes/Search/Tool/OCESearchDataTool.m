//
//  OCESearchDataTool.m
//  OpenCourse
//
//  Created by Oneself on 16/6/13.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCESearchDataTool.h"
// m
#import "OCESearchDataToolResult.h"
#import "OCEHotKeyword.h"
// tool
#import "AYLHttpTool.h"

@implementation OCESearchDataTool

+ (void)searchDataWithProgress:(void (^)(NSProgress *downloadProgress))progress success:(void (^)(OCESearchDataToolResult *result))success failure:(void (^)(NSError *error))failure {
    [AYLHttpTool getWithURL:@"http://c.open.163.com/mob/home/config.do" parameters:nil progress:^(NSProgress *downloadProgress) {
        AYLLog(@"%@", @"progress");
    } success:^(id responseObject) {
        if (success) {
            OCESearchDataToolResult *result = [[OCESearchDataToolResult alloc] init];
            
            NSDictionary *dataDict = responseObject[@"data"];
            result.searchKeyword = dataDict[@"searchKeyword"][@"value"];
            result.hotKeywords = [OCEHotKeyword mj_objectArrayWithKeyValuesArray:dataDict[@"hotKeywords"]];
            
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
