//
//  WBStatuse.m
//  小蔡微博
//
//  Created by 小蔡 on 2017/4/11.
//  Copyright © 2017年 xiaocai. All rights reserved.
//

#import "WBStatuse.h"
#import "MJExtension.h"

@implementation WBStatuse

//- (instancetype)initWithDict:(NSDictionary *)dict{
//    if (self = [super init]) {
//        //KVC
//        [self setValue:dict[@"idstr"] forKey:@"idstr"];
//        [self setValue:dict[@"text"] forKey:@"text"];
//        
//        //user是模型，需要再转
//        [self setValue:[WBUser userInitDict:dict[@"user"]] forKey:@"user"];
//    }
//    return self;
//}
//
//+ (instancetype)statuseInitDict:(NSDictionary *)dict{
//    return [[self alloc] initWithDict:dict];
//}

- (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"ID" : @"id"};
}

@end
