//
//  UIBarButtonItem+Extent.m
//  小蔡微博
//
//  Created by 小蔡 on 2017/3/24.
//  Copyright © 2017年 xiaocai. All rights reserved.
//

#import "UIBarButtonItem+Extent.h"
#import "UIView+UIView_Extent.h"

@implementation UIBarButtonItem (Extent)
+ (instancetype)initWithImage:(NSString *)image highltImage:(NSString *)highltImage target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //设置按钮图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    //设置选中时图片
    [btn setBackgroundImage:[UIImage imageNamed:highltImage] forState:UIControlStateHighlighted];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    btn.size = btn.currentBackgroundImage.size;
    //自定义控件创建UIBarButtonItem
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
