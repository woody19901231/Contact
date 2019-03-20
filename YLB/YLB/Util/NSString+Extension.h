//
//  NSString+Extension.h
//  ContactTest
//
//  Created by zygl on 2019/3/19.
//  Copyright © 2019年 zygl.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extension)

/**
    生成随机汉字
    maxLength: 最大长度
    minLength: 最小长度
 */
+ (NSString *)randomNameMaxLength:(int)maxLength minLength:(int)minLength;

@end

NS_ASSUME_NONNULL_END
