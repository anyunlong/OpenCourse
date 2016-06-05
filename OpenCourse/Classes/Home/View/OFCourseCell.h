//
//  OFCourseCell.h
//  OpenCourse
//
//  Created by Oneself on 16/6/1.
//  Copyright © 2016年 CCUT. All rights reserved.
//

@class OFCourseFrame;

@interface OFCourseCell : UITableViewCell

@property (nonatomic, strong) OFCourseFrame *courseFrame;

+ (OFCourseCell *)cellWithTableView:(UITableView *)tableView;

@end
