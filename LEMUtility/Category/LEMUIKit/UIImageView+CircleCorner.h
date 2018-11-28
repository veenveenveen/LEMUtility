//
//  UIImageView+CircleCorner.h
//  LEMUtility
//
//  Created by Himin on 2018/11/27.
//  Copyright © 2018 Himin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (CircleCorner)

// 圆形
+ (UIImageView *)circleImageViewWith:(CGRect)frame image:(UIImage *)image;
// 圆角
+ (UIImageView *)cornerImageViewWith:(CGRect)frame image:(UIImage *)image cornerRadius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END
