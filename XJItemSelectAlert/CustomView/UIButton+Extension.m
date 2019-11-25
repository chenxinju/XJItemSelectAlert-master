//
//  UIButton+Extension.m
//  XJItemSelectAlert
//
//  Created by mac on 2019/11/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import "UIButton+Extension.h"

/**
 *  cell中控件的字体大小
 */
typedef enum {
    KRecipeCellFontSizeTitle = 16,        // 标题
    KRecipeCellFontSizeDesc = 12,         // 描述
    KRecipeCellFontSizeFirstTitle = 20,   // 大标题
    KRecipeCellFontSizeSecondTitle = 14   // 小标题
} KRecipeCellFontSize;

@implementation UIButton (Extension)


+ (UIButton *)exclusiveButton {
    UIButton *exclusiveButton = [UIButton buttonWithBackgroundColor:[UIColor orangeColor]
                                                              title:@"独家"
                                                     titleLabelFont:[UIFont systemFontOfSize:KRecipeCellFontSizeDesc]
                                                         titleColor:[UIColor whiteColor]
                                                             target:nil
                                                             action:nil
                                                      clipsToBounds:NO];
    exclusiveButton.enabled = NO;
    return exclusiveButton;
}



+ (UIButton *)buttonWithBackgroundColor:(UIColor *)backgroundColor
                                  title:(NSString *)title
                         titleLabelFont:(UIFont *)font
                             titleColor:(UIColor *)titleColor
                                 target:(id)target
                                 action:(SEL)action
                          clipsToBounds:(BOOL)clipsToBounds {
    
    UIButton *button = [[UIButton alloc] init];
    if (clipsToBounds) button.layer.cornerRadius = 5;
    //    button.clipsToBounds = clipsToBounds;
    button.backgroundColor = backgroundColor;
    button.titleLabel.font = font;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}


/**
 *  快速创建一个带边框的button
 *
 *  @param backgroundColor button背景颜色
 *  @param title           按钮title文字
 *  @param font            按钮title字体大小
 *  @param titleColor      按钮titleyanse
 *  @param target          target
 *  @param action          action
 *
 *  @return 创建好的button
 */
+ (UIButton *)borderButtonWithBackgroundColor:(UIColor *)backgroundColor
                                        title:(NSString *)title
                               titleLabelFont:(UIFont *)font
                                   titleColor:(UIColor *)titleColor
                                  borDerColor:(UIColor *)borderColor
                                       target:(id)target
                                       action:(SEL)action
                                clipsToBounds:(BOOL)clipsToBounds {
    
    UIButton *button = [[UIButton alloc] init];
    if (clipsToBounds) button.layer.cornerRadius = 4;
    button.layer.borderWidth = 1.0;
    button.layer.borderColor = borderColor.CGColor;
    button.backgroundColor = backgroundColor;
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space {
    /**
     *  要点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
     *  如果只有title，那它上下左右都是相对于button的，image也是一样；
     *  如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
     */
    
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    /**
     MKButtonEdgeInsetsStyleTop, // image在上，label在下
     MKButtonEdgeInsetsStyleLeft, // image在左，label在右
     MKButtonEdgeInsetsStyleBottom, // image在下，label在上
     MKButtonEdgeInsetsStyleRight // image在右，label在左
     */
    switch (style) {
        case MKButtonEdgeInsetsStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case MKButtonEdgeInsetsStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case MKButtonEdgeInsetsStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case MKButtonEdgeInsetsStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}



@end
