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
// category
#import "UIColor+AYLExtension.h"
#import "UIImage+AYLExtension.h"
// framework
#import <UIImageView+WebCache.h>

@interface OCECourseCell()

// 占据整个cell的button
@property (nonatomic, weak) UIButton *listBtn;
// 图片view
@property (nonatomic, weak) UIImageView *picView;
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

const CGFloat kOCECourseCellTitleFontSize = 17;
const CGFloat kOCECourseCellDescFontSize = 13;
const CGFloat kOCECourseCellOthersFontSize = 11; // 类型、创建时间、观看数、vedioView
extern const CGFloat kUIViewAYLExtensionViewMargin;

@implementation OCECourseCell

+ (OCECourseCell *)cellWithTableView:(UITableView *)tableView {
    // cell标识
    static NSString *ID = @"course";
    // 从缓存池中取可用cell
    OCECourseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor ayl_systemTableViewBackgroundColor];
        
        UIButton *listBtn = [[UIButton alloc] init];
        [listBtn setBackgroundImage:[UIImage ayl_resizedImageWithName:@"course_grid_bg"] forState:UIControlStateNormal];
        [listBtn setBackgroundImage:[UIImage ayl_resizedImageWithName:@"course_grid_bg_pressed"] forState:UIControlStateHighlighted];
        [listBtn addTarget:self action:@selector(listBtnDidClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:listBtn];
        self.listBtn = listBtn;
        
        UIImageView *picView = [[UIImageView alloc] init];
        [listBtn addSubview:picView];
        self.picView = picView;
        
        UIButton *rtypeView = [[UIButton alloc] init];
        rtypeView.userInteractionEnabled = NO;
        rtypeView.titleEdgeInsets = UIEdgeInsetsMake(0, kUIViewAYLExtensionViewMargin, 0, 0);
        rtypeView.titleLabel.font = [UIFont systemFontOfSize:kOCECourseCellOthersFontSize];
        [listBtn addSubview:rtypeView];
        self.rtypeView = rtypeView;
        
        UILabel *courseTypeView = [[UILabel alloc] init];
        courseTypeView.textAlignment = NSTextAlignmentCenter;
        courseTypeView.textColor = [UIColor whiteColor];
        courseTypeView.font = [UIFont systemFontOfSize:kOCECourseCellOthersFontSize];
        [courseTypeView.layer setMasksToBounds:YES];
        [courseTypeView.layer setCornerRadius:5];
        [listBtn addSubview:courseTypeView];
        self.courseTypeView = courseTypeView;
        
        UILabel *createTimeView = [[UILabel alloc] init];
        createTimeView.textColor = [UIColor lightGrayColor];
        createTimeView.font = [UIFont systemFontOfSize:kOCECourseCellOthersFontSize];
        [listBtn addSubview:createTimeView];
        self.createTimeView = createTimeView;
        
        UILabel *titleView = [[UILabel alloc] init];
        titleView.font = [UIFont systemFontOfSize:kOCECourseCellTitleFontSize];
        [listBtn addSubview:titleView];
        self.titleView = titleView;
        
        UILabel *descView = [[UILabel alloc] init];
        descView.textColor = [UIColor grayColor];
        descView.font = [UIFont systemFontOfSize:kOCECourseCellDescFontSize];
        descView.numberOfLines = 0;
        [listBtn addSubview:descView];
        self.descView = descView;
        
        UILabel *viewcountView = [[UILabel alloc] init];
        viewcountView.textColor = [UIColor lightGrayColor];
        viewcountView.font = [UIFont systemFontOfSize:kOCECourseCellOthersFontSize];
        [listBtn addSubview:viewcountView];
        self.viewcountView = viewcountView;
        
        UIButton *shareView = [[UIButton alloc] init];
        [shareView setBackgroundImage:[UIImage imageNamed:@"home_shared"] forState:UIControlStateNormal];
        [listBtn addSubview:shareView];
        self.shareView = shareView;
        
        UIView *divider = [[UIView alloc] init];
        divider.backgroundColor = [UIColor grayColor];
        [listBtn addSubview:divider];
        self.divider = divider;
        
        UIButton *likeView = [[UIButton alloc] init];
        [likeView setBackgroundImage:[UIImage imageNamed:@"home_tolike"] forState:UIControlStateNormal];
        [listBtn addSubview:likeView];
        self.likeView = likeView;
    }
    
    return self;
}

- (void)setCourseFrame:(OCECourseFrame *)courseFrame {
    _courseFrame = courseFrame;
    OCECourse *course = courseFrame.course;
    
    // 占据整个cell的button
    self.listBtn.frame = courseFrame.listBtnF;
    // 图片view
    [self.picView sd_setImageWithURL:[NSURL URLWithString:course.picUrl] placeholderImage:nil];
    self.picView.frame = courseFrame.picViewF;
    // rtypeView
    NSString *imgName;
    NSString *bgImgName;
    switch (course.rtype) {
        case OCECourseRtypeVideo:
            imgName = @"home_video";
            bgImgName = @"home_video_b";
            [self.rtypeView setTitle:course.quantity forState:UIControlStateNormal];
            break;
        case OCECourseRtypeH5:
            imgName = @"home_h5";
            bgImgName = @"home_article_b";
            [self.rtypeView setTitle:nil forState:UIControlStateNormal];
            break;
    }
    [self.rtypeView setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [self.rtypeView setBackgroundImage:[UIImage imageNamed:bgImgName] forState:UIControlStateNormal];
    self.rtypeView.frame = courseFrame.rtypeViewF;
    // 课程类型view
    self.courseTypeView.text = course.courseType;
    self.courseTypeView.backgroundColor = [UIColor ayl_colorWithHexString:course.tagBgColor];
    self.courseTypeView.frame = courseFrame.courseTypeViewF;
    // 创建时间view
    self.createTimeView.text = course.dbCreateTime;
    self.createTimeView.frame = courseFrame.createTimeViewF;
    // 标题view
    self.titleView.text = course.title;
    self.titleView.frame = courseFrame.titleViewF;
    // 简介view
    self.descView.text = course.desc;
    self.descView.frame = courseFrame.descViewF;
    // viewcountView
    self.viewcountView.text = course.viewcount;
    self.viewcountView.frame = courseFrame.viewconutViewF;
    // shareView
    self.shareView.frame = courseFrame.shareViewF;
    // divider
    self.divider.frame = courseFrame.dividerF;
    // likeView
    self.likeView.frame = courseFrame.likeViewF;
}

- (void)listBtnDidClicked {
    if ([_delegate respondsToSelector:@selector(courseCell:didClickedButtonAtIndex:)]) {
        [_delegate courseCell:self didClickedButtonAtIndex:self.tag];
    }
}

@end
