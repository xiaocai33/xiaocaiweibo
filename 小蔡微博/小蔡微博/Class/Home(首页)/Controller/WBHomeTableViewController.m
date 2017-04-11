//
//  WBHomeTableViewController.m
//  小蔡微博
//
//  Created by 小蔡 on 2017/3/24.
//  Copyright © 2017年 xiaocai. All rights reserved.
//

#import "WBHomeTableViewController.h"
#import "UIBarButtonItem+Extent.h"
#import "UIView+UIView_Extent.h"
#import "WBButton.h"
#import "WBDropViewController.h"
#import "WBDropView.h"
#import "UIView+UIView_Extent.h"
#import "AFNetworking.h"
#import "WBAccountTool.h"
#import "WBAccount.h"
#import "WBUser.h"
#import "WBStatuse.h"
#import "MJExtension.h"
#import "MJRefresh.h"

@interface WBHomeTableViewController () <WBDropViewDelegate>

@property (nonatomic, strong) NSMutableArray *statuses;

@end


@implementation WBHomeTableViewController

- (NSMutableArray *)statuses{
    if (_statuses == nil) {
        _statuses = [NSMutableArray array];
    }
    return _statuses;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setupNav];
    
    //获取用户昵称
    [self getUserName];
    
    //获取用户微博数据
    //[self getStatus];
    
    //下拉刷新
    [self loadUpRefresh];
    
    //上拉刷新
    [self loadRefresh];
}
/**
 上拉刷新
 */
- (void)loadUpRefresh{
    //在footer上创建一个刷新按钮
//    UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    refreshBtn.width = 100;
//    refreshBtn.hight = 44;
//    [refreshBtn setTitle:@"加载更多的数据" forState:UIControlStateNormal];
//    [refreshBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    self.tableView.tableFooterView = refreshBtn;
//    
//    [refreshBtn addTarget:self action:@selector(refreshStatuse) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addFooterWithTarget:self action:@selector(refreshStatuse)];
    
}

- (void)refreshStatuse{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"access_token"] = [WBAccountTool account].access_token;
    /**
     *  since_id	false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
     *  max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
     */
    WBStatuse *statuse = [self.statuses lastObject];
    if (statuse) {
        
        long long int max = [statuse.idstr longLongValue];
        NSString *max_id = [NSString stringWithFormat:@"%lld", max-1];
        
        param[@"max_id"] = max_id;
    }
    
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"success--%@", responseObject);
        //字典转模型
        NSArray *array = [WBStatuse objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        [self.statuses addObjectsFromArray:array];
        
        //刷新表格
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error--%@", error);
    }];

}

/**
 下拉刷新
 */
- (void)loadRefresh{
//    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
//    
//    [refreshControl addTarget:self action:@selector(refreshNewStatuse:) forControlEvents:UIControlEventValueChanged];
//    
//    [self.tableView addSubview:refreshControl];
//    //自动刷新
//    [refreshControl beginRefreshing];
//    [self refreshNewStatuse:refreshControl];
    
    [self.tableView addHeaderWithTarget:self action:@selector(refreshNewStatuse)];
    
    //自动刷新
    [self.tableView headerBeginRefreshing];
}

- (void)refreshNewStatuse{
    /**
     *  获取当前登录用户及其所关注（授权）用户的最新微博
     *  URL: https://api.weibo.com/2/statuses/home_timeline.json
     *  支持格式: JSON
     *  HTTP请求方式: GET
     *  参数：
     *  access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
     *  since_id	false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
     *  max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
     *  count	false	int	单页返回的记录条数，最大不超过100，默认为20。
     *  page	false	int	返回结果的页码，默认为1。
     */
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"access_token"] = [WBAccountTool account].access_token;
    
    WBStatuse *statuse = [self.statuses firstObject];
    if (statuse) {
        param[@"since_id"] = statuse.idstr;
    }
    
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        //字典转模型
        NSArray *array = [WBStatuse objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        //NSLog(@"%d", array.count);
        NSRange range = NSMakeRange(0, array.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        
        [self.statuses insertObjects:array atIndexes:set];

        //刷新表格
        [self.tableView reloadData];
        
        //提醒刷新微博数目
        [self refreshNot:array.count];
        
        //移除刷新控件
        //[control endRefreshing];
        [self.tableView headerEndRefreshing];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error--%@", error);
        //[control endRefreshing];
        [self.tableView headerEndRefreshing];
    }];

}

/**
 *  刷新刚出现的微博条数
 *
 *  @param number 加载的微博数目
 */
