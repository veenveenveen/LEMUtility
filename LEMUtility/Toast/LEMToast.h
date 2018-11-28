//
//  LEMToast.h
//  LEMUtility
//
//  Created by Himin on 2018/11/27.
//  Copyright © 2018 Himin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LEMLoadingStyle) {
    LEMLoadingStyleSystem = 0,
    LEMLoadingStyleSandClock = 1,
    LEMLoadingStyleOrbitView = 2
};

@interface LEMToastConfig : NSObject

// 文字
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont  *textFont;
@property (nonatomic, assign) CGFloat toastWidth;

// 图片
@property (nonatomic, assign) CGFloat imageHeight;
@property (nonatomic, assign) UIViewContentMode contentMode;

@end

@interface LEMToast : NSObject

// 提示

/* ------ 文字 ------ */

// 只显示文字 (时间默认)
+ (void)showToastWithText:(NSString *)text;
// 只显示文字
+ (void)showToastWithText:(NSString *)text time:(NSTimeInterval)timeInterval;
// 自定义配置的文字提示
+ (void)showToastWithConfig:(LEMToastConfig *)toastConfig text:(NSString *)text time:(NSTimeInterval)timeInterval;

/* ------ 图片和文字 ------ */

// 只显示图片 (时间默认)
+ (void)showToastWithImage:(UIImage *)image;
// 只显示图片
+ (void)showToastWithImage:(UIImage *)image time:(NSTimeInterval)timeInterval;
// 显示图片和文字提示
+ (void)showToastWithText:(NSString *)text image:(UIImage *)image time:(NSTimeInterval)timeInterval;
// 自定义配置的图片和文字提示
+ (void)showToastWithConfig:(LEMToastConfig *)toastConfig text:(NSString *)text image:(UIImage *)image time:(NSTimeInterval)timeInterval;

/* ------ 加载 ------ */

// 加载显示
+ (void)showLoading:(LEMLoadingStyle)loadingStyle;
// 加载隐藏
+ (void)hideLoading;

@end
