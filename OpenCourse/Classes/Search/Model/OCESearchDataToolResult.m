//
//  OCESearchDataToolResult.m
//  OpenCourse
//
//  Created by Oneself on 16/6/13.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCESearchDataToolResult.h"
#import "OCEHotKeyword.h"

@implementation OCESearchDataToolResult

+ (NSDictionary *)objectClassInArray
{
    return @{@"hotKeywords" : [OCEHotKeyword class]};
}

@end
