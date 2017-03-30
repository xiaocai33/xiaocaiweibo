//
//  WBButton.m
//  小蔡微博
//
//  Created by 小蔡 on 2017/3/24.
//  Copyright © 2017年 xiaocai. All rights reserved.
//

#import "WBButton.h"
#import "UIView+UIView_Extent.h"

@implementation WBButton

//设置左侧显示文字,右侧显示图片的按钮
+ (instancetype)buttonWithTitle:(NSString *)title upImage:(NSString *)upImage downImage:(NSString *)downImage{
    WBButton *btn = [[WBButton alloc] init];
    //设置整个按钮的颜色
    //[btn setBackgroundColor:[UIColor greenColor]];
    
    [self setBtn:btn title:title upImage:upImage downImage:downImage];
    
    return btn;
}

+ (void)setBtn:(WBButton *)btn title:(NSString *)title upImage:(NSString *)upImage downImage:(NSString *)downImage{
    
    [btn setTitle:title forState:UIControlStateNormal];
    
    [btn setImage:[UIImage imageNamed:upImage] forState:UIControlStateNormal];
    
    [btn setImage:[UIImage imageNamed:downImage] forState:UIControlStateSelected];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    NSDictionary *dic = @{
                          NSFontAttributeName:[UIFont systemFontOfSize:17]
                          };
    //计算标题的宽度
    CGFloat titleWidth = [btn.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine attributes:dic context:nil].size.width;
    //NSLog(@"%f", titleWidth);
    //计算按钮长度
    btn.width = titleWidth + btn.currentImage.size.width;
    btn.hight = 30;
    
    //设置titleLabel部分的颜色
    //btn.titleLabel.backgroundColor = [UIColor purpleColor];
    //设置ImageView部分的颜色
    //btn.imageView.backgroundColor = [UIColor blueColor];
}

//设置titleLabel在整个按钮中的位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    NSDictionary *dic = @{
                          NSFontAttributeName:[UIFont systemFontOfSize:17]
                          };
    CGFloat titleW = [self.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine attributes:dic context:nil].size.width;
    CGFloat titleH = 30;
    return CGRectMake(titleX, titleY, titleW, titleH);
}


//设置ImageView在整个按钮中的位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = 13;
    CGFloat imageH = 7;
    CGFloat imageX = contentRect.size.width - imageW;
    CGFloat imageY = contentRect.size.height * 0.4;
    return CGRectMake(imageX, imageY, imageW, imageH);
}
@end
