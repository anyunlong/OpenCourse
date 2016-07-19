//
//  OCEClassifySectionCell.m
//  OpenCourse
//
//  Created by Oneself on 16/7/19.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCEClassifySectionCell.h"

@interface OCEClassifySectionCell()

@end

static NSString *kClassifySectionCellIdentifier = @"classifySection";

@implementation OCEClassifySectionCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    return [super cellWithTableView:tableView identifier:kClassifySectionCellIdentifier];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.picView setBackgroundImage:[UIImage imageNamed:@"fenlei_hot"] forState:UIControlStateNormal];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.picView.ayl_size = self.picView.currentBackgroundImage.size;
    
    self.listBtn.ayl_size = CGSizeMake(SCREEN_WIDTH, self.picView.ayl_height);
}

@end
