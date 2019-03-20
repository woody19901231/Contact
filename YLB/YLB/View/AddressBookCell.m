//
//  AddressBookCell.m
//  IHKApp
//
//  Created by 郑文明 on 15/4/23.
//  Copyright (c) 2015年 www.ihk.cn. All rights reserved.
//

#import "AddressBookCell.h"

@implementation AddressBookCell


- (void)setFrendModel:(FriendInfoModel *)frendModel
{
    _frendModel = frendModel;
    self.nameLabel.text = frendModel.userName;
    if (frendModel.photoImg) {
        self.photoIV.image = frendModel.photoImg;
    }
    else{
        self.photoIV.image = [UIImage imageNamed:@"add_head_img"];
    }
    
    if (frendModel.isSelected) {
        _icon.image = [UIImage imageNamed:@"add_heck"];
    }else{
        _icon.image = [UIImage imageNamed:@"add_check_nomal"];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.photoIV.clipsToBounds = YES;
    self.photoIV.backgroundColor = [UIColor lightGrayColor];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
    CornerRadius(self.photoIV, 17);
}

@end
