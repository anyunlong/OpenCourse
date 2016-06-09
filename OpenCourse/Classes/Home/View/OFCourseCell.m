//
//  OFCourseCell.m
//  OpenCourse
//
//  Created by Oneself on 16/6/1.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OFCourseCell.h"
// m
#import "OFCourseFrame.h"
#import "OFCourse.h"
// category
#import "UIColor+Extension.h"
#import "UIImage+Extension.h"
// framework
#import <UIImageView+WebCache.h>

@interface OFCourseCell()

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

const CGFloat kOFCourseCellTitleFontSize = 17;
const CGFloat kOFCourseCellDescFontSize = 13;
const CGFloat kOFCourseCellOthersFontSize = 11; // 类型、创建时间、观看数、vedioView
extern const CGFloat kUIViewExtensionViewMargin;

@implementation OFCourseCell

+ (OFCourseCell *)cellWithTableView:(UITableView *)tableView {
    // cell标识
    static NSString *ID = @"course";
    // 从缓存池中取可用cell
    OFCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor systemTableViewBackgroundColor];
        
        UIButton *listBtn = [[UIButton alloc] init];
        [listBtn setBackgroundImage:[UIImage resizedImageWithName:@"course_grid_bg"] forState:UIControlStateNormal];
        [listBtn setBackgroundImage:[UIImage resizedImageWithName:@"course_grid_bg_pressed"] forState:UIControlStateHighlighted];
        [listBtn addTarget:self action:@selector(listBtnDidClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:listBtn];
        self.listBtn = listBtn;
        
        UIImageView *picView = [[UIImageView alloc] init];
        [listBtn addSubview:picView];
        self.picView = picView;
        
        UIButton *rtypeView = [[UIButton alloc] init];
        rtypeView.userInteractionEnabled = NO;
        rtypeView.titleEdgeInsets = UIEdgeInsetsMake(0, kUIViewExtensionViewMargin, 0, 0);
        rtypeView.titleLabel.font = [UIFont systemFontOfSize:kOFCourseCellOthersFontSize];
        [listBtn addSubview:rtypeView];
        self.rtypeView = rtypeView;
        
        UILabel *courseTypeView = [[UILabel alloc] init];
        courseTypeView.textAlignment = NSTextAlignmentCenter;
        courseTypeView.textColor = [UIColor whiteColor];
        courseTypeView.font = [UIFont systemFontOfSize:kOFCourseCellOthersFontSize];
        [courseTypeView.layer setMasksToBounds:YES];
        [courseTypeView.layer setCornerRadius:5];
        [listBtn addSubview:courseTypeView];
        self.courseTypeView = courseTypeView;
        
        UILabel *createTimeView = [[UILabel alloc] init];
        createTimeView.textColor = [UIColor lightGrayColor];
        createTimeView.font = [UIFont systemFontOfSize:kOFCourseCellOthersFontSize];
        [listBtn addSubview:createTimeView];
        self.createTimeView = createTimeView;
        
        UILabel *titleView = [[UILabel alloc] init];
        titleView.font = [UIFont systemFontOfSize:kOFCourseCellTitleFontSize];
        [listBtn addSubview:titleView];
        self.titleView = titleView;
        
        UILabel *descView = [[UILabel alloc] init];
        descView.textColor = [UIColor grayColor];
        descView.font = [UIFont systemFontOfSize:kOFCourseCellDescFontSize];
        descView.numberOfLines = 0;
        [listBtn addSubview:descView];
        self.descView = descView;
        
        UILabel *viewcountView = [[UILabel alloc] init];
        viewcountView.textColor = [UIColor lightGrayColor];
        viewcountView.font = [UIFont systemFontOfSize:kOFCourseCellOthersFontSize];
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

- (void)setCourseFrame:(OFCourseFrame *)courseFrame {
    _courseFrame = courseFrame;
    OFCourse *course = courseFrame.course;
    
    // 占据整个cell的button
    self.listBtn.frame = courseFrame.listBtnF;
    // 图片view
    [self.picView sd_setImageWithURL:[NSURL URLWithString:course.picUrl] placeholderImage:nil];
    self.picView.frame = courseFrame.picViewF;
    // rtypeView
    NSString *imgName;
    NSString *bgImgName;
    switch (course.rtype) {
        case OFCourseRtypeVideo:
            imgName = @"home_video";
            bgImgName = @"home_video_b";
            [self.rtypeView setTitle:course.quantity forState:UIControlStateNormal];
            break;
        case OFCourseRtypeH5:
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
    self.courseTypeView.backgroundColor = [UIColor colorWithHexString:course.tagBgColor];
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
