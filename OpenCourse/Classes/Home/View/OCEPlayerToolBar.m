//
//  OCEPlayerToolBar.m
//  OpenCourse
//
//  Created by Oneself on 16/7/9.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCEPlayerToolBar.h"

@implementation OCEPlayerToolBar

- (instancetype)init {
    if (self = [super init]) {
        self = [[NSBundle mainBundle] loadNibNamed:@"OCEPlayerToolBar" owner:nil options:nil][0];
    }
    
    return self;
}

@end
