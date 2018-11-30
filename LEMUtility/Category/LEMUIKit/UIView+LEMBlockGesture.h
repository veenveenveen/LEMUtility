//
//  UIView+LEMBlockGesture.h
//  LEMUtility
//
//  Created by Himin on 2018/11/30.
//  Copyright © 2018 Himin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LEMGestureBlock)(id recognizer);

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LEMBlockGesture)

- (void)addTapGestureWithBlock:(LEMGestureBlock)gestureBlock;
- (void)addPanGestureWithBlock:(LEMGestureBlock)gestureBlock;

@end

NS_ASSUME_NONNULL_END
