//
//  UIColor+AYLExtension.h
//
//  Created by Oneself on 16/5/29.
//  Copyright © 2016年 CCUT. All rights reserved.
//

@interface UIColor (AYLExtension)

/**
 *  @return RGB color with r & g & b.
 */
+ (UIColor *)ayl_colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b;
/**
 *  @return main color of this app.
 */
+ (UIColor *)ayl_appColor;
/**
 *  @return color of system-tableView.
 */
+ (UIColor *)ayl_systemTableViewBackgroundColor;
/**
 *  @return hexadecimal color with hexString.
 */
+ (UIColor *)ayl_colorWithHexString:(NSString *)hexString;
/**
 *  @return a random color.
 */
+ (UIColor *)ayl_randomColor;

@end
