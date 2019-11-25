//
//  YXButton.h
//  YXItemSelect
//
//  Created by apple on 2018/6/14.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXButton : UIButton

/**
 初始化按钮

 @param btnType 类型
 @param frame 坐标
 @param title 标题
 @param titleColor 标题颜色
 @param titleFont 标题字体
 @param action 事件
 @param target target
 @return 返回按钮实体
 */
- (YXButton *)initWithType:(UIButtonType)btnType frame:(CGRect)frame btnTitle:(NSString *)title color:(UIColor *)titleColor font:(UIFont *)titleFont action:(SEL)action target:(id)target;

@end
