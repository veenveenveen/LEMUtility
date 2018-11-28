//
//  XYZBarItem.h
//  TestAll
//
//  Created by 黄启明 on 2018/11/7.
//  Copyright © 2018 Himin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYZBarItem : UIView

@property (nonatomic, assign) CGFloat translationX;

- (instancetype)initWithFrame:(CGRect)frame startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint color:(UIColor *)color lineWidth:(CGFloat)lineWidth;

- (void)setupWithFrame:(CGRect)rect;

- (void)setHorizontalRandomness:(int)horizontalRandomness dropHeight:(CGFloat)dropHeight;

@end

NS_ASSUME_NONNULL_END
