//
//  XJAlertView.m
//  XJItemSelectAlert
//
//  Created by mac on 2019/11/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import "XJMarkArertView.h"
#import "UIView+EX.h"
#import "UIButton+Extension.h"

#define OnePixel     (1./[UIScreen mainScreen].scale)
#define animateTime  0.35f


@interface XJMarkArertView ()<UITextViewDelegate>

@property (nonatomic, strong) UIView * alertBackgroundView; //蒙版
@property (nonatomic, strong) UIView * operateView;  //操作背景区
@property(nonatomic,strong)UIImageView *optionimgbg;  //操作背景图

@property (nonatomic, strong) UIButton * confirmBtn;  //确定
@property (nonatomic,strong)UITextView *inputTextview;//输入框

@property (nonatomic, copy) XJClickBlock confirmBlock;  //确定提交的数据闭包
@property (nonatomic, assign) BOOL notifiKeyboardHide;
@property (nonatomic, assign) BOOL notifcodeType;


// 标签数组
@property (nonatomic, strong) NSArray *markArray;
// 标签字典
@property (nonatomic, strong) NSDictionary *markDict;

// 选中标签数组(数字)
@property (nonatomic, strong) NSMutableArray *selectedMarkArray;
// 选中标签数组(文字字符串)
@property (nonatomic, strong) NSMutableArray *selectedMarkStrArray;
@end

@implementation XJMarkArertView

+ (XJMarkArertView *)sharedAlertView
{
    static dispatch_once_t once;
    static XJMarkArertView * _alertView = nil;
    dispatch_once(&once, ^{
        if (_alertView == nil) {
            _alertView = [[self alloc] init];
        }
    });
    return _alertView;
}

