//
//  YLBMainViewController.m
//  YLB
//
//  Created by goulala on 2019/3/18.
//  Copyright © 2019年 goulala. All rights reserved.
//

#import "YLBMainViewController.h"


@interface YLBMainViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation YLBMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([AddressBookUtil getContactAuthorize]) {
        NSLog(@"授权成功!");
    }else{
        NSLog(@"授权失败!");
    }
    
    [self.view endEditing:YES];
    
}

- (IBAction)commitBtn:(UIButton *)sender {
    
   
//    if ([_textField.text isEqualToString:@""]) {
//        
//        [SVProgressHUD showInfoWithStatus:@"请输入激活码"];
//        
//        return;
//    }
    
    [self getNetwork];
    
}

- (void)getNetwork
{
    
    ContactsViewController *vc = [ContactsViewController new];
    YLBNavigationController *nav = [[YLBNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
    
    return ;
    
    NSString *URL_main = @"http://drainage.nacy.cc/api/index/index";
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"code"] = _textField.text;
    
    [SVProgressHUD show];
    
    [PPNetworkHelper POST:[NSString stringWithFormat:@"%@",URL_main] parameters:dic success:^(id responseObject) {
        
        if ([responseObject[@"code"] integerValue] == 1) {
            
            [SVProgressHUD dismiss];
            
            NSLog(@"%@", responseObject);
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [Util markIsNotFirstLog];
                ContactsViewController *vc = [ContactsViewController new];
//                YLBNavigationController *nav = [[YLBNavigationController alloc] initWithRootViewController:vc];
//                [self presentViewController:nav animated:YES completion:nil];
                [self.navigationController pushViewController:vc animated:YES];
            });
            
            
            
        }else{
            
            [SVProgressHUD showInfoWithStatus:responseObject[@"data"][@"msg"]];
            
            
        }
        
        
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showWithStatus:error.localizedDescription];
        
    }];
    
    [self.view endEditing:YES];
}



@end
