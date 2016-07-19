//
//  OCESearchResultCourse.h
//  OpenCourse
//
//  Created by Oneself on 16/7/4.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCECourse.h"

@interface OCESearchResultCourse : OCECourse

/* @property (nonatomic, copy) NSString *picUrl; */
/* @property (nonatomic, copy) NSString *title;  */
@property (nonatomic, strong) NSMutableAttributedString *workedTitle;
@property (nonatomic, copy) NSString *tags;
@property (nonatomic, strong) NSMutableAttributedString *workedTags;
@property (nonatomic, copy) NSString *playcount;
@property (nonatomic, copy) NSString *updatedPlaycount;

@end
