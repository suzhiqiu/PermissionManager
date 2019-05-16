//
//  NSObject+BCCategory.m
//  ShenHua
//
//  Created by suzhiqiu on 15/7/5.
//  Copyright (c) 2015年 suzhiqiu. All rights reserved.
//

#import "UIWebView+SDCategory.h"

@implementation UIWebView (SDCategory)



/// 获取某个标签的结点个数
- (NSInteger)nodeCountOfTag:(NSString *)tag
{
    NSString *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('%@').length", tag];
    NSInteger len = [[self stringByEvaluatingJavaScriptFromString:jsString] integerValue];
    return len;
}
    
    
//获取网页标题
- (NSString *)sd_getTitle
{
   	return [self stringByEvaluatingJavaScriptFromString:@"document.title"];
}


// 获取当前页面URL
- (NSString *)sd_getURL
{
    return [self stringByEvaluatingJavaScriptFromString:@"document.location.href"];
}


// 获取所有图片链接
- (NSArray *)getArrayImges
{
    NSMutableArray *arrImgURL = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self nodeCountOfTag:@"img"]; i++)
    {
        NSString *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('img')[%d].src", i];
        [arrImgURL addObject:[self stringByEvaluatingJavaScriptFromString:jsString]];
    }
    return arrImgURL;
}

// 获取当前页面所有点击链接
- (NSArray *)getOnClickLinks
{
    NSMutableArray *arrOnClicks = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self nodeCountOfTag:@"a"]; i++)
    {
        NSString *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('a')[%d].getAttribute('onclick')", i];
        NSString *clickString = [self stringByEvaluatingJavaScriptFromString:jsString];
        NSLog(@"%@", clickString);
        [arrOnClicks addObject:clickString];
    }
    return arrOnClicks;
}



@end
