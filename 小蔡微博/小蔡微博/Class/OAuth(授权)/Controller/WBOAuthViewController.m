//
//  WBOAuthViewController.m
//  小蔡微博
//
//  Created by 小蔡 on 2017/3/28.
//  Copyright © 2017年 xiaocai. All rights reserved.
//

#import "WBOAuthViewController.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "UIWindow+extent.h"
#import "WBAccount.h"
#import "WBAccountTool.h"

@interface WBOAuthViewController () <UIWebViewDelegate>

@end

@implementation WBOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
//    App Key：115371199
//    App Secret：33f247e821f410324a328dff4d5c0380
    
    // 2.用webView加载登录页面（新浪提供的）
    // 请求地址：https://api.weibo.com/oauth2/authorize
    /* 请求参数：
     client_id	true	string	申请应用时分配的AppKey。
     redirect_uri	true	string	授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。
     https://api.weibo.com/oauth2/authorize?client_id=YOUR_CLIENT_ID&response_type=code&redirect_uri=YOUR_REGISTERED_REDIRECT_URI
     */
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=115371199&response_type=code&redirect_uri=www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlStr = request.URL.absoluteString;
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length != 0) {
        
        NSInteger index = range.location + range.length;
        NSString *code = [urlStr substringFromIndex:index];
        NSLog(@"%@   %@", code, urlStr);
        [self accessTokenWithCode:code];
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessage:@"正在加载"];
    NSLog(@"开始加载...");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //[MBProgressHUD showSuccess:@"加载完成"];
    [MBProgressHUD hideHUD];
    NSLog(@"加载完成...");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    //[MBProgressHUD showError:@"加载失败"];
    NSLog(@"加载失败...");
}

  /**
   *  利用code（授权成功后的request token）换取一个accessToken
   *
   *  @param code 授权成功后的request token
   */
- (void)accessTokenWithCode:(NSString *)code{
    /*
     URL：https://api.weibo.com/oauth2/access_token
     //    App Key：115371199
     //    App Secret：33f247e821f410324a328dff4d5c0380
     请求参数：
     client_id：申请应用时分配的AppKey
     client_secret：申请应用时分配的AppSecret
     grant_type：使用authorization_code
     redirect_uri：授权成功后的回调地址
     code：授权成功后返回的code
     */
    //用AFN框架
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"115371199";
    params[@"client_secret"] = @"33f247e821f410324a328dff4d5c0380";
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = @"http://www.baidu.com";
    params[@"code"] = code;
    
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //验证成功
        [MBProgressHUD hideHUD];
       // NSLog(@"验证成功");
       // NSLog(@"%@", responseObject);
        
        // 将返回的账号字典数据 --> 模型，存进沙盒
        WBAccount *account = [WBAccount accountInitWithDict:responseObject];
        [WBAccountTool saveAccount:account];
        
        //跳转控制器
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchViewController];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //验证失败
        [MBProgressHUD hideHUD];
        NSLog(@"验证失败--%@", error);
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
