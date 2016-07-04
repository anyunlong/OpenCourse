//
//  OCESearchResultCellLablesView.m
//  OpenCourse
//
//  Created by Oneself on 16/7/4.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCESearchResultCellLablesView.h"

@implementation OCESearchResultCellLablesView

- (instancetype)init {
    if (self = [super init]) {
        self = [[NSBundle mainBundle] loadNibNamed:@"OCESearchResultCellLablesView" owner:nil options:nil][0];
    }
    
    return self;
}

@end
