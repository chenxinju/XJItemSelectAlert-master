//
//  UIView+EX.m
//  PublicOpinionSniff
//
//  Created by apple on 2018/4/24.
//  Copyright © 2018年 Yuanthail. All rights reserved.
//

#import "UIView+EX.h"

@implementation UIView (EX)
#pragma mark - Setter

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setBottom:(CGFloat)bottom {
    self.y = bottom - self.height;
}

- (void)setRight:(CGFloat)right {
    self.x = right - self.width;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

#pragma mark - getter

- (CGFloat)x {
    return self.frame.origin.x;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGSize)size {
    return self.frame.size;
}

#pragma mark - other

- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

#pragma mark - 添加边框

/**
 添加单条边框
 
 @param direction 边框方向
 @param color     边框颜色
 @param width     边框宽度
 */
- (void)addSingleBorder: (UIViewBorderDirection)direction color: (UIColor *)color width: (CGFloat)width {
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = color;
    line.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:line];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(line);
    NSDictionary *metrics = @{@"w" : @(width),
                              @"y" : @(self.height - width),
                              @"x" : @(self.width - width)
                              };
    NSString *vfl_H = @"";
    NSString *vfl_W = @"";
    
    switch (direction) {
        case UIViewBorderDirectionTop:
        {
            vfl_H = @"H:|-0-[line]-0-|";
            vfl_W = @"V:|-0-[line(==w)]";
        }
            break;
        case UIViewBorderDirectionLeft:
        {
            vfl_H = @"H:|-0-[line(==w)]";
            vfl_W = @"V:|-0-[line]-0-|";
        }
            break;
        case UIViewBorderDirectionBottom:
        {
            vfl_H = @"H:|-0-[line]-0-|";
            vfl_W = @"V:[line(==w)]-0-|";
        }
            break;
        case UIViewBorderDirectionRight:
        {
            vfl_H = @"H:|-x-[line(==w)]";
            vfl_W = @"V:|-0-[line]-0-|";
        }
            break;
    }
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl_H options:0 metrics:metrics views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl_W options:0 metrics:metrics views:views]];
}

/**
 添加四周的边框
 
 @param color 边框颜色
 @param width 边框宽度
 */
- (void)addBorder: (UIColor *)color width: (CGFloat)width {
    CALayer *layer = self.layer;
    layer.borderColor = color.CGColor;
    layer.borderWidth = width;
}


/**
 添加圆角
 
 @param radius 弧度值
 */
- (void)addCornerWothRadius: (CGFloat)radius {
    CALayer *layer = self.layer;
    layer.cornerRadius = radius;
    layer.masksToBounds = YES;
}

/**
 添加阴影

 @param color 颜色
 @param shadowOpacity 透明度
 @param shadowRadius 半径
 */
- (void)addShadowWithColor:(UIColor *)color Opacity:(float)shadowOpacity shadowRadius:(CGFloat)shadowRadius{
    CALayer *shadowLayer = self.layer;
    shadowLayer.frame = self.layer.frame;
    shadowLayer.shadowColor = color.CGColor;
    shadowLayer.shadowOffset = CGSizeMake(0, 0);//shadowOffset阴影偏移，默认（0，-3），这个跟shadowRadius配合使用
    shadowLayer.shadowOpacity = shadowOpacity;//0.8阴影透明度，默认0
    shadowLayer.shadowRadius = shadowRadius;//半径，默认3
    
}


/**
 计算文字高度，传入的必须 父类是UIView，而且有文字的。
 
 @param textWidth 控件布局的文字宽度
 @return 返回文字高度
 */
- (CGFloat)textHeightForTextWidth: (CGFloat)textWidth {
    CGSize textSize = [self sizeThatFits:CGSizeMake(textWidth, MAXFLOAT)];
    return textSize.height;
}

/**
 计算文字宽度
 
 @param textHeight 控件布局的文字高度
 @return 返回文字宽度
 */
- (CGFloat)textWidthForTextHeight: (CGFloat)textHeight {
    CGSize textSize = [self sizeThatFits:CGSizeMake(MAXFLOAT, textHeight)];
    return textSize.width;
}
//设置view 的阴影效果
- (void)setCornerRadius:(CGFloat)radius withShadow:(BOOL)shadow withOpacity:(CGFloat)opacity {
    self.layer.cornerRadius = radius;
    if (shadow) {
        self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        self.layer.shadowOpacity = opacity;
        //        self.layer.shadowOffset = CGSizeMake(-4, 4);
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowRadius = 4;
        self.layer.shouldRasterize = NO;
        self.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:[self bounds] cornerRadius:radius] CGPath];
    }
    self.layer.masksToBounds = !shadow;
}

@end
