//
//  OCEBaseTableViewCell.m
//  OpenCourse
//
//  Created by Oneself on 16/7/19.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCEBaseTableViewCell.h"

@interface OCEBaseTableViewCell()

@end

@implementation OCEBaseTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier {
    OCEBaseTableViewCell *baseTableViewCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!baseTableViewCell) {
        baseTableViewCell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    return baseTableViewCell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor ayl_systemTableViewBackgroundColor];
        
        UIButton *listBtn = [[UIButton alloc] init];
        [listBtn setBackgroundImage:[UIImage ayl_resizedImageWithName:@"course_grid_bg"] forState:UIControlStateNormal];
        [listBtn setBackgroundImage:[UIImage ayl_resizedImageWithName:@"course_grid_bg_pressed"] forState:UIControlStateHighlighted];
        [self.contentView addSubview:listBtn];
        self.listBtn = listBtn;
        
        UIButton *picView = [[UIButton alloc] init];
        [self.listBtn addSubview:picView];
        self.picView = picView;
    }
    return self;
}

@end
