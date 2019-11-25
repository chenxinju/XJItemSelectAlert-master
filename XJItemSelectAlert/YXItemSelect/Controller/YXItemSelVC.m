//
//  YXItemSelVC.m
//  YXItemSelect
//
//  Created by apple on 2018/6/14.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YXItemSelVC.h"
#import "ItemModel.h"
#import "Masonry.h"
//#import <UITableView+FDTemplateLayoutCell.h>
#import "YXButton.h"
#import "YXLabel.h"
#import "GlobalHeader.h"
#import "UIView+EX.h"
@interface YXItemSelVC ()<UITableViewDelegate, UITableViewDataSource>
{
    NSIndexPath *_selectIndexPath;//记录最后一次点击的cell的位置
    BOOL _signSelectStatus;//记录单选的状态
}
@property (nonatomic, strong) UIView *carrayView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) YXLabel *headTitle;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *footView;
@property (nonatomic, strong) YXButton *cancelBtn;
@property (nonatomic, strong) UIView *segmentLine;
@property (nonatomic, strong) YXButton *sureBtn;

//列表数据源
@property (nonatomic, strong) NSMutableArray <ItemModel *> *dataSource;

@end

@implementation YXItemSelVC

+ (YXItemSelVC *)initItemSelVCWithOptionsArray:(NSArray *)optionsArray {
    YXItemSelVC *itemSelVC = [[YXItemSelVC alloc] init];
    itemSelVC.optionsArray = optionsArray;
    return itemSelVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:COLOR_A_RGB(0, 0, 0, 0.7)];
    [self addContrains];
    
    for (NSString *name in self.optionsArray) {
        ItemModel *selModel = [[ItemModel alloc] init];
        selModel.itemName = name;
        selModel.isSel = [self.selectArray containsObject:name];
        [self.dataSource addObject:selModel];
    }
    [self.tableView reloadData];
    
}

#pragma mark - method
//设置弹出视图圆角设置
- (void)setViewCorneradius:(CGFloat)viewCorneradius {
    [self.carrayView addCornerWothRadius:viewCorneradius];
}
//配置主题色
- (void)setThemeColor:(UIColor *)themeColor {
    //其实就是更改了两个按钮背景色和标题视图的颜色
    [self.headView setBackgroundColor:themeColor];
    [self.sureBtn setBackgroundColor:themeColor];
    [self.cancelBtn setBackgroundColor:themeColor];
}
//配置标题颜色
- (void)setTitleColor:(UIColor *)titleColor {
    [self.headTitle setTextColor:titleColor];
}

/**
 设置背景颜色和透明度
 */
- (void)setBgColor:(UIColor *)bgColor alpha:(CGFloat)alpha {
    [self.view setBackgroundColor:bgColor];
    [self.view setAlpha:alpha];
}


- (void)addContrains{
    [self.view addSubview:self.carrayView];
    [self.carrayView addSubview:self.headView];
    [self.carrayView addSubview:self.tableView];
    [self.carrayView addSubview:self.footView];
    [self.headView addSubview:self.headTitle];
    [self.footView addSubview:self.segmentLine];
    [self.footView addSubview:self.cancelBtn];
    [self.footView addSubview:self.sureBtn];
    
    [self.carrayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.left.mas_equalTo(self.view.mas_left).offset(30);
    }];
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.carrayView);
        make.height.mas_equalTo(50);
    }];
    [self.headTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.headView.mas_centerX);
        make.centerY.mas_equalTo(self.headView.mas_centerY);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headView.mas_bottom);
        make.left.right.mas_equalTo(self.carrayView);
        make.height.mas_equalTo(350);
    }];
    [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tableView.mas_bottom);
        make.left.right.mas_equalTo(self.carrayView);
        make.height.mas_equalTo(50);
    }];
    
    [self.segmentLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.footView.mas_centerX);
        make.centerY.mas_equalTo(self.footView.mas_centerY);
        make.top.mas_equalTo(self.footView);
        make.width.mas_equalTo(1);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_equalTo(self.footView);
        make.right.mas_equalTo(self.segmentLine.mas_left);
        make.width.mas_equalTo(self.sureBtn.mas_width);

    }];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(self.footView);
        make.left.mas_equalTo(self.segmentLine.mas_right);
        make.width.mas_equalTo(self.sureBtn.mas_width);
    }];
    
    [self.carrayView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.footView.mas_bottom);
    }];
    
    [self.tableView reloadData];
}

