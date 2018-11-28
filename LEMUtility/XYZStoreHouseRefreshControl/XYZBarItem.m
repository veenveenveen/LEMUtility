//
//  XYZBarItem.m
//  TestAll
//
//  Created by 黄启明 on 2018/11/7.
//  Copyright © 2018 Himin. All rights reserved.
//

#import "XYZBarItem.h"

@interface XYZBarItem ()

@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGPoint endPoint;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, assign) CGPoint middlePoint;

@end

@implementation XYZBarItem

- (instancetype)initWithFrame:(CGRect)frame startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint color:(UIColor *)color lineWidth:(CGFloat)lineWidth {
    if (self = [super initWithFrame:frame]) {
        _startPoint = startPoint;
        _endPoint = endPoint;
        _color = color;
        _lineWidth = lineWidth;
        _middlePoint = CGPointMake((startPoint.x+endPoint.x)*0.5, (startPoint.y+endPoint.y)*0.5);
    }
    return self;
}

- (void)setupWithFrame:(CGRect)rect {
    self.layer.anchorPoint = CGPointMake(self.middlePoint.x/self.frame.size.width, self.middlePoint.y/self.frame.size.height);
    self.frame = CGRectMake(self.frame.origin.x + self.middlePoint.x - self.frame.size.width/2, self.frame.origin.y + self.middlePoint.y - self.frame.size.height/2, self.frame.size.width, self.frame.size.height);
}

- (void)setHorizontalRandomness:(int)horizontalRandomness dropHeight:(CGFloat)dropHeight {
    int randomNumber = - horizontalRandomness + arc4random()%horizontalRandomness*2;
    self.translationX = randomNumber;
    self.transform = CGAffineTransformMakeTranslation(randomNumber, -dropHeight);
}

// Only override drawRect: if you perform custom drawing.
- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = UIBezierPath.bezierPath;
    [path moveToPoint:_startPoint];
    [path addLineToPoint:_endPoint];
    [_color setStroke];
    [path setLineWidth:_lineWidth];
    [path stroke];
}


@end
