//
//  HMLoading.h
//  TestAll
//
//  Created by 黄启明 on 2018/11/6.
//  Copyright © 2018 Himin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HMLoadingStyle) {
    HMLoadingStyleSystem = 0,
    HMLoadingStyleSandClock = 1,
    HMLoadingStyleOrbitView = 2
};

@interface HMLoading : NSObject

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
+ (void)showLoading:(HMLoadingStyle)loadingStyle;
// 加载隐藏
+ (void)hideLoading;

@end
