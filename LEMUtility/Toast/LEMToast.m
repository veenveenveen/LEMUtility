//
//  LEMToast.m
//  LEMUtility
//
//  Created by Himin on 2018/11/27.
//  Copyright © 2018 Himin. All rights reserved.
//

#import "LEMToast.h"

#import "SandClockView.h"
#import "XYZOrbitView.h"

#import "UIColor+HexColor.h"
#import "NSString+LEMSize.h"

#define pUIScreenWidth [UIScreen mainScreen].bounds.size.width
#define pUIScreenHeight [UIScreen mainScreen].bounds.size.height
#define pAPPKeyWindow [UIApplication sharedApplication].keyWindow

// 默认背景色
#define pBackgroundColor [UIColor colorWithHexString:@"F6F6F6"];
// 默认文字颜色
#define pTextColor [UIColor colorWithHexString:@"434343"];
// 默认字体
#define pFont [UIFont systemFontOfSize:15];
// 提示label视图最小宽度(默认宽度)
static CGFloat minTextWidth = 80;
static CGFloat minTextImageWidth = 100;

static NSInteger waitingTime = 0;

@implementation LEMToast

// 只显示文字 (时间默认)
+ (void)showToastWithText:(NSString *)text {
    [self showToastWithText:text time:1.5];
}

// 只显示文字
+ (void)showToastWithText:(NSString *)text time:(NSTimeInterval)timeInterval {
    [self showToastWithConfig:nil text:text time:timeInterval];
}

/* ---------------- */

// 只显示图片 (时间默认)
+ (void)showToastWithImage:(UIImage *)image {
    [self showToastWithImage:image time:1.5];
}

// 只显示图片
+ (void)showToastWithImage:(UIImage *)image time:(NSTimeInterval)timeInterval {
    [self showToastWithText:nil image:image time:timeInterval];
}

// 显示图片和文字提示
+ (void)showToastWithText:(NSString *)text image:(UIImage *)image time:(NSTimeInterval)timeInterval {
    [self showToastWithConfig:nil text:text image:image time:timeInterval];
}

#pragma mark -

/* -------- 文字 -------- */

// 自定义配置的文字提示
+ (void)showToastWithConfig:(LEMToastConfig *)toastConfig text:(NSString *)text time:(NSTimeInterval)timeInterval {
    UIColor *backgroundColor = pBackgroundColor;
    UIColor *textColor = pTextColor;
    UIFont  *textFont = pFont;
    CGFloat toastWidth = minTextWidth;
    if (toastConfig) {
        if (toastConfig.backgroundColor) { backgroundColor = toastConfig.backgroundColor; }
        if (toastConfig.textColor) { textColor = toastConfig.textColor; }
        if (toastConfig.textFont) { textFont = toastConfig.textFont; }
        if (toastConfig.toastWidth) { toastWidth = toastConfig.toastWidth > minTextWidth ? toastConfig.toastWidth : minTextWidth; }
    }
    [self showToastWithText:text textFont:textFont textColor:textColor time:timeInterval backgroundColor:backgroundColor toastWidth:toastWidth];
}

+ (void)showToastWithText:(NSString *)text textFont:(UIFont *)textFont textColor:(UIColor *)textColor time:(NSTimeInterval)timeInterval backgroundColor:(UIColor *)backgroundColor toastWidth:(CGFloat)toastWidth {
    UIView *bgView = [[UIView alloc] initWithFrame:pAPPKeyWindow.bounds];
    bgView.backgroundColor = UIColor.clearColor;
    bgView.alpha = 0;
    [pAPPKeyWindow addSubview:bgView];
    
    CGFloat width = toastWidth;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(pUIScreenWidth/2-40, pUIScreenHeight/2-width/2, 80, width)];
    view.backgroundColor = backgroundColor;
    view.layer.cornerRadius = 6;
    [bgView addSubview:view];
    
    CGFloat gap = 10;
    UIFont *font = textFont;
    
    CGSize labSize = [text sizeWithFont:font maxWidth:toastWidth];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(gap, gap, labSize.width, labSize.height)];
    lab.text = text;
    lab.font = font;
    lab.textColor = textColor;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.numberOfLines = 0;
    [view addSubview:lab];
    
    if (lab.frame.size.width > width) {
        width = lab.frame.size.width;
    }
    
    CGFloat viewWidth = width + gap * 2;
    CGFloat viewHeight = lab.frame.size.height + gap * 2;
    
    lab.frame = CGRectMake((viewWidth-labSize.width)/2, gap, labSize.width, labSize.height);
    
    view.frame = CGRectMake((pUIScreenWidth-viewWidth)/2, (pUIScreenHeight-viewHeight)/2, viewWidth, viewHeight);
    view.center = CGPointMake(bgView.center.x, bgView.center.y-50);
    
    view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    [UIView animateWithDuration:0.3 animations:^{
        bgView.alpha = 1;
        view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.3 animations:^{
                bgView.alpha = 0;
                view.transform = CGAffineTransformMakeScale(0.1, 0.1);
            } completion:^(BOOL finished) {
                [bgView removeFromSuperview];
            }];
        });
    }];
}