-(void )showinitWithTitle:(NSString *)title subjects:(nullable NSArray *)subjects  CompleteBlock:(void(^)(NSString * contents,NSString *selectedMarkStr,NSArray *selesubs))completeBlock {
    
    _notifiKeyboardHide = NO;
    self.notifcodeType = NO;
    
    self.markArray = subjects;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    _alertBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_Width, SCREEN_Hight)];
    _alertBackgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    [[UIApplication sharedApplication].keyWindow addSubview:_alertBackgroundView];
    
    _alertBackgroundView.alpha = 0;
  
     __weak __typeof(&*self)weakSelf = self;
    [UIView animateWithDuration:animateTime animations:^{
        weakSelf.alertBackgroundView.alpha = 1;
    }];
    
    _operateView = [[UIView alloc] init];
    _operateView.bounds =CGRectMake(55, 0, SCREEN_Width-ScaleH(55)*2,451*kKuanXiShu);
    _operateView.center = CGPointMake(SCREEN_Width/2., SCREEN_Hight/2.);
    _operateView.backgroundColor = [UIColor whiteColor];
    _operateView.layer.cornerRadius = 25;
    _operateView.clipsToBounds = YES;
    _operateView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgtap)];
    [_operateView addGestureRecognizer:tap];
    [_alertBackgroundView addSubview:_operateView];
    
    
    self.optionimgbg = [[UIImageView alloc] initWithFrame:self.operateView.bounds];
    self.optionimgbg.image = [UIImage imageNamed:@"optionAlert_bg.png"];
    [self.operateView addSubview:self.optionimgbg];
    
    UIButton * cancel1Btn = [self createButtonWithFrame:CGRectMake(CGRectGetMaxX(_operateView.frame)/2-40,CGRectGetMaxY(_operateView.frame) + 20, 80, 20) title:@"暂不填写" andAction:@selector(removeAlertView)];
    [cancel1Btn setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_alertBackgroundView addSubview:cancel1Btn];
    
    self.confirmBlock = completeBlock;
    UIButton * confirmBtn = [self createButtonWithFrame:CGRectMake(CGRectGetMaxX(_operateView.frame)/2-60, CGRectGetHeight(_operateView.frame) - 48 - 24 ,_operateView.frame.size.width -120, 48) title:@"立即提交" andAction:@selector(sureBtnClick:)];
    confirmBtn.layer.cornerRadius = 48/2;
    confirmBtn.clipsToBounds = YES;
    [confirmBtn setBackgroundImage:[self imageWithColor:self.buttonBackColor andSize:confirmBtn.bounds.size] forState:UIControlStateNormal];
    self.confirmBtn = confirmBtn;
    
    

    UILabel * tipsLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_operateView.frame)+55, 103, CGRectGetWidth(_operateView.frame) - 64, 48)];
    tipsLab.numberOfLines = 2;
    tipsLab.text = title;
    tipsLab.textAlignment = NSTextAlignmentLeft;
    tipsLab.font = [UIFont fontWithName:@"PingFangSC-Semibold" size: 16];
    tipsLab.textColor = [UIColor colorWithRed:0/255.0 green:135/255.0 blue:255/255.0 alpha:1.0];
    [_operateView addSubview:tipsLab];
    
    
    UIView * inputBkView = [[UIView alloc] init];
    inputBkView.backgroundColor = [UIColor redColor];
    inputBkView.bounds = CGRectMake(CGRectGetMinX(_operateView.frame)+15,0, CGRectGetWidth(_operateView.frame) - 30, 40);
    inputBkView.center = CGPointMake(CGRectGetMidX(_operateView.bounds),  CGRectGetMinY(confirmBtn.frame) - 48);
    inputBkView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:150/255.0 blue:255/255.0 alpha:0.1].CGColor;
    inputBkView.layer.shadowOffset = CGSizeMake(0,3);
    inputBkView.layer.shadowOpacity = 1;
    inputBkView.layer.shadowRadius = 6;
    inputBkView.backgroundColor = [UIColor clearColor];
    [_operateView addSubview:inputBkView];
    
    
    UIView * inputBgView = [[UIView alloc] initWithFrame:inputBkView.bounds];
    inputBgView.layer.cornerRadius = 8;
    inputBgView.layer.masksToBounds = YES;
    [inputBkView addSubview:inputBgView];
    
    
    _inputTextview =  [[UITextView alloc]initWithFrame:inputBkView.bounds];
    _inputTextview.font = [UIFont systemFontOfSize:Font_Size42];
    _inputTextview.textColor = [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1.0];
    _inputTextview.selectedRange = NSMakeRange(0,0);//当UITextView中含有文字时，系统默认将光标定位到最后的位置，设置光标定位到首位置。
    _inputTextview.textContainerInset = UIEdgeInsetsMake(12, 8, 8, 0);
    _inputTextview.layer.cornerRadius = 8;
    _inputTextview.layer.masksToBounds = YES;
    //    self.textview.selectable = NO; // 默认YES 当设置为NO时，不能选择
    _inputTextview.returnKeyType = UIReturnKeyDone;
    //    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(100, 50, 50, 50)];
    //    view.backgroundColor = [UIColor redColor];
    // 在键盘上部附加一个视图，一般用于添加一个收回键盘的按钮
    //     self.textview.inputAccessoryView = view;
    // UITextView可以垂直滑动弹出键盘
    _inputTextview.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    //_inputTextview.text.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"其他" attributes:@{NSForegroundColorAttributeName:UIColorFromHex(0xcccccc), NSFontAttributeName:[UIFont systemFontOfSize:16]}];
        _inputTextview.textColor = UIColorFromHex(0x333333);
    _inputTextview.delegate = self;
    [inputBkView addSubview:_inputTextview];
