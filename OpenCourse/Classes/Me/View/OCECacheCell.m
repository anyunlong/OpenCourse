//
//  OCECacheCell.m
//  OpenCourse
//
//  Created by Oneself on 16/7/19.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCECacheCell.h"

@implementation OCECacheCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"cache";
    OCECacheCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"OCECacheCell" owner:nil options:nil][0];
    }
    
    return cell;
}

@end
