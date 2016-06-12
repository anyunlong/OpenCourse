//
//  UIColor+AYLExtension.h
//
//  Created by Oneself on 16/5/29.
//  Copyright © 2016年 CCUT. All rights reserved.
//

@interface UIColor (AYLExtension)

// RGB颜色
+ (UIColor *)ayl_colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b;
// app颜色
+ (UIColor *)ayl_appColor;
// 系统tableView背景颜色
+ (UIColor *)ayl_systemTableViewBackgroundColor;
// 十六进制的颜色转换为UIColor (not mine)
+ (UIColor *)ayl_colorWithHexString:(NSString *)hexString;

@end
