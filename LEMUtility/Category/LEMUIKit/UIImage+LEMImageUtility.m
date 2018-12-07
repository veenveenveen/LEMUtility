//
//  UIImage+LEMImageUtility.m
//  LEMUtility
//
//  Created by Himin on 2018/12/7.
//  Copyright © 2018 Himin. All rights reserved.
//

#import "UIImage+LEMImageUtility.h"

@implementation UIImage (LEMImageUtility)

+ (UIImage *)fullScreenImage {
    CGSize imageSize = [UIScreen mainScreen].bounds.size;
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        if (![window respondsToSelector:@selector(screen)] || window.screen == UIScreen.mainScreen) {
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, window.center.x, window.center.y);
            CGContextConcatCTM(context, window.transform);
            CGContextTranslateCTM(context, -window.bounds.size.width*window.layer.anchorPoint.x, -window.bounds.size.height*window.layer.anchorPoint.y);
            [window.layer renderInContext:context];// renderInContext方法的使用要注意~
            CGContextRestoreGState(context);
        }
    }
    
    return UIGraphicsGetImageFromCurrentImageContext();;
}



@end
