//
//  NSString+LEM.h
//  LEMUtility
//
//  Created by Himin on 2018/11/26.
//  Copyright © 2018 Himin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LEM)

// 根据字符串计算label的size
- (CGSize)sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;

@end

NS_ASSUME_NONNULL_END
