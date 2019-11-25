//
//  YXButton.m
//  YXItemSelect
//
//  Created by apple on 2018/6/14.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YXButton.h"

@implementation YXButton

- (YXButton *)initWithType:(UIButtonType)btnType frame:(CGRect)frame btnTitle:(NSString *)title color:(UIColor *)titleColor font:(UIFont *)titleFont action:(SEL)action target:(id)target {
    YXButton *yxbtn = [YXButton buttonWithType:btnType];
    [yxbtn setFrame:frame];
    [yxbtn setTitle:title forState:0];
    [yxbtn setTitleColor:titleColor forState:0];
    [yxbtn.titleLabel setFont:titleFont];
    [yxbtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return yxbtn;
}

@end
