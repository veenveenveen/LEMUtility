//
//  XYZStoreHouseRefreshControl.h
//  TestAll
//
//  Created by 黄启明 on 2018/11/7.
//  Copyright © 2018 Himin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYZStoreHouseRefreshControl : UIView

+ (XYZStoreHouseRefreshControl*)attachToScrollView:(UIScrollView *)scrollView
                                            target:(id)target
                                     refreshAction:(SEL)refreshAction
                                             plist:(NSString *)plist
                                            hasNav:(BOOL)hasNav;

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
                           internalAnimationFactor:(CGFloat)internalAnimationFactor;

- (void)scrollViewDidScroll;

- (void)scrollViewDidEndDragging;

- (void)finishingLoading;

@end

NS_ASSUME_NONNULL_END
