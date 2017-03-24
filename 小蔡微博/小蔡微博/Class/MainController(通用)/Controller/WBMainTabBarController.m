//
//  WBMainTabBarController.m
//  小蔡微博
//
//  Created by 小蔡 on 2017/3/21.
//  Copyright © 2017年 xiaocai. All rights reserved.
//

#import "WBMainTabBarController.h"
#import "WBMainNavigationController.h"
#import "WBTabBar.h"
#import "WBAddViewController.h"
#import "WBHomeTableViewController.h"
#import "WBMessageTableViewController.h"
#import "WBDiscoverTableViewController.h"
#import "WBMineTableViewController.h"

@interface WBMainTabBarController () <WBTabBarDelegate>

@end

@implementation WBMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //首页
    WBHomeTableViewController *homeVc = [[WBHomeTableViewController alloc] initWithStyle:UITableViewStylePlain];
    [self addTabBarWithChildVc:homeVc Title:@"首页" Image:@"tabbar_home" SelectImage:@"tabbar_home_selected"];
    
    //消息列表
    WBMessageTableViewController *messageVc = [[WBMessageTableViewController alloc] initWithStyle:UITableViewStylePlain];
    [self addTabBarWithChildVc:messageVc Title:@"消息" Image:@"tabbar_message_center" SelectImage:@"tabbar_message_center_selected"];
    
    //发现
    WBDiscoverTableViewController *discoverVc = [[WBDiscoverTableViewController alloc] initWithStyle:UITableViewStylePlain];
    [self addTabBarWithChildVc:discoverVc Title:@"发现" Image:@"tabbar_discover" SelectImage:@"tabbar_discover_selected"];
    
    //个人列表
    WBMineTableViewController *mineVc = [[WBMineTableViewController alloc] initWithStyle:UITableViewStylePlain];
    [self addTabBarWithChildVc:mineVc Title:@"我" Image:@"tabbar_profile" SelectImage:@"tabbar_profile_selected"];
    
    //自定义TabBar
    WBTabBar *tabBar = [[WBTabBar alloc] init];
    
    //设置代理
    tabBar.delegate = self;
    
    //KVC改变私有属性
    [self setValue:tabBar forKeyPath:@"tabBar"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 添加导航按钮
 */
- (void)addTabBarWithChildVc:(UIViewController *)childVc Title:(NSString *)title Image:(NSString *)image SelectImage:(NSString *)selectImage{
    
    //设置 TabBar 和 Nav 标题
    childVc.title = title;
    
    //设置字体样式
    NSMutableDictionary *textDict = [NSMutableDictionary dictionary];
    textDict[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    textDict[NSForegroundColorAttributeName] = [UIColor colorWithRed:(123)/255.0 green:(123)/255.0 blue:(123)/255.0 alpha:1.0];
    [childVc.tabBarItem setTitleTextAttributes:textDict forState:UIControlStateNormal];
    
    //设置选中字体样式
    NSMutableDictionary *selectTextDict = [NSMutableDictionary dictionary];
    selectTextDict[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:selectTextDict forState:UIControlStateSelected];
    
    //设置TabBar图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    
    //包装导航栏
    WBMainNavigationController *nav = [[WBMainNavigationController alloc] initWithRootViewController:childVc];
    
    //TabBar控制器添加按钮
    [self addChildViewController:nav];
    
    
}

#pragma make -- WBTabBarDelegate
- (void)tabBarClickAddButton:(WBTabBar *)tabBar{
    
    WBAddViewController *vc = [[WBAddViewController alloc] init];
    vc.view.backgroundColor = [UIColor purpleColor];
    
    //包装导航栏
    WBMainNavigationController *nav = [[WBMainNavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:nav animated:YES completion:nil];
    
}


@end
