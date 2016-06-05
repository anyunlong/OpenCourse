//
//  OFCourse.h
//  OpenCourse
//
//  Created by Oneself on 16/6/1.
//  Copyright © 2016年 CCUT. All rights reserved.
//

// 原文件类型枚举
typedef NS_ENUM(char, OFCourseRtype) {
    OFCourseRtypeVideo = 2,
    OFCourseRtypeH5,
};

@interface OFCourse : NSObject

@property (nonatomic, assign) short int id;
@property (nonatomic, copy) NSString *rid;
@property (nonatomic, copy) NSString *plid;
@property (nonatomic, assign) char weight;
// 原文件类型
@property (nonatomic, assign) OFCourseRtype rtype;
// 标题
@property (nonatomic, copy) NSString *title;
// 简介
@property (nonatomic, copy) NSString *desc;
// 图片url
@property (nonatomic, copy) NSString *picUrl;
// 类型
@property (nonatomic, copy) NSString *courseType;
// 页面地址
@property (nonatomic, copy) NSString *pageUrl;
// 视频时间
@property (nonatomic, copy) NSString *quantity;
// 观看人数
@property (nonatomic, copy) NSString *viewcount;
// 创建时间
@property (nonatomic, copy) NSString *dbCreateTime;
// 当前用户是否收藏
@property (nonatomic, assign, getter=isStore) BOOL userStore;
// 标签颜色
@property (nonatomic, copy) NSString *tagBgColor;

@end
