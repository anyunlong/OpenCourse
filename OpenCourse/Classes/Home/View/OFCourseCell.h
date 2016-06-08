//
//  OFCourseCell.h
//  OpenCourse
//
//  Created by Oneself on 16/6/1.
//  Copyright © 2016年 CCUT. All rights reserved.
//

@class OFCourseFrame, OFCourseCell;

@protocol OFCourseCellDelegate <NSObject>

@optional
- (void)courseCell:(OFCourseCell *)courseCell didClickedButtonAtIndex:(NSInteger)index;

@end

@interface OFCourseCell : UITableViewCell

@property (nonatomic, weak) id<OFCourseCellDelegate> delegate;
@property (nonatomic, strong) OFCourseFrame *courseFrame;

+ (OFCourseCell *)cellWithTableView:(UITableView *)tableView;

@end
