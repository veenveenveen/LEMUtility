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

@interface LEMToast : NSObject

// 提示

// 只显示文字 (时间默认)
+ (void)showToastWithText:(NSString *)text;
// 只显示文字
+ (void)showToastWithText:(NSString *)text time:(NSTimeInterval)timeInterval;
// 只显示图片 (时间默认)
+ (void)showToastWithImage:(UIImage *)image;
// 只显示图片
+ (void)showToastWithImage:(UIImage *)image time:(NSTimeInterval)timeInterval;
// 显示图片和文字提示
+ (void)showToastWithText:(NSString *)text image:(UIImage *)image time:(NSTimeInterval)timeInterval;

// 加载

// 加载显示
+ (void)showLoading:(LEMLoadingStyle)loadingStyle;
// 加载隐藏
+ (void)hideLoading;

@end
