//
//  AppDelegate.m
//  SDLiveVideoStream
//
//  Created by suzq on 2017/7/31.
//  Copyright © 2017年 suzq. All rights reserved.
//

#import "AppDelegate.h"
#import "SDTableViewController.h"


@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    [self CreateVCPage];


    return YES;
}



-(void)CreateVCPage
{
    SDTableViewController *testVC=[[SDTableViewController alloc] init];
    UINavigationController *vc= [[UINavigationController alloc] initWithRootViewController:testVC];
    self.window.rootViewController=vc;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    //NSLog(@"applicationWillResignActive");
    
    //应用启动
    //didFinishLaunchingWithOptions
    //2018-03-02 14:54:13.483586+0800 SDLiveVideoStream[8934:4092974] applicationDidBecomeActive
    //后台
    //2018-03-02 14:54:40.296162+0800 SDLiveVideoStream[8934:4092974] applicationWillResignActive
    //2018-03-02 14:54:42.249412+0800 SDLiveVideoStream[8934:4092974] applicationDidEnterBackground
    //前台
    //2018-03-02 14:54:53.911127+0800 SDLiveVideoStream[8934:4092974] applicationWillEnterForeground
    //2018-03-02 14:54:55.648131+0800 SDLiveVideoStream[8934:4092974] applicationDidBecomeActive
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
   // NSLog(@"applicationDidEnterBackground");
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
   // NSLog(@"applicationWillEnterForeground");
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
   // NSLog(@"applicationDidBecomeActive");
}


- (void)applicationWillTerminate:(UIApplication *)application {
  //  NSLog(@"applicationWillTerminate");
}





@end
