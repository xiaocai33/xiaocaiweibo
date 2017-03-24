//
//  WBTabBar.h
//  小蔡微博
//
//  Created by 小蔡 on 2017/3/21.
//  Copyright © 2017年 xiaocai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBTabBar;
@protocol WBTabBarDelegate <UITabBarDelegate>

- (void)tabBarClickAddButton:(WBTabBar *)tabBar;

@end
@interface WBTabBar : UITabBar

@property (nonatomic, weak) id<WBTabBarDelegate> delegate;

@end
