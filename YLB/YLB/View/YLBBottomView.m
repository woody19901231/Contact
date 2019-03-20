//
//  YLBBottomView.m
//  YLB
//
//  Created by goulala on 2019/3/19.
//  Copyright © 2019年 goulala. All rights reserved.
//

#import "YLBBottomView.h"

@interface YLBBottomView ()

@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;


@end

@implementation YLBBottomView

- (void)awakeFromNib
{
    [super awakeFromNib];
    BorderStyle(_deleteBtn, 1, UIColorFromRGB(0x476edd).CGColor);
    CornerRadius(_deleteBtn, 4);
}

- (IBAction)clickBtn:(UIButton *)sender {
    
    if (sender.tag == 100) {
        if (self.allSelectBtn) {
            self.allSelectBlock();
        }
        if (sender.selected) {
            _icon.image = [UIImage imageNamed:@"add_heck"];
        }else{
            _icon.image = [UIImage imageNamed:@"add_check_nomal"];
        }
    }else if (sender.tag == 200){
        if (self.deleteBlock) {
            self.deleteBlock();
        }
    }
}


@end
