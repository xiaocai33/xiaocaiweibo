//
//  UIWindow+extent.m
//  小蔡微博
//
//  Created by 小蔡 on 2017/3/28.
//  Copyright © 2017年 xiaocai. All rights reserved.
//


#import "UIWindow+extent.h"
#import "WBMainTabBarController.h"

@implementation UIWindow (extent)
- (void)switchViewController{
    WBMainTabBarController *tabBarVc = [[WBMainTabBarController alloc] init];
    self.rootViewController = tabBarVc;
}
@end
