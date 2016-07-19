//
//  OCECourseCell.m
//  OpenCourse
//
//  Created by Oneself on 16/6/1.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCECourseCell.h"
// m
#import "OCECourseFrame.h"
#import "OCECourse.h"
// framework
#import <UIButton+WebCache.h>

@interface OCECourseCell()

// 原文件类型view
@property (nonatomic, weak) UIButton *rtypeView;
// 课程类型view
@property (nonatomic, weak) UILabel *courseTypeView;
// 创建时间view
@property (nonatomic, weak) UILabel *createTimeView;
// 标题view
@property (nonatomic, weak) UILabel *titleView;
// 简介view
@property (nonatomic, weak) UILabel *descView;
// 观看数view
@property (nonatomic, weak) UILabel *viewcountView;
// 分享view
@property (nonatomic, weak) UIButton *shareView;
// divider
@property (nonatomic, weak) UIView *divider;
// 喜欢view
@property (nonatomic, weak) UIButton *likeView;

@end

static NSString *kCourseCellIdentifier = @"course";
const CGFloat kOCECourseCellTitleFontSize = 17;
const CGFloat kOCECourseCellDescFontSize = 13;
const CGFloat kOCECourseCellOthersFontSize = 11; // 类型、创建时间、观看数、vedioView
extern const CGFloat AYLViewsMargin;

@implementation OCECourseCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    return [super cellWithTableView:tableView identifier:kCourseCellIdentifier];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.listBtn addTarget:self action:@selector(listBtnDidClicked) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *rtypeView = [[UIButton alloc] init];
        rtypeView.userInteractionEnabled = NO;
        rtypeView.titleEdgeInsets = UIEdgeInsetsMake(0, AYLViewsMargin / 2, 0, 0);
        rtypeView.titleLabel.font = [UIFont systemFontOfSize:kOCECourseCellOthersFontSize];
        [self.listBtn addSubview:rtypeView];
        _rtypeView = rtypeView;
        
        UILabel *courseTypeView = [[UILabel alloc] init];
        courseTypeView.textAlignment = NSTextAlignmentCenter;
        courseTypeView.textColor = [UIColor whiteColor];
        courseTypeView.font = [UIFont systemFontOfSize:kOCECourseCellOthersFontSize];
        [courseTypeView.layer setMasksToBounds:YES];
        [courseTypeView.layer setCornerRadius:5];
        [self.listBtn addSubview:courseTypeView];
        _courseTypeView = courseTypeView;
        
        UILabel *createTimeView = [[UILabel alloc] init];
        createTimeView.textColor = [UIColor lightGrayColor];
        createTimeView.font = [UIFont systemFontOfSize:kOCECourseCellOthersFontSize];
        [self.listBtn addSubview:createTimeView];
        _createTimeView = createTimeView;
        
        UILabel *titleView = [[UILabel alloc] init];
        titleView.font = [UIFont systemFontOfSize:kOCECourseCellTitleFontSize];
        [self.listBtn addSubview:titleView];
        _titleView = titleView;
        
        UILabel *descView = [[UILabel alloc] init];
        descView.textColor = [UIColor grayColor];
        descView.font = [UIFont systemFontOfSize:kOCECourseCellDescFontSize];
        descView.numberOfLines = 0;
        [self.listBtn addSubview:descView];
        _descView = descView;
        
        UILabel *viewcountView = [[UILabel alloc] init];
        viewcountView.textColor = [UIColor lightGrayColor];
        viewcountView.font = [UIFont systemFontOfSize:kOCECourseCellOthersFontSize];
        [self.listBtn addSubview:viewcountView];
        _viewcountView = viewcountView;
        
        UIButton *shareView = [[UIButton alloc] init];
        [shareView setBackgroundImage:[UIImage imageNamed:@"home_shared"] forState:UIControlStateNormal];
        [self.listBtn addSubview:shareView];
        _shareView = shareView;
        
        AYLDivider *divider = [AYLDivider ayl_divider];
        [self.listBtn addSubview:divider];
        _divider = divider;
        
        UIButton *likeView = [[UIButton alloc] init];
        [likeView setBackgroundImage:[UIImage imageNamed:@"home_tolike"] forState:UIControlStateNormal];
        [self.listBtn addSubview:likeView];
        _likeView = likeView;
    }
    
    return self;
}

- (void)setCourseFrame:(OCECourseFrame *)courseFrame {
    _courseFrame = courseFrame;
    OCECourse *course = courseFrame.course;
    
    // 占据整个cell的button
    self.listBtn.frame = courseFrame.listBtnF;
    // 图片view
    [self.picView sd_setImageWithURL:[NSURL URLWithString:course.picUrl] forState:UIControlStateNormal];
    self.picView.frame = courseFrame.picViewF;
    // rtypeView
    NSString *imgName;
    NSString *bgImgName;
    switch (course.rtype) {
        case OCECourseRtypeVideo:
            imgName = @"home_video";
            bgImgName = @"home_video_b";
            [_rtypeView setTitle:course.quantity forState:UIControlStateNormal];
            break;
        case OCECourseRtypeH5:
            imgName = @"home_h5";
            bgImgName = @"home_article_b";
            [_rtypeView setTitle:nil forState:UIControlStateNormal];
            break;
    }
    [_rtypeView setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [_rtypeView setBackgroundImage:[UIImage imageNamed:bgImgName] forState:UIControlStateNormal];
    _rtypeView.frame = courseFrame.rtypeViewF;
    // 课程类型view
    _courseTypeView.text = course.courseType;
    _courseTypeView.backgroundColor = [UIColor ayl_colorWithHexString:course.tagBgColor];
    _courseTypeView.frame = courseFrame.courseTypeViewF;
    // 创建时间view
    _createTimeView.text = course.dbCreateTime;
    _createTimeView.frame = courseFrame.createTimeViewF;
    // 标题view
    _titleView.text = course.title;
    _titleView.frame = courseFrame.titleViewF;
    // 简介view
    _descView.text = course.desc;
    _descView.frame = courseFrame.descViewF;
    // viewcountView
    _viewcountView.text = course.viewcount;
    _viewcountView.frame = courseFrame.viewconutViewF;
    // shareView
    _shareView.frame = courseFrame.shareViewF;
    // divider
    _divider.frame = courseFrame.dividerF;
    // likeView
    _likeView.frame = courseFrame.likeViewF;
}

- (void)listBtnDidClicked {
    if ([_delegate respondsToSelector:@selector(courseCell:didClickedButtonAtIndex:)]) {
        [_delegate courseCell:self didClickedButtonAtIndex:self.tag];
    }
}

@end
