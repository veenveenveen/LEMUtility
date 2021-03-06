//
//  UIButton+LEMFactory.m
//  LEMUtility
//
//  Created by Himin on 2018/11/28.
//  Copyright © 2018 Himin. All rights reserved.
//

#import "UIButton+LEMFactory.h"
#import <objc/runtime.h>

static char actionKey;

@implementation UIButton (LEMFactory)

#pragma mark - 按钮构造方法

+ (UIButton *)textButtonWithFrame:(CGRect)frame text:(NSString *)text textFont:(UIFont *)font textColor:(UIColor *)textColor click:(LEMButtonClickBlock)clickBlock {
    return [self buttonWithFrame:frame image:nil text:text textFont:font textColor:textColor click:clickBlock];
}

+ (UIButton *)imageButtonWithFrame:(CGRect)frame image:(UIImage *)image click:(LEMButtonClickBlock)clickBlock {
    return [self buttonWithFrame:frame image:image text:nil textFont:nil textColor:nil click:clickBlock];
}

+ (UIButton *)buttonWithFrame:(CGRect)frame image:(UIImage *)image text:(NSString *)text textFont:(UIFont *)font textColor:(UIColor *)textColor click:(LEMButtonClickBlock)clickBlock {
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    if (image) {
        [btn setImage:image forState:UIControlStateNormal];
        [btn setImage:image forState:UIControlStateHighlighted];
        btn.contentMode = UIViewContentModeCenter;
    }
    if (text) {
        [btn setTitle:text forState:UIControlStateNormal];
        if (font) { btn.titleLabel.font = font; }
        if (textColor) {  [btn setTitleColor:textColor forState:UIControlStateNormal]; }
    }
    btn.exclusiveTouch = YES;
    if (clickBlock) {
        [btn addClickBlock:clickBlock];
    }
    return btn;
}

#pragma mark - 添加按钮事件

- (void)addClickBlock:(LEMButtonClickBlock)clickBlock {
    [self addTargetBlock:clickBlock forControlEvent:UIControlEventTouchUpInside];
}

- (void)addTargetBlock:(LEMButtonClickBlock)targetBlock forControlEvent:(UIControlEvents)controlEvent {
    objc_setAssociatedObject(self, &actionKey, targetBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(btnDidClick:) forControlEvents:controlEvent];
}

- (void)btnDidClick:(id)sender {
    LEMButtonClickBlock block = (LEMButtonClickBlock)objc_getAssociatedObject(self, &actionKey);
    if (block) {
        block(sender);
    }
}

#pragma mark - 设置按钮和图片的位置

- (void)setButtonImagePosition:(LEMButtonImagePosition)buttonImagePosition {

    /* 图片和文字的间距 */
    CGFloat space = 5;
    /* 获取按钮的图片和文字、字体 */
    NSString *titleString = self.currentTitle;
    UIImage *btnImage = self.currentImage;
    UIFont *font = self.titleLabel.font;
    if (btnImage == nil || titleString == nil) {
        NSLog(@"图片或文字不存在");
        return;
    }
    /* 获取图片和文字的宽度 */
    CGFloat titleWidth = [titleString sizeWithAttributes:@{NSFontAttributeName: font}].width;
    CGFloat imageWidth = btnImage.size.width;
    /* 获取图片和文字的高度 */
    CGFloat imageHeight = btnImage.size.height;
    CGFloat titleHeight = [titleString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}].height;
    
    if (buttonImagePosition == LEMButtonImagePositionTop) {
        
        self.imageEdgeInsets = UIEdgeInsetsMake(-(imageHeight*0.5 + space*0.5), titleWidth*0.5, imageHeight*0.5 + space*0.5, -titleWidth*0.5);
        self.titleEdgeInsets = UIEdgeInsetsMake(titleHeight*0.5 + space*0.5, -imageWidth*0.5, -(titleHeight*0.5 + space*0.5), imageWidth*0.5);
        
    } else if (buttonImagePosition == LEMButtonImagePositionRight) {
        
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth+space*0.5), 0, (imageWidth+space*0.5));
        self.imageEdgeInsets = UIEdgeInsetsMake(0, (titleWidth+space*0.5), 0, -(titleWidth+space*0.5));
        
    } else if (buttonImagePosition == LEMButtonImagePositionBottom) {
        
        self.imageEdgeInsets = UIEdgeInsetsMake((imageHeight*0.5 + space*0.5), titleWidth*0.5, -(imageHeight*0.5 + space*0.5), -titleWidth*0.5);
        self.titleEdgeInsets = UIEdgeInsetsMake(-(titleHeight*0.5 + space*0.5), -imageWidth*0.5, (titleHeight*0.5 + space*0.5), imageWidth*0.5);
        
    } else {
        
        self.titleEdgeInsets = UIEdgeInsetsMake(0, space*0.5, 0, -space*0.5);
        self.imageEdgeInsets = UIEdgeInsetsMake(0, -space*0.5, 0, space*0.5);
        
    }
}

@end
