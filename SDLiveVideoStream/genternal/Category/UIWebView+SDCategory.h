//
//  NSObject+BCCategory.h
//  ShenHua
//
//  Created by suzhiqiu on 15/7/5.
//  Copyright (c) 2015年 suzhiqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIWebView (SDCategory)

//获取网页标题
- (NSString *)sd_getTitle;

// 获取当前页面URL
- (NSString *)sd_getURL;

// 获取所有图片链接
- (NSArray *)getArrayImges;

// 获取当前页面所有点击链接
- (NSArray *)getOnClickLinks;


@end
