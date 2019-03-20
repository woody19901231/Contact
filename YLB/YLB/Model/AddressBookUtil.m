//
//  AddressBookUtil.m
//  YLB
//
//  Created by goulala on 2019/3/19.
//  Copyright © 2019年 goulala. All rights reserved.
//

#import "AddressBookUtil.h"

@implementation AddressBookUtil

+ (BOOL)getContactAuthorize{
    
    __block BOOL grandted = YES;
    CNContactStore *contactStore = [CNContactStore new];
    [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted == YES) {
            grandted = YES;
        }else {
            grandted = NO;
        }
    }];
    return grandted;
}

+ (void)addContact:(CNMutableContact *)contact {
    // 创建联系人请求
    CNSaveRequest *saveRequest = [[CNSaveRequest alloc] init];
    [saveRequest addContact:contact toContainerWithIdentifier:nil];
    // 写入联系人
    CNContactStore *store = [[CNContactStore alloc] init];
    [store executeSaveRequest:saveRequest error:nil];
}


@end
