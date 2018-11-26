//
//  HMLoading.h
//  TestAll
//
//  Created by 黄启明 on 2018/11/6.
//  Copyright © 2018 Himin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HMLoadingStyle) {
    HMLoadingStyleSystem = 0,
    HMLoadingStyleSandClock = 1,
    HMLoadingStyleOrbitView = 2
};

@interface HMLoading : NSObject

+ (void)showLoading:(HMLoadingStyle)loadingStyle;
+ (void)hideLoading;

@end

NS_ASSUME_NONNULL_END
