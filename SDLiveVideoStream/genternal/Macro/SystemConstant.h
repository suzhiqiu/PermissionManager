//
//  SystemConstant.h
//  fanhuanwang
//
//  Created by suzq on 2017/5/27.
//  Copyright © 2017年 lgfz. All rights reserved.
//

/*放置系统一些配置信息

各机型分辨率备注
 4s:320x480
 5s:320x568
 6:375x667
 6p:414x736
 
*/


#ifndef SystemConstant_h
#define SystemConstant_h



/*屏幕的宽度*/
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
/*屏幕的高度*/
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
/*状态栏的高度*/
#define STATUSBAR_HIGHT     20
/*扣除状态栏后导航栏的高度*/
#define NAVI_BAR_HIGHT      44
/*导航栏的高度*/
#define NAVBAR_HIGHT        64
/*tabbar的高度*/
#define TABBAR_HIGHT        49
/*分割线的高度*/
#define SEPLINE_HIGHT      0.5


/*系统屏幕宽度和320的比例*/
#define SCREEN_RATIO        (SCREEN_WIDTH / 320.0f)
/*系统屏幕宽度和375的比例*/
#define SCREEN_RATIO_375    (SCREEN_WIDTH / 375.0f )
/*按320的设计，进行尺寸转换*/
#define SCREEN_By320(x)     ceil(x * SCREEN_RATIO)
/*按375的设计，进行尺寸转换*/
#define SCREEN_By375(x)     ceil(x * SCREEN_RATIO_375)
/*唯一keywindow*/
#define KEYWINDOW           [UIApplication sharedApplication].keyWindow

#define BTNTAG              100

/*1px的高度 6p上面有问题*/
#define SINGLE_LINE_HIGHT           (1 / [UIScreen mainScreen].scale)

/*非系统颜色值获取*/
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
/*非系统颜色值获取*/
#define UIColorFromRGBL(rgbValue,al) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:al]



//
//{375, 812} iPhone X
//{375, 667} iPhone 8 / iPhone 7 ／ iPhone 6
//{414, 736} iPhone 8P / iPhone 7P / iPhone 6P
//{320, 568} iPhone SE / iPhone 5



#endif /* SystemConstant_h */

