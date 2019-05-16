//
//  BaseNavigationController.m
//  SDLiveVideoStream
//
//  Created by suzq on 2017/8/7.
//  Copyright © 2017年 suzq. All rights reserved.
//

#import "BaseNavigationController.h"


@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


/**
 *  能拦截所有push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 如果现在push的不是栈底控制器(最先push进来的那个控制器)
    if (self.viewControllers.count > 0)
        
    {
//        viewController.hidesBottomBarWhenPushed = YES;
//        
//        UIBarButtonItem *backItem = [UIBarButtonItem sd_itemWithImageName:@"navigationButtonReturn" highImageName:@"navigationButtonReturnClick" target:self action:@selector(goBack)];
//        //这里可以设置导航栏的左右按钮 统一管理方法
//        viewController.navigationItem.leftBarButtonItem = backItem;
    }
    
    // 解决ios7自带的手滑手势引发的崩溃
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    // push
    [super pushViewController:viewController animated:animated];
}


- (void)goBack
{
    [self popViewControllerAnimated:YES];
}




@end
