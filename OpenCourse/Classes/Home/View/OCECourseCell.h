//
//  OCECourseCell.h
//  OpenCourse
//
//  Created by Oneself on 16/6/1.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCEBaseTableViewCell.h"

@class OCECourseFrame, OCECourseCell;

@protocol OCECourseCellDelegate <NSObject>

@optional
- (void)courseCell:(OCECourseCell *)courseCell didClickedButtonAtIndex:(NSInteger)index;

@end

@interface OCECourseCell : OCEBaseTableViewCell

@property (nonatomic, weak) id<OCECourseCellDelegate> delegate;
@property (nonatomic, strong) OCECourseFrame *courseFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
