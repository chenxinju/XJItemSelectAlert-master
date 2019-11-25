//
//  YXSelItemCell.h
//  YXItemSelect
//
//  Created by apple on 2018/6/14.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemModel.h"
//放在这里是为了便于操控更改操作状态
//typedef NS_ENUM(NSInteger, SelectItemStyle) {
//    SelectItemStyleCenter,
//    SelectItemStyleMenu
//};

@interface YXSelItemCell : UITableViewCell

/**
 数据
 */
@property (strong, nonatomic) ItemModel *itemModel;

@end
