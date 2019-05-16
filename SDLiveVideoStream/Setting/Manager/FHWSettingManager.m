//
//  FHWSettingManager.m
//  fanhuanwang
//
//  Created by suzq on 2019/4/25.
//  Copyright © 2019 lgfz. All rights reserved.
//

#import "FHWSettingManager.h"

@implementation FHWSettingManager
    
/*跳转设置页面*/
+(void)openSettingPage{
    NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if (![[UIApplication sharedApplication] canOpenURL:url]) {
        return;
    }
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }else{
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end
