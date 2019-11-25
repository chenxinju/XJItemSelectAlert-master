//
//  UIView+EX.h
//  PublicOpinionSniff
//
//  Created by apple on 2018/4/24.
//  Copyright © 2018年 Yuanthail. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 边框方向 */
typedef NS_ENUM(NSInteger, UIViewBorderDirection) {
    UIViewBorderDirectionTop = 0,
    UIViewBorderDirectionLeft,
    UIViewBorderDirectionBottom,
    UIViewBorderDirectionRight
};
@interface UIView (EX)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

/**
 寻找当前view所在的主视图控制器
 
 @return 返回当前主视图控制器
 */
- (UIViewController *)viewController;

#pragma mark - 添加边框

/**
 添加单条边框
 
 @param direction 边框方向
 @param color     边框颜色
 @param width     边框宽度
 */
- (void)addSingleBorder: (UIViewBorderDirection)direction color: (UIColor *)color width: (CGFloat)width;

/**
 添加四周的边框
 
 @param color 边框颜色
 @param width 边框宽度
 */
- (void)addBorder: (UIColor *)color width: (CGFloat)width;

/**
 添加圆角
 
 @param radius 弧度值
 */
- (void)addCornerWothRadius: (CGFloat)radius;

/**
 添加阴影
 
 @param color 颜色
 @param shadowOpacity 透明度
 @param shadowRadius 半径
 */
- (void)addShadowWithColor:(UIColor *)color Opacity:(float)shadowOpacity shadowRadius:(CGFloat)shadowRadius;

/**
 计算文字高度，传入的必须 父类是UIView，而且有文字的。
 
 @param textWidth 控件布局的文字宽度
 @return 返回文字高度
 */
- (CGFloat)textHeightForTextWidth: (CGFloat)textWidth;

/**
 计算文字宽度
 
 @param textHeight 控件布局的文字高度
 @return 返回文字宽度
 */
- (CGFloat)textWidthForTextHeight: (CGFloat)textHeight;

/**
 设置阴影效果
 
 @param radius 半径
 @param shadow 阴影
 @param opacity 透明度
 */
- (void)setCornerRadius:(CGFloat)radius withShadow:(BOOL)shadow withOpacity:(CGFloat)opacity;
@end
