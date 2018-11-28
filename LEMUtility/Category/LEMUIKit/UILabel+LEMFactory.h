//
//  UILabel+LEMFactory.h
//  LEMUtility
//
//  Created by Himin on 2018/11/28.
//  Copyright © 2018 Himin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LEMFactory)

+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font textAlinement:(NSTextAlignment)textAlignment;

@end
