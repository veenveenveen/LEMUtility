//
//  UIImageView+CircleCorner.m
//  LEMUtility
//
//  Created by Himin on 2018/11/27.
//  Copyright © 2018 Himin. All rights reserved.
//

#import "UIImageView+CircleCorner.h"

@implementation UIImageView (CircleCorner)

+ (UIImageView *)circleImageViewWith:(CGRect)frame image:(UIImage *)image {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:frame];
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0);
    // 获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 添加一个圆
    CGContextAddEllipseInRect(context, imgView.bounds);
    // 裁剪
    CGContextClip(context);
    // 绘制
    [image drawInRect:imgView.bounds];
    // 获取绘制后的图片
    imgView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imgView;
}

+ (UIImageView *)cornerImageViewWith:(CGRect)frame image:(UIImage *)image cornerRadius:(CGFloat)radius {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:frame];
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0);
    [[UIBezierPath bezierPathWithRoundedRect:imgView.bounds cornerRadius:radius] addClip];
    [image drawInRect:imgView.bounds];
    imgView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imgView;
}

@end
