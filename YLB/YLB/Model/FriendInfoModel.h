//
//  FriendInfoModel.h
//  WeChat
//
//  Created by zhengwenming on 2017/9/21.
//  Copyright © 2017年 zhengwenming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendInfoModel : NSObject
@property (nonatomic,strong) UIImage *photoImg;

@property (nonatomic,copy) NSString *userName;

@property (nonatomic,copy) NSString *userId;

@property (nonatomic,copy) NSString *phoneNO;

@property (nonatomic,assign) NSRange range;

@property(nonatomic, assign) BOOL  isSelected;

@property (nonatomic, copy) NSString *identifiers;

@property (nonatomic, copy) NSString *indexPath;

//-(instancetype)initWithDic:(NSDictionary *)dic;

+ (instancetype)statusWithDict:(NSDictionary *)dict;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end
