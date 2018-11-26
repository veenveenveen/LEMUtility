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

#define kUIScreenWidth [UIScreen mainScreen].bounds.size.width
#define kUIScreenHeight [UIScreen mainScreen].bounds.size.height
#define kAPPKeyWindow [UIApplication sharedApplication].keyWindow

static NSInteger waitingTime = 0;

@implementation HMLoading

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