/* -------- 图片和文字 -------- */

// 自定义配置的提示
+ (void)showToastWithConfig:(LEMToastConfig *)toastConfig text:(NSString *)text image:(UIImage *)image time:(NSTimeInterval)timeInterval {
    UIColor *backgroundColor = pBackgroundColor;
    UIColor *textColor = pTextColor;
    UIFont  *textFont = pFont;
    CGFloat toastWidth = minTextImageWidth;
    CGFloat imageHeight = image.size.height;
    UIViewContentMode contentMode = UIViewContentModeScaleAspectFit;
    if (toastConfig) {
        if (toastConfig.backgroundColor) { backgroundColor = toastConfig.backgroundColor; }
        if (toastConfig.textColor) { textColor = toastConfig.textColor; }
        if (toastConfig.textFont) { textFont = toastConfig.textFont; }
        if (toastConfig.toastWidth) { toastWidth = toastConfig.toastWidth > minTextImageWidth ? toastConfig.toastWidth : minTextImageWidth; }
        if (toastConfig.imageHeight) { imageHeight = toastConfig.imageHeight; }
        if (toastConfig.contentMode) { contentMode = toastConfig.contentMode; }
    }
    [self showToastWithText:text textFont:textFont textColor:textColor image:image imageHeight:(CGFloat)imageHeight imageContentMode:contentMode time:timeInterval backgroundColor:backgroundColor toastWidth:toastWidth];
}

+ (void)showToastWithText:(NSString *)text textFont:(UIFont *)textFont textColor:(UIColor *)textColor image:(UIImage *)image  imageHeight:(CGFloat)imageHeight imageContentMode:(UIViewContentMode)contentMode time:(NSTimeInterval)timeInterval backgroundColor:(UIColor *)backgroundColor toastWidth:(CGFloat)toastWidth {
    UIView *bgView = [[UIView alloc] initWithFrame:pAPPKeyWindow.bounds];
    bgView.backgroundColor = UIColor.clearColor;
    bgView.alpha = 0;
    [pAPPKeyWindow addSubview:bgView];
    
    CGFloat topGap = 15;
    CGFloat imgHeight = imageHeight;
    
    CGFloat width = toastWidth;
    CGFloat height = text ? imgHeight+topGap*2+25 : imgHeight+topGap*2;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake((pUIScreenWidth-width)/2, (pUIScreenHeight-height)/2, width, height)];
    view.backgroundColor = backgroundColor;
    view.layer.cornerRadius = 10;
    [bgView addSubview:view];
    
    UIImageView *imgV = [[UIImageView alloc] initWithImage:image];
    
    CGFloat viewWidth = width;
    CGFloat viewHeight = height;
    
    if (text == nil || [text isEqualToString:@""]) {
        topGap = (height - imgHeight) * 0.5;
    } else {
        topGap = 15;
        
        CGFloat gap = 10;
        UIFont *font = textFont;
        
        CGSize labSize = [text sizeWithFont:font maxWidth:toastWidth];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(gap, topGap+imgHeight+gap, labSize.width, labSize.height)];
        lab.text = text;
        lab.font = font;
        lab.textColor = textColor;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.numberOfLines = 0;
        [view addSubview:lab];
        
        if (lab.frame.size.width > width) {
            width = lab.frame.size.width;
        }
        
        viewWidth = width + gap * 2;
        viewHeight = height - 20 + lab.frame.size.height;
        
        lab.frame = CGRectMake((viewWidth-labSize.width)/2, topGap+imgHeight+gap, labSize.width, labSize.height);
        
        [view addSubview:lab];
    }
    
    imgV.frame = CGRectMake(0, topGap, viewWidth, imgHeight);
    imgV.contentMode = contentMode;
    
    [view addSubview:imgV];
    
    view.frame = CGRectMake((pUIScreenWidth-viewWidth)/2, (pUIScreenHeight-viewHeight)/2, viewWidth, viewHeight);
    view.center = CGPointMake(bgView.center.x, bgView.center.y-50);
    
    view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    [UIView animateWithDuration:0.3 animations:^{
        bgView.alpha = 1;
        view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.3 animations:^{
                bgView.alpha = 0;
                view.transform = CGAffineTransformMakeScale(0.1, 0.1);
            } completion:^(BOOL finished) {
                [bgView removeFromSuperview];
            }];
        });
    }];
}


