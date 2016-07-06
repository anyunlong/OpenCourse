//
//  OCESearchResultCellLablesView.m
//  OpenCourse
//
//  Created by Oneself on 16/7/4.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCESearchResultCellLablesView.h"
// m
#import "OCESearchResultCourse.h"

@interface OCESearchResultCellLablesView()

@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UILabel *tagsView;
@property (weak, nonatomic) IBOutlet UILabel *playcountAndUpdatedPlaycountView;

@end

@implementation OCESearchResultCellLablesView

- (instancetype)init {
    if (self = [super init]) {
        self = [[NSBundle mainBundle] loadNibNamed:@"OCESearchResultCellLablesView" owner:nil options:nil][0];
    }
    
    return self;
}

- (void)setCourse:(OCESearchResultCourse *)course {
    _course = course;
    
    _titleView.attributedText = course.workedTitle;
    _tagsView.attributedText = course.workedTags;
    _playcountAndUpdatedPlaycountView.text = [[NSString stringWithFormat:@"集数：%@  已译：%@", course.playcount, course.updatedPlaycount] copy];
}

@end
