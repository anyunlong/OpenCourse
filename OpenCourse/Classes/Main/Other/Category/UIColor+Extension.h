//
//  UIColor+Extension.h
//
//  Created by Oneself on 16/5/29.
//  Copyright © 2016年 CCUT. All rights reserved.
//

@interface UIColor (Extension)

// RGB颜色
+ (UIColor *)colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b;
// app颜色
+ (UIColor *)appColor;
// 系统tableView背景颜色
+ (UIColor *)systemTableViewBackgroundColor;
// 十六进制的颜色转换为UIColor (not mine)
+ (UIColor *)colorWithHexString:(NSString *)hexString;

@end
