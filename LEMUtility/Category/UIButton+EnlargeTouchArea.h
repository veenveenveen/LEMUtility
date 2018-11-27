//
//  UIButton+EnlargeTouchArea.h
//  LEMUtility
//
//  Created by Himin on 2018/11/27.
//  Copyright © 2018 Himin. All rights reserved.
//

// 扩大按钮点击区域

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (EnlargeTouchArea)

- (void)enlargeTouchAreaWith:(CGFloat)size;

- (void)enlargeTouchAreaWithLeft:(CGFloat)left top:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom;

@end

NS_ASSUME_NONNULL_END
