//
//  CLBBaseController.m
//  引流宝
//
//  Created by goulala on 2019/3/18.
//  Copyright © 2019年 goulala. All rights reserved.
//

#import "YLBBaseController.h"

@interface YLBBaseController ()

@end

@implementation YLBBaseController


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = kBaseColor;
    
}

//视图将要显示时隐藏
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

//视图将要消失时取消隐藏
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
