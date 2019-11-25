//
//  GlobalHeader.h
//  YXItemSelect
//
//  Created by apple on 2018/6/14.
//  Copyright © 2018 apple. All rights reserved.
//

#ifndef GlobalHeader_h
#define GlobalHeader_h

#define Placeholder @"请选择"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//颜色
#define COLOR_RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define COLOR_A_RGB(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define COLOR_Hex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define COLOR_WHITE [UIColor whiteColor]
#define COLOR_BLACK [UIColor blackColor]
//字体
#define kFont(A) [UIFont systemFontOfSize:(A)]
#define kBFont(A) [UIFont boldSystemFontOfSize:A]

#define TEXT_SemiBoldFont(s) [UIFont fontWithName:@"PingFangSC-SemiBold" size:s]
#define TEXT_MediumFont(s)  [UIFont fontWithName:@"PingFangSC-Medium" size:s]
#define TEXT_RegularFont(s)  [UIFont fontWithName:@"PingFangSC-Regular" size:s]
#define TEXT_LightFont(s) [UIFont fontWithName:@"PingFangSC-Light" size:s]


#define UINibWithClass(className)  [UINib nibWithNibName:NSStringFromClass([className class]) bundle:nil]
#define StringFromClass(className) NSStringFromClass([className class])
#define ImageName(s) [UIImage imageNamed:s]

#define kVIEW_W(view)  (view.frame.size.width)
#define kVIEW_H(view)  (view.frame.size.height)
#define kVIEW_BX(view) (view.frame.origin.x + view.frame.size.width)
#define kVIEW_BY(view) (view.frame.origin.y + view.frame.size.height)
#define kVIEW_TX(view) (view.frame.origin.x)
#define kView_TY(view) (view.frame.origin.y)

#endif /* GlobalHeader_h */