//     [_inputTextview becomeFirstResponder]; //弹出键盘
    
    
    
    //筛选区
    CGFloat UI_View_Width = CGRectGetWidth(_operateView.frame);//[UIScreen mainScreen].bounds.size.width;
    CGFloat marginX = 20;
    CGFloat top = 0;
    CGFloat btnH = 30;
    CGFloat height = 130;
    CGFloat width = (UI_View_Width - marginX * 3) / 2;
    
    // 按钮背景
    UIScrollView *btnsBgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tipsLab.frame) + 20, UI_View_Width, height)];
    btnsBgView.x = 55.f;
      [self.operateView addSubview:btnsBgView];
    // 循环创建按钮
    NSInteger maxCol = 2;
    for (NSInteger i = 0; i < subjects.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"icon_choose"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"icon_choose_sel"] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:[UIColor colorWithRed:55/255.0 green:57/255.0 blue:60/255.0 alpha:1.0]forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:55/255.0 green:57/255.0 blue:60/255.0 alpha:1.0] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(chooseMark:) forControlEvents:UIControlEventTouchUpInside];
        NSInteger col = i % maxCol; //列
        btn.x  = marginX + col * (width + marginX);
        NSInteger row = i / maxCol; //行
        btn.y = top + row * btnH;//(btnH + marginX);
        btn.width = width;
        btn.height = btnH;
        [btn setTitle:self.markArray[i] forState:UIControlStateNormal];
        [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:6];
        btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btnsBgView addSubview:btn];
        btnsBgView.contentSize = CGSizeMake(self.operateView.width, btn.bottom);
    }
    
}




/**
 * 确认接口请求处理
 */
- (void)sureBtnClick:(UIButton *)sender {
    if (self.inputTextview.text.length <= 0) {
        
    }
    
    // 用户选择标签后就把值上传, 也要传给服务器下次直接请求回来
    // 按钮数字标识字符串
    NSString *numStr = [self.selectedMarkArray componentsJoinedByString:@","];
    // 按钮文字字符串
    NSString *str = [self.selectedMarkStrArray componentsJoinedByString:@","];
    
    // 测试:拼接请求参数
    NSLog(@"按钮数字标识字符串:%@", numStr);
    NSLog(@"按钮文字字符串:%@", str);
    if (self.confirmBlock) {
        self.confirmBlock(_inputTextview.text,str,self.selectedMarkStrArray);
    }
}

/**
 * 按钮多选处理
 */
- (void)chooseMark:(UIButton *)btn {
    
    btn.selected = !btn.selected;
    if (btn.isSelected) {
        [self.selectedMarkArray addObject:self.markDict[btn.titleLabel.text]]; //筛选的对应ID 如需要在闭包传递
          [self.selectedMarkStrArray addObject:btn.titleLabel.text];
    } else {
        [self.selectedMarkArray removeObject:self.markDict[btn.titleLabel.text]];  //筛选的对应ID 如需要在闭包传递
          [self.selectedMarkStrArray removeObject:btn.titleLabel.text];
    }
    
    if ( self.selectedMarkStrArray.count >0) {
        [self.confirmBtn setBackgroundImage:[UIImage imageNamed:@"btn_sub_highted"] forState:UIControlStateNormal];
        self.confirmBtn.titleEdgeInsets = UIEdgeInsetsMake(-8, 0, 0, 0);
        self.confirmBtn.height = 60.f;
    }else {
        [self.confirmBtn setBackgroundImage:[self imageWithColor:self.buttonBackColor andSize:self.confirmBtn.bounds.size] forState:UIControlStateNormal];
        self.confirmBtn.height = 48.f;
        self.confirmBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
}
- (void)bgtap {
    [[[UIApplication sharedApplication]keyWindow]endEditing:YES];
}
#pragma mark - 移除视图
- (void)removeAlertView {
    __weak __typeof(&*self)weakSelf = self;
    if ([_inputTextview isFirstResponder]) {
        [_inputTextview resignFirstResponder];
    }
    //退出
    [UIView animateWithDuration:animateTime animations:^{
        weakSelf.alertBackgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        if (weakSelf.notifiKeyboardHide) {
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
        }
        
        [self.alertBackgroundView removeFromSuperview];
        self.alertBackgroundView = nil;
        self.operateView = nil;
    }];
}




/** 将要开始编辑
 @param textView UITextView对象
 @return YES：允许编辑； NO：禁止编辑
 */
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return YES;
}
/**
 将要结束编辑
 应用场景：如果当前textView有内容，则返回YES，允许收键盘或更换textView；
 当前textView没有输入内容，返回NO，此时不能收起键盘或者更换textView
 @param textView UITextView对象
 @return YES：允许释放键盘（注销第一响应者）； NO：不允许释放键盘（始终是第一响应者）
 */
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    
  
    return YES;
}
/**
 开始编辑，即成为第一响应者，此时光标出现
 @param textView UITextView对象
 */
