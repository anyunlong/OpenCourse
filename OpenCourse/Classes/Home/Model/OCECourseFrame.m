//
//  OCECourseFrame.m
//  OpenCourse
//
//  Created by Oneself on 16/6/1.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCECourseFrame.h"
// m
#import "OCECourse.h"

extern const CGFloat kUIViewAYLExtensionViewMargin;
extern const CGFloat kOCECourseCellTitleFontSize;
extern const CGFloat kOCECourseCellDescFontSize;
extern const CGFloat kOCECourseCellOthersFontSize;

@implementation OCECourseFrame

- (void)setCourse:(OCECourse *)course {
    _course = course;
    
    CGFloat screenWidth = AYLMainScreenBounds.size.width;
    CGSize videoBImageSize = [UIImage imageNamed:@"home_video_b"].size;
    CGSize h5BImageSize = [UIImage imageNamed:@"home_article_b"].size;
    CGSize shareImageSize = [UIImage imageNamed:@"home_shared"].size;
    CGSize likeImageSize = [UIImage imageNamed:@"home_liked"].size;
    // 字体参数
    NSDictionary *courseCellTitleFontAttr = @{NSFontAttributeName : [UIFont systemFontOfSize:kOCECourseCellTitleFontSize]};
    NSDictionary *courseCellDescFontAttr = @{NSFontAttributeName : [UIFont systemFontOfSize:kOCECourseCellDescFontSize]};
    NSDictionary *courseCellOthersFontAttr = @{NSFontAttributeName : [UIFont systemFontOfSize:kOCECourseCellOthersFontSize]}; // 课程类型、创建时间、观看数、vedioView的view的字体参数
    
    // picView
    CGFloat picViewW = screenWidth;
    CGFloat picViewH = picViewW / 2;
    _picViewF = CGRectMake(0, 0, picViewW, picViewH);
    
    // courseTypeView
    CGFloat courseTypeViewX = kUIViewAYLExtensionViewMargin * 2;
    CGFloat courseTypeViewY = CGRectGetMaxY(_picViewF) + courseTypeViewX;
    CGSize courseTypeViewTextSize = [course.courseType sizeWithAttributes:courseCellOthersFontAttr];
    CGFloat courseTypeViewW = courseTypeViewTextSize.width + 2 * kUIViewAYLExtensionViewMargin;
    CGFloat courseTypeViewH = courseTypeViewTextSize.height + kUIViewAYLExtensionViewMargin;
    _courseTypeViewF = CGRectMake(courseTypeViewX, courseTypeViewY, courseTypeViewW, courseTypeViewH);
    
    // rtypeView
    CGFloat rtypeViewW;
    CGFloat rtypeViewH;
    switch (course.rtype) {
        case OCECourseRtypeVideo:
            rtypeViewW = videoBImageSize.width;
            rtypeViewH = videoBImageSize.height;
            break;
        case OCECourseRtypeH5:
            rtypeViewW = h5BImageSize.width;
            rtypeViewH = h5BImageSize.height;
            break;
    }
    CGFloat rtypeViewX = picViewW - courseTypeViewX - rtypeViewW;
    CGFloat rtypeViewY = courseTypeViewX;
    _rtypeViewF = CGRectMake(rtypeViewX, rtypeViewY, rtypeViewW, rtypeViewH);
    
    // createTimeViewF
    CGFloat createTimeViewX = CGRectGetMaxX(_courseTypeViewF) + courseTypeViewX;
    CGSize createTimeViewSize = [course.dbCreateTime sizeWithAttributes:courseCellOthersFontAttr];
    CGFloat createTimeViewHeight = createTimeViewSize.height;
    CGFloat createTimeViewY = (courseTypeViewH - createTimeViewHeight) / 2 + courseTypeViewY;
    _createTimeViewF = CGRectMake(createTimeViewX, createTimeViewY, createTimeViewSize.width, createTimeViewHeight);
    
    // titleViewF
    CGFloat titleViewX = courseTypeViewX;
    CGFloat titleViewY = CGRectGetMaxY(_courseTypeViewF) + courseTypeViewX;
    CGFloat titleViewW = picViewW - 2 * titleViewX;
    CGSize titleViewSize = [course.title sizeWithAttributes:courseCellTitleFontAttr];
    _titleViewF = CGRectMake(titleViewX, titleViewY, titleViewW, titleViewSize.height);
    
    // descViewF
    CGFloat descViewX = courseTypeViewX;
    CGFloat descViewY = CGRectGetMaxY(_titleViewF) + courseTypeViewX;
    CGFloat descViewW = screenWidth - 2 * courseTypeViewX;
    CGRect descViewRect = [course.desc boundingRectWithSize:CGSizeMake(descViewW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:courseCellDescFontAttr context:nil];
    _descViewF = CGRectMake(descViewX, descViewY, descViewW, descViewRect.size.height);
    
    // viewcountViewF
    CGFloat viewcountViewX = courseTypeViewX;
    CGFloat viewcountViewY = CGRectGetMaxY(_descViewF) + courseTypeViewX;
    _viewconutViewF = CGRectMake(viewcountViewX, viewcountViewY, descViewW / 2, likeImageSize.height);
    
    // likeViewF
    CGFloat likeImageWidth = likeImageSize.width;
    CGFloat likeImageHeight = likeImageSize.height;
    CGFloat likeViewW = likeImageWidth;
    CGFloat likeViewH = likeImageHeight;
    CGFloat likeViewX = screenWidth - courseTypeViewX - likeViewW;
    CGFloat likeViewY = viewcountViewY;
    _likeViewF = CGRectMake(likeViewX, likeViewY, likeViewW, likeViewH);
    
    // dividerF
    CGFloat dividerW = 0.5;
    CGFloat dividerH = likeViewH / 2;
    CGFloat dividerX = likeViewX - courseTypeViewX - dividerW;
    CGFloat dividerY = (likeViewH - dividerH) / 2 + likeViewY;
    _dividerF = CGRectMake(dividerX, dividerY, dividerW, dividerH);
    
    // shareViewF
    CGFloat shareViewWidth = shareImageSize.width;
    CGFloat shareViewX = dividerX - courseTypeViewX - shareViewWidth;
    CGFloat shareViewY = likeViewY;
    _shareViewF = CGRectMake(shareViewX, shareViewY, shareViewWidth, shareImageSize.height);
    
    // listBtnF
    CGFloat maxYAtlikeViewAndShareView = MAX(CGRectGetMaxY(_likeViewF), CGRectGetMaxY(_shareViewF));
    CGFloat maxY = MAX(CGRectGetMaxY(_viewconutViewF), maxYAtlikeViewAndShareView);
    _listBtnF = CGRectMake(0, 0, screenWidth, maxY + courseTypeViewX);
    
    // cellHeight
    _cellHeight = CGRectGetMaxY(_listBtnF) + courseTypeViewX;
}

- (NSDictionary *)attrWithFontSize:(CGFloat)fontSize {
    return @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]};
}

@end
