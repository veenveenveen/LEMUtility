//
//  UIView+LEMBlockGesture.m
//  LEMUtility
//
//  Created by Himin on 2018/11/30.
//  Copyright © 2018 Himin. All rights reserved.
//

#import "UIView+LEMBlockGesture.h"
#import "objc/runtime.h"

static char gestureActionKey;

@implementation UIView (LEMBlockGesture)

- (void)addTapGestureWithBlock:(LEMGestureBlock)gestureBlock {
    objc_setAssociatedObject(self, &gestureActionKey, gestureBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction:)];
    [self addGestureRecognizer:tapGesture];
}

- (void)addPanGestureWithBlock:(LEMGestureBlock)gestureBlock {
    objc_setAssociatedObject(self, &gestureActionKey, gestureBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction:)];
    [self addGestureRecognizer:panGesture];
}

#pragma mark - gesture action

- (void)gestureAction:(UITapGestureRecognizer *)recognizer {
    LEMGestureBlock block = (LEMGestureBlock)objc_getAssociatedObject(self, &gestureActionKey);
    if (block) {
        block(recognizer);
    }
}

@end
