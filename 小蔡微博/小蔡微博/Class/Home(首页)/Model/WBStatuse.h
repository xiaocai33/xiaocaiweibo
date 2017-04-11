//
//  WBStatuse.h
//  小蔡微博
//
//  Created by 小蔡 on 2017/4/11.
//  Copyright © 2017年 xiaocai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBUser.h"

@interface WBStatuse : NSObject

//@property (nonatomic, copy) NSString *created_at;

/** string	字符串型的微博ID */
@property (nonatomic, copy) NSString *idstr;

//@property (nonatomic, copy) NSString *pic_urls;

/** string	微博信息内容 */
@property (nonatomic, copy) NSString *text;

/** WBUserModel	微博作者的用户信息字段 */
@property (nonatomic, strong) WBUser *user;


- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)statuseInitDict:(NSDictionary *)dict;

@end
