//
//  OCESearchResultCourse.m
//  OpenCourse
//
//  Created by Oneself on 16/7/4.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCESearchResultCourse.h"

@implementation OCESearchResultCourse

- (NSMutableAttributedString *)workedTitle {
    return [self attributedStringWithText:self.title];
}

- (NSMutableAttributedString *)workedTags {
    return [self attributedStringWithText:_tags];
}

- (NSMutableAttributedString *)attributedStringWithText:(NSString *)text {
    NSString *rubbishChar = @"#";
    NSMutableString *newTitle = [[text stringByReplacingOccurrencesOfString:@"##" withString:rubbishChar] mutableCopy];
    NSMutableAttributedString *attributedNewTitle = [[NSMutableAttributedString alloc] initWithString:newTitle];
    
    NSString *aChar = nil;
    int selectCharIndex = 0;
    int previousSelectCharIndex = 0;
    int behindSelectCharIndex = 0;
    for (int index = 0; index < newTitle.length; index++) {
        aChar = [newTitle substringWithRange:NSMakeRange(index, 1)];
        
        if ([aChar isEqualToString:rubbishChar]) {
            ++selectCharIndex;
            if (selectCharIndex % 2) {
                previousSelectCharIndex = index;
            } else {
                behindSelectCharIndex = index;
                
                [attributedNewTitle addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(previousSelectCharIndex, behindSelectCharIndex - previousSelectCharIndex + 1)];
            }
        }
    }
    
    while ([newTitle rangeOfString:rubbishChar].location != NSNotFound) {
        for(int i = 0; i < newTitle.length; i++) {
            aChar = [newTitle substringWithRange:NSMakeRange(i, 1)];
            
            if ([aChar isEqualToString:rubbishChar]) {
                [attributedNewTitle deleteCharactersInRange:NSMakeRange(i, 1)];
                [newTitle deleteCharactersInRange:NSMakeRange(i, 1)];
                
                break;
            }
        }
    }
    
    return attributedNewTitle;
}

@end
