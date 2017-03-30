//
//  WBUser.m
//  小蔡微博
//
//  Created by 小蔡 on 2017/3/30.
//  Copyright © 2017年 xiaocai. All rights reserved.
//

#import "WBUser.h"

@implementation WBUser

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        //KVC
        [self setValue:dict[@"idstr"] forKeyPath:@"idstr"];
        [self setValue:dict[@"screen_name"] forKeyPath:@"screen_name"];
        [self setValue:dict[@"name"] forKeyPath:@"name"];
        [self setValue:dict[@"profile_image_url"] forKeyPath:@"profile_image_url"];
    }
    return self;
}

+ (instancetype)userInitDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}



@end
