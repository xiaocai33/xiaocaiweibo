//
//  UIWindow+extent.m
//  小蔡微博
//
//  Created by 小蔡 on 2017/3/28.
//  Copyright © 2017年 xiaocai. All rights reserved.
//


#import "UIWindow+extent.h"
#import "WBMainTabBarController.h"
#import "WBNewFeatureController.h"

@implementation UIWindow (extent)
- (void)switchViewController{
    
    NSString *key = @"CFBundleVersion";
    //取沙盒判断是否为第一次登陆
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    //从plist文件中获取当前的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    //判断版本号
    if ([lastVersion isEqualToString:currentVersion]) {//版本一样直接进入
        WBMainTabBarController *tabBarVc = [[WBMainTabBarController alloc] init];
        self.rootViewController = tabBarVc;
    }else{
        WBNewFeatureController *newFeatureVc = [[WBNewFeatureController alloc] init];
        self.rootViewController = newFeatureVc;
        
        //存沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];//同步
    }
}
@end
