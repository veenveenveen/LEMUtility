//
//  UIButton+LEMFactory.h
//  LEMUtility
//
//  Created by Himin on 2018/11/28.
//  Copyright © 2018 Himin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LEMButtonClickBlock)(id sender);

typedef NS_ENUM(NSUInteger, LEMButtonImagePosition) {
    LEMButtonImagePositionLeft,
    LEMButtonImagePositionTop,
    LEMButtonImagePositionRight,
    LEMButtonImagePositionBottom
};

@interface UIButton (LEMFactory)

// factory method
+ (UIButton *)textButtonWith:(CGRect)frame text:(NSString *)text textFont:(UIFont *)font textColor:(UIColor *)textColor click:(LEMButtonClickBlock)clickBlock;
+ (UIButton *)imageButtonWith:(CGRect)frame image:(UIImage *)image click:(LEMButtonClickBlock)clickBlock;
+ (UIButton *)buttonWith:(CGRect)frame image:(UIImage *)image text:(NSString *)text textFont:(UIFont *)font textColor:(UIColor *)textColor click:(LEMButtonClickBlock)clickBlock;

// image/text position
- (void)setButtonImagePosition:(LEMButtonImagePosition)buttonImagePosition;

@end
