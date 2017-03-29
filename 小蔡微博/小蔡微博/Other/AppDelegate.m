//
//  AppDelegate.m
//  小蔡微博
//
//  Created by 小蔡 on 17/3/20.
//  Copyright © 2017年 xiaocai. All rights reserved.
//

#import "AppDelegate.h"
//#import "WBMainViewController.h"
#import "WBMainTabBarController.h"
#import "WBOAuthViewController.h"
#import "WBNewFeatureController.h"
#import "WBAccountTool.h"
#import "WBAccount.h"
#import "UIWindow+extent.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //创建窗口
    self.window = [[UIWindow alloc] init];
    
    //创建主控制器
    //WBMainTabBarController *mainTabBarController = [[WBMainTabBarController alloc] init];
    
    
    
    //新特性控制器
    //WBNewFeatureController *newFeatureVc = [[WBNewFeatureController alloc] init];
    
    WBAccount *account = [WBAccountTool account];
    if (account) {//以前验证登录过直接进入
        //切换控制器
        [self.window switchViewController];
    }else{
        //OAuth验证控制器
        WBOAuthViewController *OAuthVc = [[WBOAuthViewController alloc] init];
        //设置窗口的主控制器
        self.window.rootViewController = OAuthVc;
    }
    
    //显示视图
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
