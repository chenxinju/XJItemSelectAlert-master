//
//  UIButton+Extension.h
//  XJItemSelectAlert
//
//  Created by mac on 2019/11/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>



// 定义一个枚举（包含了四种类型的button）
typedef NS_ENUM(NSUInteger, MKButtonEdgeInsetsStyle) {
    MKButtonEdgeInsetsStyleTop, // image在上，label在下
    MKButtonEdgeInsetsStyleLeft, // image在左，label在右
    MKButtonEdgeInsetsStyleBottom, // image在下，label在上
    MKButtonEdgeInsetsStyleRight // image在右，label在左
};



@interface UIButton (Extension)

/**
 *  快速创建图标
 */
+ (UIButton *)exclusiveButton;


/**
 *  快速创建一个button
 */
+ (UIButton *)buttonWithBackgroundColor:(UIColor *)backgroundColor
                                  title:(NSString *)title
                         titleLabelFont:(UIFont *)font
                             titleColor:(UIColor *)titleColor
                                 target:(id)target
                                 action:(SEL)action
                          clipsToBounds:(BOOL)clipsToBounds;

/**
 *  快速创建一个带边框的button
 */
+ (UIButton *)borderButtonWithBackgroundColor:(UIColor *)backgroundColor
                                        title:(NSString *)title
                               titleLabelFont:(UIFont *)font
                                   titleColor:(UIColor *)titleColor
                                  borDerColor:(UIColor *)borderColor
                                       target:(id)target
                                       action:(SEL)action
                                clipsToBounds:(BOOL)clipsToBounds;


/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;




@end
