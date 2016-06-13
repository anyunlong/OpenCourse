//
//  OCESearchHotCell.h
//  OpenCourse
//
//  Created by Oneself on 16/6/12.
//  Copyright © 2016年 CCUT. All rights reserved.
//

@class OCEHotKeyword;

@interface OCESearchHotCell : UITableViewCell

@property (nonatomic, strong) OCEHotKeyword *hotKeyword;

+ (OCESearchHotCell *)cellWithTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
