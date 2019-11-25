//
//  YXLabel.h
//  YXItemSelect
//
//  Created by apple on 2018/6/14.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXLabel : UILabel

/**
 初始化

 @param frame 坐标尺寸
 @param lblTitle 标题
 @param lblColor 标题颜色
 @param lblFont 标题字体样式
 @param alignment 位置
 @return 返回实体
 */
- (YXLabel *)initWithFrame:(CGRect)frame title:(NSString *)lblTitle color:(UIColor *)lblColor font:(UIFont *)lblFont alignment:(NSTextAlignment)alignment;
@end
