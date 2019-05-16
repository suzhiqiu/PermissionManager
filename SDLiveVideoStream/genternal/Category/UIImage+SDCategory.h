//
//  UIImage+Category.h
//  ShenHua
//
//  Created by suzhiqiu on 15/7/10.
//  Copyright (c) 2015年 suzhiqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SDCategory)


//缩放到给定大小
-(UIImage*)sd_scaleToSize:(CGSize)size;

// 根据颜色生成一张尺寸为1*1的相同颜色图片
+ (UIImage *)sd_imageWithColor:(UIColor *)color;

@end
