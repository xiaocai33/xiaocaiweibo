//
//  WBNewFeatureController.m
//  小蔡微博
//
//  Created by 小蔡 on 2017/3/28.
//  Copyright © 2017年 xiaocai. All rights reserved.
//
// 新特性控制器
#import "WBNewFeatureController.h"
#import "UIView+UIView_Extent.h"
#import "WBMainTabBarController.h"
#define WBCount 4

@interface WBNewFeatureController () <UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation WBNewFeatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建ScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = [UIColor grayColor];
    
    
    CGFloat scrollViewW = scrollView.width;
    CGFloat scrollViewH = scrollView.hight;
    //添加图片
    for (int i = 0; i < WBCount; ++i) {
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d", i+1];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = image;
        //设置imageView在ScrollView上的位置
        imageView.width = scrollViewW;
        imageView.hight = scrollViewH;
        imageView.y = 0;
        imageView.x = i * scrollViewW;
        [scrollView addSubview:imageView];
        
        //判断是否为最后一张
        if (i == WBCount - 1){
            //设置分享开始按钮
            [self setupLastImageView:imageView];
        }
    }
    //设置scrollView的其他属性
    //设置内容尺寸
    scrollView.contentSize = CGSizeMake(WBCount * scrollViewW, 0);
    //取消弹簧
    scrollView.bounces = NO;
    //设置分页
    scrollView.pagingEnabled = YES;
    //不显示滑动条
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    //添加pageController控制器
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = WBCount;
    //设置pageControl的大小和位置(PageControl不用设置frame也能显示)
    pageControl.backgroundColor = [UIColor greenColor];
    
    pageControl.centerX = self.view.width * 0.5;
    pageControl.y = self.view.hight - 100;
    
    //设置选中按钮的颜色
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:253/255.0 green:98/255.0 blue:42/255.0 alpha:1.0];
    
    //设置其他按钮的颜色
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:189/255.0 green:189/255.0 blue:189/255.0 alpha:1.0];
    
    [self.view addSubview:pageControl];
    
    self.pageControl = pageControl;
}

//计算pageControl当前的页码
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double x = scrollView.contentOffset.x / scrollView.width;
    // 四舍五入计算出页码
    self.pageControl.currentPage = (int)(x+0.5);
}

/**
    添加分享按钮
 */
- (void)setupLastImageView:(UIImageView *)imageView{
    imageView.userInteractionEnabled = YES;
    //添加分享按钮
    UIButton *sharedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sharedBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [sharedBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [sharedBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [sharedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sharedBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [sharedBtn addTarget:self action:@selector(sharedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置按钮大小和位置
    sharedBtn.width = 300;
    sharedBtn.hight = 30;
    sharedBtn.centerX = imageView.width * 0.5;
    sharedBtn.y = imageView.hight * 0.7;
    [imageView addSubview:sharedBtn];
    
    //添加开始微博按钮
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [startBtn setTitle:@"开启微博" forState:UIControlStateNormal];
    //[startBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //设置大小和位置
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = imageView.width * 0.5;
    startBtn.y = CGRectGetMaxY(sharedBtn.frame) + 5;
    
    [imageView addSubview:startBtn];
    
}

//分享按钮点击
- (void)sharedBtnClick:(UIButton *)btn{
    btn.selected = !btn.isSelected;
}

//开启微博点击
- (void)startBtnClick{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    WBMainTabBarController *tabBarVc = [[WBMainTabBarController alloc] init];
    window.rootViewController = tabBarVc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
