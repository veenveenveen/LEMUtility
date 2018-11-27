//
//  NSString+LEMSize.m
//  LEMUtility
//
//  Created by Himin on 2018/11/27.
//  Copyright © 2018 Himin. All rights reserved.
//

#import "NSString+LEMSize.h"

@implementation NSString (LEMSize)

// 根据字符串计算label的size
- (CGSize)sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth {
    CGRect rect = [self boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{ NSFontAttributeName: font } context:nil];
    return rect.size;
}

@end
