//
//  WBUser.h
//  小蔡微博
//
//  Created by 小蔡 on 2017/3/30.
//  Copyright © 2017年 xiaocai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBUser : NSObject

/** string	字符串型的用户UID */
@property (nonatomic, copy) NSString *idstr;
/** string	用户昵称 */
@property (nonatomic, copy) NSString *screen_name;
/** string	友好显示名称 */
@property (nonatomic, copy) NSString *name;
/** string	用户头像地址（中图），50×50像素 */
@property (nonatomic, copy) NSString *profile_image_url;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)userInitDict:(NSDictionary *)dict;

@end
