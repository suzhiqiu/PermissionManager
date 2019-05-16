//
//  UIViewController+BCCategory.m
//  ShenHua
//
//  Created by suzhiqiu on 15/7/5.
//  Copyright (c) 2015年 suzhiqiu. All rights reserved.
//

#import "UIViewController+SDCategory.h"

@implementation UIViewController (SDCategory)

//设置导航标题view
-(void)sd_setNavTitleView:(UIView *)titleView
{
    self.navigationItem.titleView = titleView;
}
//设置导航左边view
-(void)sd_setNavLeftView:(UIView *)leftView
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
}
//设置导航右边边view
-(void)sd_setNavRightView:(UIView *)rightView
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
}


@end
