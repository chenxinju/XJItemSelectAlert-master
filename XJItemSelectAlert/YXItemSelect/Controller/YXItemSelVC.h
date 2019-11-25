//
//  YXItemSelVC.h
//  YXItemSelect
//
//  Created by apple on 2018/6/14.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXSelItemCell.h"


typedef NS_ENUM(NSInteger, SelectType) {
    SignleSelect,//单选
    SignleSelectCheckBox,//单选可复选
    MultipleSelect//多选
};

typedef void(^DidSelectItem)(NSMutableArray *itemArray);

@interface YXItemSelVC : UIViewController

/**
 弹出视图的圆角设置
 */
@property (nonatomic, assign) CGFloat viewCorneradius;

/**
 配置主题颜色
 */
@property (nonatomic, strong) UIColor *themeColor;

/**
 配置标题颜色
 */
@property (nonatomic, strong) UIColor *titleColor;

/**
 选择风格（居中弹出或者是菜单栏弹出）
 */
//@property (nonatomic, assign) SelectItemStyle itemStyle;

/**
 选择类型（单选，多选,单选复选）
 */
@property (nonatomic, assign) SelectType selectType;

/**
 传递数据(存放的都是被选择的对象)
 */
@property (nonatomic, strong) NSArray <NSString *> *optionsArray;


/**
 选择的数据数据源(放这里是为了便于传递从上级页面带过来的已选中的数据，从而渲染在视图上)
 */
@property (nonatomic, strong) NSMutableArray *selectArray;
//
@property (nonatomic, copy) DidSelectItem itemBlock;
//标题
@property (nonatomic, strong) NSString *titleStr;

#pragma mark - method

/**
 初始化，携带数据源

 @param optionsArray 携带的数据源
 @return 返回对象
 */
+ (YXItemSelVC *)initItemSelVCWithOptionsArray:(NSArray *)optionsArray;

/**
 展示选择视图
*/
-(void)showInController;
/**
 背景遮罩视图的颜色以及透明度(默认黑色，透明度为0.7)
 */
- (void)setBgColor:(UIColor *)bgColor alpha:(CGFloat)alpha;

@end
