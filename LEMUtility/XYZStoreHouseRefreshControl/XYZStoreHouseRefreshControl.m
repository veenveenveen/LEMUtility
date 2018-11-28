//
//  XYZStoreHouseRefreshControl.m
//  TestAll
//
//  Created by 黄启明 on 2018/11/7.
//  Copyright © 2018 Himin. All rights reserved.
//

#import "XYZStoreHouseRefreshControl.h"
#import "XYZBarItem.h"

// 获取状态栏、导航栏高度
#define pUIStatusBarHeight UIApplication.sharedApplication.statusBarFrame.size.height
#define pUINavBarHeight 44
#define pUINavBarAndStatusBarHeight (pUIStatusBarHeight+pUINavBarHeight)

static NSString *const kStartPointKey = @"startPoints";
static NSString *const kEndPointKey = @"endPoints";

static const CGFloat kDisappearDuration = 0.8;// 刷新完成后刷新控件消失时间
static const CGFloat kBarDarkAlpha = 0.4;
static const CGFloat kLoadingIndividualAnimationTiming = 0.8;
static const CGFloat kLoadingTimingOffset = 0.1;

typedef NS_ENUM(NSInteger, XYZRefreshControlState) {
    XYZRefreshControlStateIdle = 0,
    XYZRefreshControlStateRefreshing = 1,
    XYZRefreshControlStateDisappearing = 2
};

@interface XYZStoreHouseRefreshControl ()

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL action;
@property (nonatomic, assign) BOOL hasNav;//是否带导航栏
@property (nonatomic, assign) CGFloat horizontalRandomness;
@property (nonatomic, assign) CGFloat dropHeight;
@property (nonatomic, assign) BOOL reverseLoadingAnimation;
@property (nonatomic, assign) CGFloat internalAnimationFactor;

@property (nonatomic, strong) NSArray<XYZBarItem *> *barItems;
@property (nonatomic, strong) CADisplayLink *displayLink;

@property (nonatomic, assign) XYZRefreshControlState refreshState;

@property (nonatomic, assign) CGFloat disappearProgress;

@property (nonatomic, readonly, assign) CGFloat xyz_animationProgress;
@property (nonatomic, readonly, assign) CGFloat xyz_realContentOffsetY;

@end

@implementation XYZStoreHouseRefreshControl

+ (XYZStoreHouseRefreshControl*)attachToScrollView:(UIScrollView *)scrollView
                                            target:(id)target
                                     refreshAction:(SEL)refreshAction
                                             plist:(NSString *)plist
                                            hasNav:(BOOL)hasNav {
    return [XYZStoreHouseRefreshControl attachToScrollView:scrollView
                                                    target:target
                                             refreshAction:refreshAction
                                                     plist:plist
                                                    hasNav:hasNav
                                                     color:[UIColor blackColor]
                                                 lineWidth:1.0
                                                dropHeight:60
                                                     scale:1
                                      horizontalRandomness:150
                                   reverseLoadingAnimation:NO
                                   internalAnimationFactor:0.5];
}

