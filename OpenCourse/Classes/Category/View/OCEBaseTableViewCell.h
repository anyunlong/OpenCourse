//
//  OCEBaseTableViewCell.h
//  OpenCourse
//
//  Created by Oneself on 16/7/19.
//  Copyright © 2016年 CCUT. All rights reserved.
//

@interface OCEBaseTableViewCell : UITableViewCell

// 占据整个cell的button
@property (nonatomic, weak) UIButton *listBtn;
// 图片view
@property (nonatomic, weak) UIButton *picView;

+ (instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier;

@end