- (void)textViewDidBeginEditing:(UITextView *)textView {
    //开始编辑时触发，文本字段将成为first responder
}
/**
 已经结束编辑
 （即使shouldEndEditing方法返回NO或者调用了endEditing:YES，该方法仍可能调用）
 官方注释：may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
 @param textView UITextView对象
 */
- (void)textViewDidEndEditing:(UITextView *)textView {
    
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if([text isEqualToString:@"\n"]){//判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [textView resignFirstResponder];
        return NO;//这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
    
}
//字符内容改变触发的方法

- (void)textViewDidChange:(UITextView*)textView{
    
    //计算文本的高度
    //
    //    CGSize constraintSize;
    //
    //    constraintSize.width= textView.frame.size.width-16;
    //
    //    constraintSize.height=MAXFLOAT;
    //
    //    CGSize sizeFrame =[textView.textsizeWithFont:textView.font
    //
    //                              constrainedToSize:constraintSize
    //
    //                                  lineBreakMode:UILineBreakModeWordWrap];
    //
    //    //重新调整textView的高度
    //
    //    textView.frame=CGRectMake(textView.frame.origin.x,textView.frame.origin.y,textView.frame.size.width,sizeFrame.height+5);
    
//    NSLog(@"输入----------%@",textView.text);
}

#pragma mark - 监听键盘弹起，操作框动画
///键盘弹起，页面动画，监听
- (void)keyboardWillShow:(NSNotification *)notification
{
    // 键盘的frame
    CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = keyboardRect.size.height;
    
    CGFloat keyboardOriginY = SCREEN_Hight - keyboardHeight;
    CGFloat operateMaxY = SCREEN_Hight/2. + _operateView.bounds.size.height/2. + 16;
    
    __weak __typeof(&*self)weakSelf = self;
    if (operateMaxY >= keyboardOriginY) {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect rect = weakSelf.operateView.frame;
            rect.origin.y = keyboardOriginY - rect.size.height - 16;
            weakSelf.operateView.frame = rect;
        } completion:^(BOOL finished) {
            
        }];
        _notifiKeyboardHide = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
    }
    else {
        _notifiKeyboardHide = NO;
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    __weak __typeof(&*self)weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        CGRect rect = weakSelf.operateView.frame;
        rect.origin.y = (SCREEN_Hight - rect.size.height)/2.;
        weakSelf.operateView.frame = rect;
    } completion:^(BOOL finished) {
        
    }];
}


- (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title andAction:(SEL)action
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [_operateView addSubview:btn];
    
    return btn;
}


#pragma mark - 颜色转换为图片
- (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)aSize
{
    CGRect rect = CGRectMake(0.0f, 0.0f, aSize.width, aSize.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


#pragma mark - 懒加载

// 上传通过文字key取数字value发送数字
- (NSDictionary *)markDict {
    if (!_markDict) {
        NSDictionary *dict = [NSDictionary dictionary];
        dict = @{
                 @"没找到模版" : @"1" ,
                 @"操作麻烦" : @"2",
                 @"模版太少" : @"3",
                 @"不经常用" : @"4",
                 @"价格太贵" : @"5",
                 @"功能太少" : @"6",
                 @"其他问题" : @"7",
                 };
        _markDict = dict;
    }
    return _markDict;
}

- (NSMutableArray *)selectedMarkArray {
    if (!_selectedMarkArray) {
        _selectedMarkArray = [NSMutableArray array];
    }
    return _selectedMarkArray;
}

- (NSMutableArray *)selectedMarkStrArray {
    if (!_selectedMarkStrArray) {
        _selectedMarkStrArray = [NSMutableArray array];
    }
    return _selectedMarkStrArray;
}

@end
