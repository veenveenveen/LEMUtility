//
//  UILabel+LEMFactory.m
//  LEMUtility
//
//  Created by Himin on 2018/11/28.
//  Copyright © 2018 Himin. All rights reserved.
//

#import "UILabel+LEMFactory.h"

@implementation UILabel (LEMFactory)

+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font textAlinement:(NSTextAlignment)textAlignment {
    UILabel *lab = [[UILabel alloc] initWithFrame:frame];
    if (text) lab.text = text;
    if (textColor) lab.textColor = textColor;
    if (font) lab.font = font;
    if (textAlignment) lab.textAlignment = textAlignment;
    return lab;
}

@end
