//
//  OCESearchResultCourse.m
//  OpenCourse
//
//  Created by Oneself on 16/7/4.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#warning !!!

#import "OCESearchResultCourse.h"

@implementation OCESearchResultCourse

- (NSMutableAttributedString *)workedTitle {
    self.title = [_title stringByReplacingOccurrencesOfString:@"##" withString:@"#"];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_title];
    
    NSString *newStr = _title;
    NSString *temp = nil;
    int j = 0;
    int k = 0;
    int m = 0;
    for(int i =0; i < [newStr length]; i++)
    {
        temp = [newStr substringWithRange:NSMakeRange(i, 1)];
        if ([temp isEqualToString:@"#"]) {
            ++j;
            if (j % 2 == 0) {
                m = i;
                
                [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(k,m - k + 1)];
            } else {
                k = i;
            }
        }
    }
    
    NSMutableString *mstr = [NSMutableString stringWithString:newStr];
    
    while ([mstr rangeOfString:@"#"].location != NSNotFound) {
        for(int i =0;i < [mstr length]; i++)
        {
            temp = [mstr substringWithRange:NSMakeRange(i, 1)];
            if ([temp isEqualToString:@"#"]) {
                [str deleteCharactersInRange:NSMakeRange(i, 1)];
                [mstr deleteCharactersInRange:NSMakeRange(i, 1)];
                break;
            }
        }
    }
    
    return str;
}

- (NSMutableAttributedString *)workedTags {
    self.tags = [_tags stringByReplacingOccurrencesOfString:@"##" withString:@"#"];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_tags];
    
    NSString *newStr = _tags;
    NSString *temp = nil;
    int j = 0;
    int k = 0;
    int m = 0;
    for(int i =0; i < [newStr length]; i++)
    {
        temp = [newStr substringWithRange:NSMakeRange(i, 1)];
        if ([temp isEqualToString:@"#"]) {
            ++j;
            if (j % 2 == 0) {
                m = i;
                
                [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(k,m - k + 1)];
            } else {
                k = i;
            }
        }
    }
    
    NSMutableString *mstr = [NSMutableString stringWithString:newStr];
    
    while ([mstr rangeOfString:@"#"].location != NSNotFound) {
        for(int i =0;i < [mstr length]; i++)
        {
            temp = [mstr substringWithRange:NSMakeRange(i, 1)];
            if ([temp isEqualToString:@"#"]) {
                [str deleteCharactersInRange:NSMakeRange(i, 1)];
                [mstr deleteCharactersInRange:NSMakeRange(i, 1)];
                break;
            }
        }
    }
    
    return str;
}

@end
