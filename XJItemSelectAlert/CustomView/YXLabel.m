//
//  YXLabel.m
//  YXItemSelect
//
//  Created by apple on 2018/6/14.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YXLabel.h"

@implementation YXLabel

- (YXLabel *)initWithFrame:(CGRect)frame title:(NSString *)lblTitle color:(UIColor *)lblColor font:(UIFont *)lblFont alignment:(NSTextAlignment)alignment {
    YXLabel *label = [[YXLabel alloc] initWithFrame:frame];
    [label setText:lblTitle];
    [label setFont:lblFont];
    [label setTextColor:lblColor];
    [label setTextAlignment:alignment];
    
    return label;
}

@end
