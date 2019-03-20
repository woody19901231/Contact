//
//  YLBPopView.m
//  YLB
//
//  Created by goulala on 2019/3/19.
//  Copyright © 2019年 goulala. All rights reserved.
//

#import "YLBPopView.h"

@interface YLBPopView ()

@property (weak, nonatomic) IBOutlet UIView *contentView;


@end

@implementation YLBPopView



- (IBAction)clickBtn:(UIButton *)sender {
    
    switch (sender.tag) {
        case 100:
            
            if (self.againBlock) {
                self.againBlock();
            }
            
            break;
            
        case 200:
            
            [self exit];
            break;
            
        default:
            break;
    }
    
}


-(void)showView
{
    [super layoutSubviews];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
}

- (void)showDetailView:(UIView*)aView
{
    // 0.禁用整个app的点击事件
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.userInteractionEnabled = NO;
    aView.transform = CGAffineTransformMakeScale(0.05, 0.05);
    [UIView animateWithDuration:.3 animations:^{
        aView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        window.userInteractionEnabled = YES;
    }];
}

-(void)exit
{
    [UIView animateWithDuration:0.5 animations:^{
        self.contentView.transform = CGAffineTransformMakeScale(0.05, 0.05);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

-(void)layoutSubviews
{
    [self showDetailView:_contentView];
}

@end
