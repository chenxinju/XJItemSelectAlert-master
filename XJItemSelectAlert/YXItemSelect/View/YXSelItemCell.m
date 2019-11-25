//
//  YXSelItemCell.m
//  YXItemSelect
//
//  Created by apple on 2018/6/14.
//  Copyright © 2018 apple. All rights reserved.
//

//
//  YXSelItemCell.m
//  XJItemSelectAlert
//
//  Created by mac on 2019/11/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import "YXSelItemCell.h"
#import "GlobalHeader.h"
@interface YXSelItemCell ()
@property (weak, nonatomic) IBOutlet UIImageView *itemSelectStatus;
@property (weak, nonatomic) IBOutlet UILabel *itemTitle;

@end

@implementation YXSelItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItemModel:(ItemModel *)itemModel {
    _itemModel = itemModel;
    self.itemTitle.text = itemModel.itemName;
    [self.itemSelectStatus setImage:_itemModel.isSel?ImageName(@"icon_choose_sel"):ImageName(@"icon_choose")];
}

@end
