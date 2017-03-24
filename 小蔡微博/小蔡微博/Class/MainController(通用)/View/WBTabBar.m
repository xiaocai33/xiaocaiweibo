//
//  WBTabBar.m
//  小蔡微博
//
//  Created by 小蔡 on 2017/3/21.
//  Copyright © 2017年 xiaocai. All rights reserved.
//

#import "WBTabBar.h"
#import "UIView+UIView_Extent.h"

@interface WBTabBar()

@property (nonatomic, weak) UIButton *addButton;

@end


@implementation WBTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //添加加号按钮
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [addButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [addButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        [addButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [addButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        
        addButton.size = addButton.currentBackgroundImage.size;
        //addButton.width = self.width / 5;
        //addButton.hight = self.hight;
        [self addSubview:addButton];
        
        self.addButton = addButton;
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //设置加号按钮的中心点
    self.addButton.centerX = self.width * 0.5;
    self.addButton.centerY = self.hight * 0.5;
    //self.addButton.width = self.width / 5;
    //self.addButton.hight = self.hight;
    //所有按钮的宽度
    CGFloat btnWidth = self.width / 5;
    
    //按钮索引
    CGFloat index = 0;
    
    //遍历其中所有的子控件
    for (UIView *childView in self.subviews) {
        
        Class class = NSClassFromString(@"UITabBarButton");
        if ([childView isKindOfClass:class]) {//判断子控件是否属于UITabBarButton类
            //设置按钮宽度
            childView.width = btnWidth;
            //计算位置
            childView.x = index * btnWidth;
            //增加索引
            index++;
            //跳过加号按钮的位置
            if (index == 2){
                index++;
            }
        }
    }
    
}

@end
