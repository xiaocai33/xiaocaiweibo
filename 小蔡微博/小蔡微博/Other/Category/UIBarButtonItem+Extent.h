//
//  UIBarButtonItem+Extent.h
//  小蔡微博
//
//  Created by 小蔡 on 2017/3/24.
//  Copyright © 2017年 xiaocai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extent)
+ (instancetype)initWithImage:(NSString *)image highltImage:(NSString *)highltImage target:(id)target action:(SEL)action;
@end