- (void)refreshNot:(NSUInteger)number{
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.hight = 35;
    if (number == 0) {
        label.text = label.text = @"没有新的微博数据，稍后再试";
    }else{
        label.text = [NSString stringWithFormat:@"共有%lu条未读微博",(unsigned long)number];
    }
    
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    
    label.y = 64 - label.hight;
    // 将label添加到导航控制器的view中，并且是盖在导航栏下边
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    // 4.动画
    // 先利用1s的时间，让label往下移动一段距离
    CGFloat duration = 1.0;
    [UIView animateWithDuration:duration animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.hight);
    } completion:^(BOOL finished) {
        // 延迟1s后，再利用1s的时间，让label往上移动一段距离（回到一开始的状态）
        CGFloat delay = 1.0; // 延迟1s
       [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
           label.transform = CGAffineTransformIdentity;
       } completion:^(BOOL finished) {
           [label removeFromSuperview];
       }];
    }];
}


/**
 获取登录用户微博数据
 */
- (void)getStatus{
    /**
     *  获取当前登录用户及其所关注（授权）用户的最新微博
     *  URL: https://api.weibo.com/2/statuses/home_timeline.json
     *  支持格式: JSON
     *  HTTP请求方式: GET
     *  参数：
     *  access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
     *  since_id	false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
     *  max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
     *  count	false	int	单页返回的记录条数，最大不超过100，默认为20。
     *  page	false	int	返回结果的页码，默认为1。
     */
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"access_token"] = [WBAccountTool account].access_token;
    //param[@"since_id"] =
    
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"success--%@", responseObject);
        //字典转模型
        NSArray *array = [WBStatuse objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        [self.statuses addObjectsFromArray:array];
        
//        NSArray *dictArr = responseObject[@"statuses"];
//        for (NSDictionary *dict in dictArr) {
//            WBStatuse *statuse = [WBStatuse statuseInitDict:dict];
//            [self.statuses addObject:statuse];
//        }
        //刷新表格
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error--%@", error);
    }];
}

/**
 设置用户昵称
 */
- (void)getUserName{
    /*
     https://api.weibo.com/2/users/show.json
     access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
     uid	false	int64	需要查询的用户ID。
     */
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //从沙盒取数据
    WBAccount *account = [WBAccountTool account];
    
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    parm[@"access_token"] = account.access_token;
    parm[@"uid"] = account.uid;
    
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"获取成功--%@", responseObject);
        WBUser *user = [WBUser userInitDict:responseObject];
        
        UIButton *btn = (UIButton *)self.navigationItem.titleView;
        [btn setTitle:user.screen_name forState:UIControlStateNormal];
        
        //将昵称存储到沙盒中
        account.name = user.screen_name;
        [WBAccountTool saveAccount:account];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error--%@", error);
    }];
    
}

/**
    设置导航栏
 */
- (void)setupNav{
    //设置导航栏右侧的按钮
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar_pop"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClcik)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithImage:@"navigationbar_pop" highltImage:@"navigationbar_pop_highlighted" target:self action:@selector(rightBarButtonClick)];
    
    //设置导航栏左侧的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithImage:@"navigationbar_friendsearch" highltImage:@"navigationbar_friendsearch_highlighted" target:self action:@selector(leftBarButtonClick)];
    
    //设置中间按钮
    NSString *name = [WBAccountTool account].name;
    WBButton *btn = [WBButton buttonWithTitle:name?name:@"首页" upImage:@"navigationbar_arrow_up" downImage:@"navigationbar_arrow_down"];
    //按钮设置文字要用setTitle设置在那种状态下的文字显示,不能用titleLabel.text设置
    //    [btn setTitle:@"首页" forState:UIControlStateNormal];
    //    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    btn.size = CGSizeMake(50, 50);
    //    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = btn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightBarButtonClick{
    NSLog(@"rightBarButtonClick");
}

- (void)leftBarButtonClick{
    NSLog(@"leftBarButtonClick");
}

- (void)titleBtnClick:(WBButton *)btn{
    //NSLog(@"titleButtonClick");
    WBDropViewController *dropVc = [[WBDropViewController alloc] init];
    dropVc.view.width = 150;
    dropVc.view.hight = 44 * 3;
    
    
    WBDropView *dropView = [[WBDropView alloc] init];
    dropView.contentVc = dropVc;
    dropView.delegate = self;
    
    [dropView showMeauFrom:btn];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //NSLog(@"%d", self.statuses.count);
    return self.statuses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellString = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellString];
    }
    WBStatuse *statuse = self.statuses[indexPath.row];
    cell.textLabel.text = statuse.text;
    
    return cell;
}

#pragma mark - WBDropViewDelegate
- (void)dropdownMenuDidShow:(WBDropView *)menu{
    WBButton *btn = (WBButton *)self.navigationItem.titleView;
    btn.selected = YES;
}

- (void)dropdownMenuDidDismiss:(WBDropView *)menu{
    WBButton *btn = (WBButton *)self.navigationItem.titleView;
    btn.selected = NO;
}

@end
