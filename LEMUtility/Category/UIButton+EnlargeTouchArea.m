//
//  UIButton+EnlargeTouchArea.m
//  LEMUtility
//
//  Created by Himin on 2018/11/27.
//  Copyright © 2018 Himin. All rights reserved.
//

#import "UIButton+EnlargeTouchArea.h"
#import <objc/runtime.h>

static char leftKey;
static char topKey;
static char rightKey;
static char bottomKey;

@implementation UIButton (EnlargeTouchArea)

- (void)enlargeTouchAreaWith:(CGFloat)size {
    objc_setAssociatedObject(self, &leftKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &topKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)enlargeTouchAreaWithLeft:(CGFloat)left top:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom {
    objc_setAssociatedObject(self, &leftKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &topKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)enlargeRect {
    NSNumber *left = objc_getAssociatedObject(self, &leftKey);
    NSNumber *top = objc_getAssociatedObject(self, &topKey);
    NSNumber *right = objc_getAssociatedObject(self, &rightKey);
    NSNumber *bottom = objc_getAssociatedObject(self, &bottomKey);
    if (left && top && right && bottom) {
        return CGRectMake(self.bounds.origin.x-left.floatValue, self.bounds.origin.y-top.floatValue, self.bounds.size.width+left.floatValue+right.floatValue, self.bounds.size.height+top.floatValue+bottom.floatValue);
    } else {
        return self.bounds;
    }
}

// 此方法为重写方法 hitTest和pointInside都重写时，hitTest生效
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect rect = [self enlargeRect];
    if (CGRectEqualToRect(rect, self.bounds)) {
        return [super hitTest:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? self : nil;
}

//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//    CGRect rect = [self enlargeRect];
//    if (CGRectEqualToRect(rect, self.bounds)) {
//        return CGRectContainsPoint(self.bounds, point);
//    }
//    return CGRectContainsPoint(rect, point);
//}

@end
