//
//  OCESearchHotCell.m
//  OpenCourse
//
//  Created by Oneself on 16/6/12.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCESearchHotCell.h"
// category
#import "UIView+AYLExtension.h"

@interface OCESearchHotCell()

@property (nonatomic, weak) UIButton *numberView;
@property (nonatomic, weak) UILabel *titleView;
@property (nonatomic, weak) UILabel *descView;

@end

extern const CGFloat kUIViewAYLExtensionViewMargin;

@implementation OCESearchHotCell

+ (OCESearchHotCell *)cellWithTable:(UITableView *)tableView {
    // cell标识
    static NSString *ID = @"searchHot";
    // 从缓存池中取可用cell
    OCESearchHotCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[OCESearchHotCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIButton *numberView = [[UIButton alloc] init];
        numberView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:numberView];
        _numberView = numberView;
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _numberView.ayl_x = kUIViewAYLExtensionViewMargin;
    _numberView.ayl_centerY = self.ayl_height / 2;
    _numberView.ayl_size = CGSizeMake(20, 20);
}

@end
