//
//  WBDropView.h
//  小蔡微博
//
//  Created by 小蔡 on 2017/3/28.
//  Copyright © 2017年 xiaocai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBDropView;
@protocol WBDropViewDelegate <NSObject>

- (void)dropdownMenuDidShow:(WBDropView *)menu;
- (void)dropdownMenuDidDismiss:(WBDropView *)menu;

@end

@interface WBDropView : UIView

@property (nonatomic, weak) id<WBDropViewDelegate> delegate;

/**
 内容控制器
 */
@property (nonatomic, strong) UIViewController *contentVc;

/**
 内容视图
 */
@property (nonatomic, strong) UIView *contentView;

/**
    显示视图
 */
- (void)showMeauFrom:(UIView *)view;

@end
