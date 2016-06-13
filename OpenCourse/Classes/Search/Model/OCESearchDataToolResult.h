//
//  OCESearchDataToolResult.h
//  OpenCourse
//
//  Created by Oneself on 16/6/13.
//  Copyright © 2016年 CCUT. All rights reserved.
//

@class OCEHotKeyword;

@interface OCESearchDataToolResult : NSObject

@property (nonatomic, copy) NSString *searchKeyword;
@property (nonatomic, strong) NSArray<OCEHotKeyword *> *hotKeywords;

@end
