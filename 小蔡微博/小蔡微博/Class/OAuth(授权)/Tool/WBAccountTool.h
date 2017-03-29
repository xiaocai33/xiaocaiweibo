//
//  WBAccountTool.h
//  小蔡微博
//
//  Created by 小蔡 on 2017/3/29.
//  Copyright © 2017年 xiaocai. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WBAccount;
@interface WBAccountTool : NSObject

/**
 *  存储
 */
+ (void)saveAccount:(WBAccount *)account;

/**
 *  取模型
 */
+ (WBAccount *)account;

@end
