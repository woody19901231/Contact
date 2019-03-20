//
//  AddressBookUtil.h
//  YLB
//
//  Created by goulala on 2019/3/19.
//  Copyright © 2019年 goulala. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressBookUtil : NSObject

//获取是否授权
+ (BOOL)getContactAuthorize;

/**
 添加联系人
 */
+ (void)addContact:(CNMutableContact *)contact;

@end

NS_ASSUME_NONNULL_END