//展示
-(void)showInController {
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVC addChildViewController:self];
    [rootVC.view addSubview:self.view];
}


#pragma mark - action
- (void)cancelAction{
    [self removeView];
}

- (void)sureAction{
    [self removeView];
    if (self.itemBlock) {
        //处理选择的数据中多余的标点符号
        if (self.selectArray.count>0 && [(self.selectArray.firstObject) containsString:Placeholder]) {
            [self.selectArray removeObjectAtIndex:0];
        }
        self.itemBlock(self.selectArray);
    }
}
-(void)removeView{
    [UIView animateWithDuration:0.35 animations:^{
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YXSelItemCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YXSelItemCell class])];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"YXSelItemCell" owner:nil options:nil].lastObject;
    }
    [cell setItemModel:self.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 45.f;
//    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([YXSelItemCell class]) cacheByIndexPath:indexPath configuration:^(YXSelItemCell *cell) {
//        cell.itemModel = self.dataSource[indexPath.row];
//    }];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YXSelItemCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (self.selectType == SignleSelect) {
        for (ItemModel *itemModel in self.dataSource) {
            itemModel.isSel = NO;//全部初始化为NO
        }
        //先删除已有的数据
        [self.selectArray removeAllObjects];
        cell.itemModel.isSel = !cell.itemModel.isSel;
        
    }else if (self.selectType == SignleSelectCheckBox){
        for (ItemModel *itemModel in self.dataSource) {
            itemModel.isSel = NO;
        }
        //判断当前选中的行是否和上一次一致（包括从上个页面带过来的值得所在行）
        if (_selectIndexPath == indexPath) {
            //说明点击的还是同一个cell
            cell.itemModel.isSel = !_signSelectStatus;
            
        }else {
            //当前点击的row与原来不一致
            cell.itemModel.isSel = !cell.itemModel.isSel;
        }
        [self.selectArray removeAllObjects];
        //重新记录状态
        _signSelectStatus = cell.itemModel.isSel;
        _selectIndexPath = indexPath;
    }else {
        cell.itemModel.isSel = !cell.itemModel.isSel;
    }
    
    
    if (cell.itemModel.isSel) {
        [self.selectArray addObject:cell.itemModel.itemName];
    }else {
        [self.selectArray removeObject:cell.itemModel.itemName];
    }
    [self.tableView reloadData];
}

#pragma mark - setter
- (void)setTitleStr:(NSString *)titleStr {
    self.headTitle.text = titleStr;
}

#pragma mark - initialize

- (UIView *)carrayView {
    if (!_carrayView) {
        _carrayView = [[UIView alloc] init];
        [_carrayView addCornerWothRadius:8];
    }
    return _carrayView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setShowsVerticalScrollIndicator:NO];
        [_tableView registerNib:[UINib nibWithNibName:@"YXSelItemCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([YXSelItemCell class])];
    }
    return _tableView;
}

- (UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc] init];
        [_headView setBackgroundColor:COLOR_Hex(0x00B2A9)];
    }
    return _headView;
}

- (YXLabel *)headTitle {
    if (!_headTitle) {
        _headTitle = [[YXLabel alloc] initWithFrame:CGRectZero title:@"默认标题" color:[UIColor whiteColor] font:TEXT_MediumFont(16) alignment:NSTextAlignmentCenter];
    }
    return _headTitle;
}

- (UIView *)footView {
    if (!_footView) {
        _footView = [[UIView alloc] initWithFrame:CGRectZero];
        [_footView setBackgroundColor:COLOR_WHITE];
    }
    return _footView;
}

- (YXButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[YXButton alloc] initWithType:0 frame:CGRectZero btnTitle:@"取消" color:[UIColor whiteColor] font:TEXT_RegularFont(16) action:@selector(cancelAction) target:self];
        [_cancelBtn setBackgroundColor:COLOR_Hex(0x00B2A9)];
    }
    return _cancelBtn;
}

- (UIView *)segmentLine {
    if (!_segmentLine) {
        _segmentLine = [[UIView alloc] init];
        [_segmentLine setBackgroundColor:COLOR_WHITE];
    }
    return _segmentLine;
}

- (YXButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [[YXButton alloc] initWithType:0 frame:CGRectZero btnTitle:@"确定" color:[UIColor whiteColor] font:TEXT_RegularFont(16) action:@selector(sureAction) target:self];
        [_sureBtn setBackgroundColor:COLOR_Hex(0x00B2A9)];
    }
    return _sureBtn;
}

- (NSMutableArray *)selectArray {
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


@end
