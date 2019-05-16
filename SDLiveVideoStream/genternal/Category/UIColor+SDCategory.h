//
//  UIColor+BCCategory.h
//  ShenHua
//
//  Created by suzhiqiu on 15/7/5.
//  Copyright (c) 2015年 suzhiqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SDCategory)

//通过16进制计算颜色  UIcolor colorFromHexRGB:@"bb0b15"
+ (UIColor *)sd_colorFromHexRGB:(NSString *)inColorString;

@end
