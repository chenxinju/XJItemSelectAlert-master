//
//  XJAlertView.h
//  XJItemSelectAlert
//
//  Created by mac on 2019/11/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^XJClickBlock)(NSString * inputText,NSString *selectedMarkStr,NSArray *selesubs);

@interface XJMarkArertView : UIView

+ (XJMarkArertView *)sharedAlertView;

@property (nonatomic, strong) UIColor *buttonBackColor;

- (void)removeAlertView;

-(void )showinitWithTitle:(NSString *)title subjects:(nullable NSArray *)subjects  CompleteBlock:(void(^)(NSString * contents,NSString *selectedMarkStr,NSArray *selesubs))completeBlock;
@end

NS_ASSUME_NONNULL_END
