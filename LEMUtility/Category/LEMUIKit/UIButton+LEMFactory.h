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

#pragma mark - factory method

/**
 * 文本按钮
 */
+ (UIButton *)textButtonWithFrame:(CGRect)frame text:(NSString *)text textFont:(UIFont *)font textColor:(UIColor *)textColor click:(LEMButtonClickBlock)clickBlock;

/**
 * 图片按钮
 */
+ (UIButton *)imageButtonWithFrame:(CGRect)frame image:(UIImage *)image click:(LEMButtonClickBlock)clickBlock;

/**
 * 文字+图片按钮
 */
+ (UIButton *)buttonWithFrame:(CGRect)frame image:(UIImage *)image text:(NSString *)text textFont:(UIFont *)font textColor:(UIColor *)textColor click:(LEMButtonClickBlock)clickBlock;

/**
 * 使用block形式的target
 */
- (void)addClickBlock:(LEMButtonClickBlock)clickBlock; // UIControlEventTouchUpInside
- (void)addTargetBlock:(LEMButtonClickBlock)targetBlock forControlEvent:(UIControlEvents)controlEvent;

/**
 * 设置按钮和图片的位置
 */
- (void)setButtonImagePosition:(LEMButtonImagePosition)buttonImagePosition;

@end
