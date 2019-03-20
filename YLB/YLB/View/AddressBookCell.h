//
//  AddressBookCell.h
//  IHKApp
//
//  Created by 郑文明 on 15/4/23.
//  Copyright (c) 2015年 www.ihk.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendInfoModel.h"

@interface AddressBookCell : UITableViewCell

@property (nonatomic, copy) NSString *titleStr;
@property (weak, nonatomic) IBOutlet UIImageView *photoIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (nonatomic,strong) FriendInfoModel *frendModel;
@end