+ (XYZStoreHouseRefreshControl*)attachToScrollView:(UIScrollView *)scrollView
                                            target:(id)target
                                     refreshAction:(SEL)refreshAction
                                             plist:(NSString *)plist
                                            hasNav:(BOOL)hasNav
                                             color:(UIColor*)color
                                         lineWidth:(CGFloat)lineWidth
                                        dropHeight:(CGFloat)dropHeight
                                             scale:(CGFloat)scale
                              horizontalRandomness:(CGFloat)horizontalRandomness
                           reverseLoadingAnimation:(BOOL)reverseLoadingAnimation
                           internalAnimationFactor:(CGFloat)internalAnimationFactor {
    XYZStoreHouseRefreshControl *refreshControl = [[XYZStoreHouseRefreshControl alloc] init];
    refreshControl.scrollView = scrollView;
    refreshControl.target = target;
    refreshControl.action = refreshAction;
    refreshControl.hasNav = hasNav;
    refreshControl.horizontalRandomness = horizontalRandomness;
    refreshControl.dropHeight = dropHeight;
    refreshControl.reverseLoadingAnimation = reverseLoadingAnimation;
    refreshControl.internalAnimationFactor = internalAnimationFactor;
    [scrollView addSubview:refreshControl];
    
    NSDictionary *rootDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:plist ofType:@"plist"]];
    NSArray *startPoints = [rootDict objectForKey:kStartPointKey];
    NSArray *endPoints = [rootDict objectForKey:kEndPointKey];
    
    CGFloat width = 0;
    CGFloat height = 0;
    
    // 设置 refreshControl 的 frame
    for (int i = 0; i < startPoints.count; i++) {
        CGPoint startPoint = CGPointFromString(startPoints[i]);
        CGPoint endPoint = CGPointFromString(endPoints[i]);
        if (startPoint.x > width) { width = startPoint.x; }
        if (endPoint.x > width) { width = endPoint.x; }
        if (startPoint.y > height) { height = startPoint.y; }
        if (endPoint.y > height) { height = endPoint.y; }
    }
    refreshControl.frame = CGRectMake(0, 0, width, height);
    
    // 创建 barItem 并添加到 refreshControl 视图上
    NSMutableArray<XYZBarItem *> *mutableBarItems = [[NSMutableArray alloc] init];
    for (int i = 0; i < startPoints.count; i++) {
        CGPoint startPoint = CGPointFromString(startPoints[i]);
        CGPoint endPoint = CGPointFromString(endPoints[i]);
        
        XYZBarItem *barItem = [[XYZBarItem alloc] initWithFrame:refreshControl.frame startPoint:startPoint endPoint:endPoint color:color lineWidth:lineWidth];
        barItem.backgroundColor = UIColor.clearColor;
        barItem.tag = i;
        [mutableBarItems addObject:barItem];
        [refreshControl addSubview:barItem];
    }
    
    refreshControl.barItems = [mutableBarItems copy];
    for (XYZBarItem *barItem in refreshControl.barItems) {
        [barItem setupWithFrame:refreshControl.frame];
    }
    
    refreshControl.center = CGPointMake([UIScreen mainScreen].bounds.size.width*0.5, -dropHeight*0.5);
    
    refreshControl.transform = CGAffineTransformMakeScale(scale, scale);
    
    return refreshControl;
}

#pragma mark - scrollViewDelegate方法中调用

- (void)scrollViewDidScroll {
    if (self.refreshState == XYZRefreshControlStateIdle) {
        [self xyz_updateBarItemsWithProgress:self.xyz_animationProgress];
    }
}

- (void)scrollViewDidEndDragging {
    if (self.refreshState == XYZRefreshControlStateIdle && self.xyz_realContentOffsetY < -self.dropHeight) {
        
        self.refreshState = XYZRefreshControlStateRefreshing;
        
        if (self.refreshState == XYZRefreshControlStateRefreshing) {
            // 设置新的contentInset
            UIEdgeInsets newInsets = self.scrollView.contentInset;
            newInsets.top = self.dropHeight;
            self.scrollView.contentInset = newInsets;
            
            if ([self.target respondsToSelector:self.action]) {
                if (!self.target) { return; }
                IMP imp = [self.target methodForSelector:self.action];
                void (*func)(id, SEL) = (void *)imp;
                func(self.target, self.action);
                
                self.scrollView.userInteractionEnabled = NO;// 正在刷新时禁止交互
            }
            
            [self xyz_startLoadingAnimation];
        }
    }
}

