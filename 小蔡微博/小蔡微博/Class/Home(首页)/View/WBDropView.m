//
//  WBDropView.m
//  小蔡微博
//
//  Created by 小蔡 on 2017/3/28.
//  Copyright © 2017年 xiaocai. All rights reserved.
//

#import "WBDropView.h"
#import "UIView+UIView_Extent.h"

@interface WBDropView()
@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation WBDropView

- (UIImageView *)imageView{
    if (_imageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"popover_background"];
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        _imageView = imageView;
    }
    return _imageView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

//设置内容视图
- (void)setContentView:(UIView *)contentView{
    _contentView = contentView;
    
    //调整内容位置
    contentView.x = 10;
    contentView.y = 15;
    
    //根据内容信息计算视图大小
    self.imageView.width = CGRectGetMaxX(contentView.frame) + 10;
    self.imageView.hight = CGRectGetMaxY(contentView.frame) + 15;
    
    //添加内容
    [self.imageView addSubview:contentView];
    
}

//设置控制器
- (void)setContentVc:(UIViewController *)contentVc{
    _contentVc = contentVc;
    self.contentView = contentVc.view;
}

//显示视图
- (void)showMeauFrom:(UIView *)view{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    //设置视图的frame才能显示视图
    self.frame = window.bounds;
    
    //设置出现的位置
    CGRect newRect = [view convertRect:view.bounds toView:window];
    self.imageView.centerX = CGRectGetMidX(newRect);
    self.imageView.y = CGRectGetMaxY(newRect);
    
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)]) {
        [self.delegate dropdownMenuDidShow:self];
    }
}

//移除控制器
- (void)dissmiss{
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //NSLog(@"dropView touchesBegan");
    
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidDismiss:)]) {
        [self.delegate dropdownMenuDidDismiss:self];
    }
    
    [self dissmiss];
}

@end
