//
//  YLBMailListController.m
//  YLB
//
//  Created by goulala on 2019/3/18.
//  Copyright © 2019年 goulala. All rights reserved.
//

#import "YLBMailListController.h"

@interface YLBMailListController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YLBMailListController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"通讯录";
    
    [self setNav];
    
}

- (void)setNav
{
    
    UIButton *leftbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 20)];
    [leftbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftbutton setTitle:@"添加" forState:UIControlStateNormal];
    leftbutton.titleLabel.font = [UIFont systemFontOfSize:14];
    [leftbutton addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    leftbutton.tag = 100;
    UIBarButtonItem *leftitem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    self.navigationItem.leftBarButtonItem = leftitem;
    
    UIButton *rightbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 20)];
    [rightbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightbutton.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightbutton setTitle:@"编辑" forState:UIControlStateNormal];
    rightbutton.tag = 200;
    [rightbutton addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightitem=[[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    self.navigationItem.rightBarButtonItem = rightitem;
    
}

- (void)setTableView
{
    self.view.backgroundColor = HXGlobalBg;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kTabBarAddHeight - NavBarHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.backgroundColor = HXGlobalBg;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"GLLReceiveCouponOCCell" bundle:nil] forCellReuseIdentifier:@"GLLReceiveCouponOCCell"];
    self.tableView.contentInset = UIEdgeInsetsMake(5, 0, 0, 0);
}


- (void)clickBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case 100:
            
            break;
            
        case 200:
            
            break;
            
        default:
            break;
    }
}


@end