// 刷新结束时调用
- (void)finishingLoading {
    if (self.refreshState == XYZRefreshControlStateRefreshing) {
        self.refreshState = XYZRefreshControlStateDisappearing;
        UIEdgeInsets newInsets = self.scrollView.contentInset;
        newInsets.top = 0;
        [UIView animateWithDuration:kDisappearDuration animations:^{
            self.scrollView.contentInset = newInsets;
        } completion:^(BOOL finished) {
            // 重置刷新状态
            self.refreshState = XYZRefreshControlStateIdle;
            self.scrollView.userInteractionEnabled = YES;
            [self.displayLink invalidate];
            self.disappearProgress = 1;
        }];
        
        for (XYZBarItem *barItem in self.barItems) {
            [barItem.layer removeAllAnimations];
            barItem.alpha = kBarDarkAlpha;
        }
        
        self.disappearProgress = 1;
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(xyz_updateDisappearAnimation)];
        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

#pragma mark - private method

- (void)xyz_updateBarItemsWithProgress:(CGFloat)progress {
    for (int i = 0; i < self.barItems.count; i++) {
        XYZBarItem *barItem = self.barItems[i];
        
        CGFloat startPadding = (1 - self.internalAnimationFactor) / self.barItems.count * i;
        CGFloat endPadding = 1 - self.internalAnimationFactor - startPadding;
        
        if (progress == 1 || progress >= 1-endPadding) {
            barItem.transform = CGAffineTransformIdentity;
            barItem.alpha = kBarDarkAlpha;
        } else if (progress == 0) {
            // 设置默认状态
            [barItem setHorizontalRandomness:self.horizontalRandomness dropHeight:self.dropHeight];
        } else {
            
            CGFloat realProgress = (progress <= startPadding) ? 0 : MIN(1, (progress - startPadding)/self.internalAnimationFactor);
            
            barItem.transform = CGAffineTransformMakeTranslation(barItem.translationX*(1-realProgress), -self.dropHeight*(1-realProgress));
            barItem.transform = CGAffineTransformRotate(barItem.transform, M_PI*(1-realProgress));
            barItem.transform = CGAffineTransformScale(barItem.transform, realProgress, realProgress);
            barItem.alpha = realProgress*kBarDarkAlpha;
        }
    }
}

- (void)xyz_updateDisappearAnimation {
    if (self.disappearProgress >= 0 && self.disappearProgress <= 1) {
        self.disappearProgress -= 1/60.f/kDisappearDuration;
        //60.f means this method get called 60 times per second
        [self xyz_updateBarItemsWithProgress:self.disappearProgress];
    }
}

// 加载动画
- (void)xyz_startLoadingAnimation {
    if (self.reverseLoadingAnimation) {
        int count = (int)self.barItems.count;
        for (int i = count-1; i >= 0; i--) {
            XYZBarItem *barItem = self.barItems[i];
            [self performSelector:@selector(xyz_barItemAnimation:) withObject:barItem afterDelay:(self.barItems.count-i-1)*kLoadingTimingOffset inModes:@[NSRunLoopCommonModes]];
        }
    } else {
        for (int i = 0; i < self.barItems.count; i++) {
            XYZBarItem *barItem = self.barItems[i];
            [self performSelector:@selector(xyz_barItemAnimation:) withObject:barItem afterDelay:i*kLoadingTimingOffset inModes:@[NSRunLoopCommonModes]];
        }
    }
}

- (void)xyz_barItemAnimation:(XYZBarItem*)barItem {
    if (self.refreshState == XYZRefreshControlStateRefreshing) {
        barItem.alpha = 1;
        [barItem.layer removeAllAnimations];
        [UIView animateWithDuration:kLoadingIndividualAnimationTiming animations:^{
            barItem.alpha = kBarDarkAlpha;
        } completion:^(BOOL finished) {}];
        
        BOOL isLastOne = self.reverseLoadingAnimation ? (barItem.tag == 0) : (barItem.tag == self.barItems.count-1);
        
        if (isLastOne && self.refreshState == XYZRefreshControlStateRefreshing) {
            [self xyz_startLoadingAnimation];
        }
    }
}

#pragma mark - readonly property

- (CGFloat)xyz_animationProgress {
    return MIN(1.f, MAX(0, fabs(self.xyz_realContentOffsetY < 0 ? self.xyz_realContentOffsetY : 0)/self.dropHeight));
}

- (CGFloat)xyz_realContentOffsetY {
    return self.scrollView.contentOffset.y + (self.hasNav ? pUINavBarAndStatusBarHeight : pUIStatusBarHeight);
}

@end
