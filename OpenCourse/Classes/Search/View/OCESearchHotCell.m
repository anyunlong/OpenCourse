//
//  OCESearchHotCell.m
//  OpenCourse
//
//  Created by Oneself on 16/6/12.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCESearchHotCell.h"
// m
#import "OCEHotKeyword.h"

@interface OCESearchHotCell()

@property (nonatomic, weak) UIButton *numberView;
@property (nonatomic, weak) UILabel *titleView;
@property (nonatomic, weak) UILabel *descView;

@end

static const CGFloat kOCESearchHotCellTitleFontSize = 16;
static const CGFloat kOCESearchHotCellDescAndNumberFontSize = 15;
extern const CGFloat AYLViewsMargin;

@implementation OCESearchHotCell

+ (OCESearchHotCell *)cellWithTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    // cell标识
    static NSString *ID = @"searchHot";
    // 从缓存池中取可用cell
    OCESearchHotCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[OCESearchHotCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID indexPath:indexPath];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *contentView = self.contentView;
        
        UIButton *numberView = [[UIButton alloc] init];
        // 根据行号添加背景色
        UIColor *numberViewBgColor;
        NSInteger row = indexPath.row;
        switch (row) {
            case 0:
                numberViewBgColor = [UIColor redColor];
                break;
            case 1:
                numberViewBgColor = [UIColor orangeColor];
                break;
            case 2:
                numberViewBgColor = [UIColor yellowColor];
                break;
            default:
                numberViewBgColor = [UIColor lightGrayColor];
                break;
        }
        numberView.backgroundColor = numberViewBgColor;
        numberView.titleLabel.font = [UIFont systemFontOfSize:kOCESearchHotCellDescAndNumberFontSize];
        // 设置序号
        [numberView setTitle:[NSString stringWithFormat:@"%ld", row + 1] forState:UIControlStateNormal];
        // **
        [contentView addSubview:numberView];
        _numberView = numberView;
        
        UILabel *titleView = [[UILabel alloc] init];
        titleView.font = [UIFont systemFontOfSize:kOCESearchHotCellTitleFontSize];
        [contentView addSubview:titleView];
        _titleView = titleView;
        
        UILabel *descView = [[UILabel alloc] init];
        descView.textColor = [UIColor lightGrayColor];
        descView.font = [UIFont systemFontOfSize:kOCESearchHotCellDescAndNumberFontSize];
        [contentView addSubview:descView];
        _descView = descView;
    }
    
    return self;
}

- (void)setHotKeyword:(OCEHotKeyword *)hotKeyword {
    _hotKeyword = hotKeyword;
    
    _titleView.text = hotKeyword.value;
    
    _descView.text = hotKeyword.value1;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSDictionary *searchHotCellTitleFontAttr = @{NSFontAttributeName : [UIFont systemFontOfSize:kOCESearchHotCellTitleFontSize]};
    
    CGFloat viewWidth = self.ayl_width;
    CGFloat viewHeight = self.ayl_height;
    
    CGFloat numberViewX = AYLViewsMargin;
    _numberView.ayl_x = numberViewX;
    _numberView.ayl_centerY = viewHeight / 2;
    _numberView.ayl_size = CGSizeMake(20, 20);
    
    CGRect titleViewRect = [_titleView.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:searchHotCellTitleFontAttr context:nil];
    _titleView.frame = CGRectMake(_numberView.ayl_right + numberViewX, 0, titleViewRect.size.width, viewHeight);
    
    CGFloat descViewW = viewWidth - _titleView.ayl_right - 2 * numberViewX;
    _descView.frame = CGRectMake(_titleView.ayl_right + numberViewX, 0, descViewW, viewHeight);
}

@end
