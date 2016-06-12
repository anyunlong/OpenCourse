//
//  OCECourseFrame.h
//  OpenCourse
//
//  Created by Oneself on 16/6/1.
//  Copyright © 2016年 CCUT. All rights reserved.
//

@class OCECourse;

@interface OCECourseFrame : NSObject

/**
 *  course model
 */
@property (nonatomic, strong) OCECourse *course;

/**
 *  frames
 */
@property (nonatomic, assign, readonly) CGRect listBtnF;
@property (nonatomic, assign, readonly) CGRect picViewF;
@property (nonatomic, assign, readonly) CGRect rtypeViewF;
@property (nonatomic, assign, readonly) CGRect courseTypeViewF;
@property (nonatomic, assign, readonly) CGRect createTimeViewF;
@property (nonatomic, assign, readonly) CGRect titleViewF;
@property (nonatomic, assign, readonly) CGRect descViewF;
@property (nonatomic, assign, readonly) CGRect viewconutViewF;
@property (nonatomic, assign, readonly) CGRect shareViewF;
@property (nonatomic, assign, readonly) CGRect dividerF;
@property (nonatomic, assign, readonly) CGRect likeViewF;

// cellHeight
@property (nonatomic, assign, readonly) CGFloat cellHeight;

@end
