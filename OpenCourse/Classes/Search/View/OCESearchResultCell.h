//
//  OCESearchResultCell.h
//  OpenCourse
//
//  Created by Oneself on 16/7/3.
//  Copyright © 2016年 CCUT. All rights reserved.
//

@class OCESearchResultCourse;

@interface OCESearchResultCell : UITableViewCell

@property (nonatomic, strong) OCESearchResultCourse *course;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)cellHeight;

@end
