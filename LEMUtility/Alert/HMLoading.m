//
//  HMLoading.m
//  TestAll
//
//  Created by 黄启明 on 2018/11/6.
//  Copyright © 2018 Himin. All rights reserved.
//

#import "HMLoading.h"
#import "SandClockView.h"
#import "XYZOrbitView.h"

#import "UIColor+HexColor.h"
#import "NSString+LEM.h"

#define kUIScreenWidth [UIScreen mainScreen].bounds.size.width
#define kUIScreenHeight [UIScreen mainScreen].bounds.size.height
#define kAPPKeyWindow [UIApplication sharedApplication].keyWindow

static CGFloat maxWidth = 180;// 提示label视图的最大宽度

static NSInteger waitingTime = 0;

@implementation HMLoading

// 只显示文字 (时间默认)
+ (void)showToastWithText:(NSString *)text {
    [self showToastWithText:text time:1.5];
}

// 只显示图片 (时间默认)
+ (void)showToastWithImage:(UIImage *)image {
    [self showToastWithImage:image time:1.5];
}

// 只显示图片
+ (void)showToastWithImage:(UIImage *)image time:(NSTimeInterval)timeInterval {
    [self showToastWithText:nil image:image time:timeInterval];
}

#pragma mark -

// 只显示文字
+ (void)showToastWithText:(NSString *)text time:(NSTimeInterval)timeInterval {
    UIView *bgView = [[UIView alloc] initWithFrame:kAPPKeyWindow.bounds];
    bgView.backgroundColor = UIColor.clearColor;
    bgView.alpha = 0;
    [kAPPKeyWindow addSubview:bgView];
    
    CGFloat width = 50;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(kUIScreenWidth/2-40, kUIScreenHeight/2-width/2, 80, width)];
    view.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
    view.layer.cornerRadius = 6;
    [bgView addSubview:view];
    
    CGFloat gap = 10;
    UIFont *font = [UIFont systemFontOfSize:15];
    
    CGSize labSize = [text sizeWithFont:font maxWidth:maxWidth];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(gap, gap, labSize.width, labSize.height)];
    lab.text = text;
    lab.font = font;
    lab.textColor = [UIColor colorWithHexString:@"434343"];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.numberOfLines = 0;
    [view addSubview:lab];
    
    if (lab.frame.size.width > width) {
        width = lab.frame.size.width;
    }
    
    CGFloat viewWidth = width + gap * 2;
    CGFloat viewHeight = lab.frame.size.height + gap * 2;
    
    view.frame = CGRectMake((kUIScreenWidth-viewWidth)/2, (kUIScreenHeight-viewHeight)/2, viewWidth, viewHeight);
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

// 显示图片和文字提示
+ (void)showToastWithText:(NSString *)text image:(UIImage *)image time:(NSTimeInterval)timeInterval {
    UIView *bgView = [[UIView alloc] initWithFrame:kAPPKeyWindow.bounds];
    bgView.backgroundColor = UIColor.clearColor;
    bgView.alpha = 0;
    [kAPPKeyWindow addSubview:bgView];
    
    CGFloat width = 120;
    CGFloat height = 100;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake((kUIScreenWidth-width)/2, (kUIScreenHeight-height)/2, width, height)];
    view.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
    view.layer.cornerRadius = 10;
    [bgView addSubview:view];
    
    CGFloat topGap = 15;
    CGFloat imgHeight = 40;
    
    UIImageView *imgV = [[UIImageView alloc] initWithImage:image];
    
    CGFloat viewWidth = width;
    CGFloat viewHeight = height;
    
    if (text == nil || [text isEqualToString:@""]) {
        topGap = (height - imgHeight) * 0.5;
    } else {
        topGap = 15;
        
        CGFloat gap = 10;
        UIFont *font = [UIFont systemFontOfSize:15];
        
        CGSize labSize = [text sizeWithFont:font maxWidth:maxWidth];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(gap, topGap+imgHeight+gap, labSize.width, labSize.height)];
        lab.text = text;
        lab.font = font;
        lab.textColor = [UIColor colorWithHexString:@"434343"];
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
    imgV.contentMode = UIViewContentModeScaleAspectFit;
    
    [view addSubview:imgV];
    
    view.frame = CGRectMake((kUIScreenWidth-viewWidth)/2, (kUIScreenHeight-viewHeight)/2, viewWidth, viewHeight);
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

+ (void)showLoading:(HMLoadingStyle)loadingStyle {
    waitingTime += 1;
    if (waitingTime == 1) {
        UIView *bgView = [[UIView alloc] initWithFrame:kAPPKeyWindow.bounds];
        bgView.backgroundColor = UIColor.clearColor;
        bgView.tag = 110;
        [kAPPKeyWindow addSubview:bgView];
        
        [self loadingViewOn:bgView withLoadingStyle:loadingStyle];
    }
}

+ (void)loadingViewOn:(UIView *)view withLoadingStyle:(HMLoadingStyle)loadingStyle {
    CGFloat rectWidth = view.frame.size.width;
    CGFloat rectHeight = view.frame.size.height;
    if (loadingStyle == HMLoadingStyleSystem) {
        
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(rectWidth/2 - 30, rectHeight/2 - 30, 60, 60)];
        v.layer.cornerRadius = 10;
        v.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1.0];
        
        UIActivityIndicatorView *wait = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        wait.color = [UIColor colorWithWhite:0.4 alpha:1];
        wait.center = CGPointMake(v.frame.size.width * 0.5+1, v.frame.size.height * 0.5+1.5);
        [v addSubview:wait];
        
        [wait startAnimating];
        [view addSubview:v];

    } else if (loadingStyle == HMLoadingStyleSandClock) {
        
        SandClockView *sandView = [[SandClockView alloc] initWithFrame:CGRectMake(rectWidth*0.5-30, rectHeight*0.5-30, 60, 60)];
        sandView.tag = 112;
        [view addSubview:sandView];
        [sandView startAnimation];
        
    } else if (loadingStyle == HMLoadingStyleOrbitView) {
        
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
        if (kAPPKeyWindow.subviews.count > 0) {
            for (UIView *view in kAPPKeyWindow.subviews) {
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
