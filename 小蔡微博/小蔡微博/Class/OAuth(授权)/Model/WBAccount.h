//
//  WBAccount.h
//  小蔡微博
//
//  Created by 小蔡 on 2017/3/29.
//  Copyright © 2017年 xiaocai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBAccount : NSObject <NSCoding>
//字典转模型
/*
 "access_token" = "2.00V4dgsF0n_FoH16348e65afUzCTZE";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
  uid = 5388747453;
 */
/**
 *  string	用于调用access_token，接口获取授权后的access token。
 */
@property (nonatomic, copy) NSString *access_token;

/**
 *  string	expires_in的生命周期，单位是秒数。
 */
@property (nonatomic, copy) NSString *expires_in;

/**
 *  string	当前授权用户的UID。
 */
@property (nonatomic, copy) NSString *uid;

@property (nonatomic, strong) NSDate *create_time;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)accountInitWithDict:(NSDictionary *)dict;

@end
