//
//  OCESearchResultCell.m
//  OpenCourse
//
//  Created by Oneself on 16/7/3.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCESearchResultCell.h"
#import "OCESearchResultCellLablesView.h"
#import "AYLDivider.h"
// category
#import "UIView+AYLExtension.h"
// macro
#define kOCESearchResultCellpicViewX kUIViewAYLExtensionViewMargin
#define kOCESearchResultCellpicViewW (AYLMainScreenBounds.size.width / 2 - 5 * kOCESearchResultCellpicViewX)
#define kOCESearchResultCellpicViewH (kOCESearchResultCellpicViewW / 16 * 9)
#define kOCESearchResultCellHeight (kOCESearchResultCellpicViewH + 2 * kOCESearchResultCellpicViewX)

@interface OCESearchResultCell()

// left views
@property (nonatomic, weak) UIImageView *picView;
// right views
@property (nonatomic, weak) OCESearchResultCellLablesView *lablesView;
// bottom views
@property (nonatomic, weak) UIView *cellDivider;

@end

extern const CGFloat kUIViewAYLExtensionViewMargin;

@implementation OCESearchResultCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"searchResult";
    OCESearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[OCESearchResultCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *contentView = self.contentView;
        
        // left views
        UIImageView *picView = [[UIImageView alloc] init];
        picView.backgroundColor = [UIColor orangeColor];
        [contentView addSubview:picView];
        _picView = picView;
        
        // right views
        OCESearchResultCellLablesView *lablesView = [[OCESearchResultCellLablesView alloc] init];
        [contentView addSubview:lablesView];
        _lablesView = lablesView;
        
        // bottom views
        AYLDivider *cellDivider = [[AYLDivider alloc] init];
        [contentView addSubview:cellDivider];
        _cellDivider = cellDivider;
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat picViewX = kOCESearchResultCellpicViewX;
    _picView.ayl_orign = CGPointMake(picViewX, picViewX);
    CGFloat picViewW = kOCESearchResultCellpicViewW;
    CGFloat picViewH = kOCESearchResultCellpicViewH;
    _picView.ayl_size = CGSizeMake(picViewW, picViewH);
    
    CGFloat cellDividerW = self.contentView.ayl_width;
    CGFloat cellDividerH = 0.5;
    CGFloat cellDividerY = kOCESearchResultCellHeight - cellDividerH;
    _cellDivider.frame = CGRectMake(0, cellDividerY, cellDividerW, cellDividerH);
    
    CGFloat lableViewX = _picView.ayl_right + picViewX;
    CGFloat lableViewY = _picView.ayl_y;
    CGFloat lableViewW = cellDividerW - picViewW - 3 * picViewX;
    CGFloat lableViewH = picViewH;
    _lablesView.frame = CGRectMake(lableViewX, lableViewY, lableViewW, lableViewH);
}

+ (CGFloat)cellHeight {
    return kOCESearchResultCellHeight;
}

@end
