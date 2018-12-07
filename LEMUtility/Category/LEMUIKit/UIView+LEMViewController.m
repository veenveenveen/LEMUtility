//
//  UIView+LEMViewController.m
//  LEMUtility
//
//  Created by Himin on 2018/12/5.
//  Copyright © 2018 Himin. All rights reserved.
//

#import "UIView+LEMViewController.h"

@implementation UIView (LEMViewController)

- (UIViewController *)lem_viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
