//
//  OCESearchResultTableHeaderView.m
//  OpenCourse
//
//  Created by Oneself on 16/7/3.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCESearchResultTableHeaderView.h"
// category
#import "UIView+AYLExtension.h"

@interface OCESearchResultTableHeaderView()

@property (weak, nonatomic) IBOutlet UILabel *searchResultLable;

@end

const CGFloat kOCESearchResultTableHeaderViewHeight = 50;
extern const CGFloat kUIViewAYLExtensionViewMargin;

@implementation OCESearchResultTableHeaderView

- (instancetype)init {
    if (self = [super init]) {
        self = [[NSBundle mainBundle] loadNibNamed:@"OCESearchResultTableHeaderView" owner:nil options:nil][0];
        
        self.ayl_height = kOCESearchResultTableHeaderViewHeight;
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _searchResultLable.ayl_x = kUIViewAYLExtensionViewMargin;
    _searchResultLable.ayl_height = kOCESearchResultTableHeaderViewHeight;
}

@end
