//
//  WBAccountTool.m
//  小蔡微博
//
//  Created by 小蔡 on 2017/3/29.
//  Copyright © 2017年 xiaocai. All rights reserved.
//

#import "WBAccountTool.h"
#import "WBAccount.h"

#define filePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

@implementation WBAccountTool

+ (void)saveAccount:(WBAccount *)account{
    NSDate *date = [NSDate date];
    account.create_time = date;
    [NSKeyedArchiver archiveRootObject:account toFile:filePath];
}

+ (WBAccount *)account{
    //从沙盒中取数据
    WBAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    //过期的秒数
    long long expires_in = [account.expires_in longLongValue];
    
    //获得过期时间
    NSDate *expiresTime = [account.create_time dateByAddingTimeInterval:expires_in];
    
    //获得当前时间
    NSDate *nowDate = [NSDate date];
    
    // 如果expiresTime <= now，过期
    /**
     NSOrderedAscending = -1L, 升序，右边 > 左边
     NSOrderedSame, 一样
     NSOrderedDescending 降序，右边 < 左边
     */
    NSComparisonResult result = [expiresTime compare:nowDate];
    if (result != NSOrderedDescending) {
        return nil;
    }
    return account;
}

@end
