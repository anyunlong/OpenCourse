//
//  AYLDivider.m
//  OpenCourse
//
//  Created by Oneself on 16/7/4.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "AYLDivider.h"

@implementation AYLDivider

- (instancetype)init {
    if (self = [super init]) {
        self = [self.class divider];
    }
    
    return self;
}

+ (instancetype)divider {
    UIView *divider = [[UIView alloc] init];
    divider.backgroundColor = [UIColor lightGrayColor];
    
    return divider;
}

@end