#pragma mark - Loading

+ (void)showLoading:(LEMLoadingStyle)loadingStyle {
    waitingTime += 1;
    if (waitingTime == 1) {
        UIView *bgView = [[UIView alloc] initWithFrame:pAPPKeyWindow.bounds];
        bgView.backgroundColor = UIColor.clearColor;
        bgView.tag = 110;
        [pAPPKeyWindow addSubview:bgView];
        
        [self loadingViewOn:bgView withLoadingStyle:loadingStyle];
    }
}

+ (void)loadingViewOn:(UIView *)view withLoadingStyle:(LEMLoadingStyle)loadingStyle {
    CGFloat rectWidth = view.frame.size.width;
    CGFloat rectHeight = view.frame.size.height;
    if (loadingStyle == LEMLoadingStyleSystem) {
        
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(rectWidth/2 - 30, rectHeight/2 - 30, 60, 60)];
        v.layer.cornerRadius = 10;
        v.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1.0];
        
        UIActivityIndicatorView *wait = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        wait.color = [UIColor colorWithWhite:0.4 alpha:1];
        wait.center = CGPointMake(v.frame.size.width * 0.5+1, v.frame.size.height * 0.5+1.5);
        [v addSubview:wait];
        
        [wait startAnimating];
        [view addSubview:v];
        
    } else if (loadingStyle == LEMLoadingStyleSandClock) {
        
        SandClockView *sandView = [[SandClockView alloc] initWithFrame:CGRectMake(rectWidth*0.5-30, rectHeight*0.5-30, 60, 60)];
        sandView.tag = 112;
        [view addSubview:sandView];
        [sandView startAnimation];
        
    } else if (loadingStyle == LEMLoadingStyleOrbitView) {
        
        XYZOrbitView *orbitView = [[XYZOrbitView alloc] initWithFrame:CGRectMake(rectWidth*0.5-30, rectHeight*0.5-30, 60, 60)];
        orbitView.tag = 113;
        [view addSubview:orbitView];
        [orbitView launchOrbit];
    }
}

// 隐藏加载
+ (void)hideLoading {
    if (waitingTime > 0) {
        waitingTime -= 1;
    }
    if (waitingTime == 0) {
        if (pAPPKeyWindow.subviews.count > 0) {
            for (UIView *view in pAPPKeyWindow.subviews) {
                //                if (view.tag == 112) {
                //                    if ([view isKindOfClass:[SandClockView class]]) {
                //                        [(SandClockView *)view stopAnimation];
                //                        [view removeFromSuperview];
                //                    }
                //                }
                if (view.tag == 110) {
                    [UIView animateWithDuration:0.25 animations:^{
                        view.alpha = 0;
                    } completion:^(BOOL finished) {
                        [view removeFromSuperview];
                    }];
                }
            }
        }
    }
}

@end

@implementation LEMToastConfig
@end
