//
//  ViewController.m
//  XJItemSelectAlert
//
//  Created by mac on 2019/11/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ViewController.h"

#import "XJMarkArertView.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray <NSString *> *dataArray;

@property (nonatomic, strong) XJMarkArertView * alertView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self performSelector:@selector(showMarkAlertView) withObject:self afterDelay:1.5];
}


- (void)showMarkAlertView {
    
    [self.alertView showinitWithTitle:@"亲，您不想成为\n VIP会员的原因是？（可多选）" subjects:self.dataArray CompleteBlock:^(NSString * _Nonnull contents, NSString *selectedMarkStr, NSArray * _Nonnull selesubs) {
        NSLog(@"提交---%@ -----%@  ------%@",contents,selectedMarkStr,selesubs);
    }];
}


- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSArray arrayWithObjects:@"没找到模版",@"操作麻烦",@"模版太少",@"不经常用",@"价格太贵",@"功能太少",@"其他问题", nil];
    }
    return _dataArray;
}


- (XJMarkArertView *)alertView{
    if (!_alertView) {
        _alertView = [XJMarkArertView sharedAlertView];
        _alertView.frame = [UIApplication sharedApplication].keyWindow.bounds;
        _alertView.buttonBackColor =  [UIColor colorWithRed:211/255.0 green:242/255.0 blue:255/255.0 alpha:1.0];
    }
    return _alertView;
}
@end
