//
//  WBAccount.m
//  小蔡微博
//
//  Created by 小蔡 on 2017/3/29.
//  Copyright © 2017年 xiaocai. All rights reserved.
//

#import "WBAccount.h"

@implementation WBAccount

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        //KVC
        [self setValue:dict[@"access_token"] forKey:@"access_token"];
        [self setValue:dict[@"expires_in"] forKey:@"expires_in"];
        [self setValue:dict[@"uid"] forKey:@"uid"];
    }
    return self;
}

+ (instancetype)accountInitWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

/**
 *  当一个对象要归档进沙盒中时，就会调用这个方法
 *  目的：在这个方法中说明这个对象的哪些属性要存进沙盒
 */
- (void)encodeWithCoder:(NSCoder *)encode{
    [encode encodeObject:self.access_token forKey:@"access_token"];
    [encode encodeObject:self.expires_in forKey:@"expires_in"];
    [encode encodeObject:self.uid forKey:@"uid"];
    [encode encodeObject:self.create_time forKey:@"create_time"];
    [encode encodeObject:self.name forKey:@"name"];
}

/**
 *  当从沙盒中解档一个对象时（从沙盒中加载一个对象时），就会调用这个方法
 *  目的：在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）
 */
- (instancetype)initWithCoder:(NSCoder *)decoder{
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.create_time = [decoder decodeObjectForKey:@"create_time"];
        self.name = [decoder decodeObjectForKey:@"name"];
    }
    return self;
}

@end
