//
//  ContactsViewController.m
//  WeChat
//
//  Created by zhengwenming on 16/6/5.
//  Copyright © 2016年 zhengwenming. All rights reserved.
//

#import "ContactsViewController.h"


@interface ContactsViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *friendTableView;
@property (nonatomic, strong) UILabel *footerLabel;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray <NSMutableArray *>*sortArray;
@property (nonatomic, strong) NSMutableArray *lettersArray;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) YLBBottomView *bottomView;
@property (nonatomic, strong) FriendInfoModel *model;
@property (nonatomic, strong) NSMutableArray *selectArray;
@end

@implementation ContactsViewController

- (NSMutableArray *)selectArray
{
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}

- (NSMutableArray *)lettersArray
{
    if (!_lettersArray) {
        _lettersArray = [NSMutableArray array];
    }
    return _lettersArray;
}

- (NSMutableArray<NSMutableArray *> *)sortArray
{
    if (!_sortArray) {
        _sortArray = [NSMutableArray array];
    }
    return _sortArray;
}

-(UITableView *)friendTableView{
    if (_friendTableView==nil) {
        _friendTableView = [UITableView new];
        _friendTableView.delegate = self;
        _friendTableView.dataSource = self;
        _friendTableView.rowHeight = 55.f;
        _friendTableView.backgroundColor = HXGlobalBg;
        [_friendTableView registerNib:[UINib nibWithNibName:NSStringFromClass([AddressBookCell class]) bundle:nil] forCellReuseIdentifier:@"AddressBookCell"];
        //设置右边索引index的字体颜色和背景颜色
        _friendTableView.sectionIndexColor = UIColorFromRGB(0x7f7f7f);
        _friendTableView.separatorColor = HXGlobalBg;
        _friendTableView.sectionIndexBackgroundColor = [UIColor clearColor];
    }
    return _friendTableView;
}

-(UILabel *)footerLabel{
    if (_footerLabel==nil) {
        _footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        _footerLabel.textAlignment = NSTextAlignmentCenter;
        _footerLabel.textColor = [UIColor grayColor];
        _footerLabel.backgroundColor = [UIColor whiteColor];
        _footerLabel.font = [UIFont systemFontOfSize:17.f];
    }
    return _footerLabel;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"通讯录";
    
    _dataArray = [[NSMutableArray alloc]init];
    
    [self setNav];
    
    
    
    [self.view addSubview:self.friendTableView];
    
    [self.friendTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    self.friendTableView.tableFooterView = self.footerLabel;
    self.definesPresentationContext = YES;
    
    [self requestContactAuthorAfterSystemVersion9];
    
    [self setBottomView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTable) name:@"REFRESHTABLE" object:nil];
    
}

- (void)reloadTable{
    
    [self openContact];
    
}


- (void)setNav
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"add_navi_bar"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIButton *leftbutton=[[UIButton alloc]initWithFrame:CGRectMake(15, 0, 20, 44)];
    [leftbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftbutton setImage:[UIImage imageNamed:@"add_add"] forState:UIControlStateNormal];
    leftbutton.titleLabel.font = [UIFont systemFontOfSize:14];
    [leftbutton addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    leftbutton.tag = 100;
    [self.navigationController.navigationBar addSubview:leftbutton];
    
    
    UIButton *rightbutton=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 35 - 15, 0, 35, 44)];
    [rightbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightbutton.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightbutton setTitle:@"编辑" forState:UIControlStateNormal];
    [rightbutton setTitle:@"完成" forState:UIControlStateSelected];
    rightbutton.tag = 200;
    [rightbutton addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:rightbutton];
    
    self.rightBtn = rightbutton;
}

- (void)setBottomView
{
    self.bottomView = [YLBBottomView new];
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"YLBBottomView" owner:nil options:nil];
    self.bottomView = [array lastObject];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-ButtomHeight);
        make.height.mas_equalTo(55);
    }];
    self.bottomView.hidden = YES;
    
    
    WeakSelf(self);
    
    self.bottomView.allSelectBtn.selected = NO;
    
    //全选
    self.bottomView.allSelectBlock = ^{
        
        [weakself.dataArray enumerateObjectsUsingBlock:^(FriendInfoModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (weakself.bottomView.allSelectBtn.selected) {
                obj.isSelected = NO;
            }else{
                obj.isSelected = YES;
            }
            
        }];
        
        [BMChineseSort sortAndGroup:weakself.dataArray key:@"userName" finish:^(bool isSuccess, NSMutableArray *unGroupedArr, NSMutableArray *sectionTitleArr, NSMutableArray<NSMutableArray *> *sortedObjArr) {
            if (isSuccess) {
           
                weakself.lettersArray = sectionTitleArr;
                weakself.sortArray = sortedObjArr;
                
                [weakself.friendTableView reloadData];
                
            }
        }];
        
        
        
        weakself.bottomView.allSelectBtn.selected = !weakself.bottomView.allSelectBtn.selected;
        
    };
    
    
    //删除
    self.bottomView.deleteBlock = ^{
        
        BOOL isData = NO;
        
        for (int i = 0; i < weakself.sortArray.count; i++) {
            
            for (int k = 0; k < weakself.sortArray[i].count; k++) {
                
                if ([weakself.sortArray[i][k] isKindOfClass:[FriendInfoModel class]]) {
                  FriendInfoModel *model = (FriendInfoModel *)weakself.sortArray[i][k];
                    if (model.isSelected) {
                        NSLog(@"%@", model.identifiers);
                        [weakself.selectArray addObject:model.identifiers];
                        isData = YES;
                    }
                }
                
            }
        }
        
        if (!isData) {
            [SVProgressHUD showWithStatus:@"请选择联系人"];
            return ;
        }
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"确定要删除%ld位联系人？\n注意：这些联系人将从通讯录中完全删除。", weakself.selectArray.count] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cancelAlert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        UIAlertAction *deleteAlert = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [SVProgressHUD show];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [weakself deleteData];
                
            });
        }];
        
        [alertController addAction:cancelAlert];
        [alertController addAction:deleteAlert];
    
        [weakself presentViewController:alertController animated:YES completion:nil];
        
        
    };
}

- (void)deleteData
{
    
    [self.selectArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CNContactStore * store = [[CNContactStore alloc]init];
        
        NSPredicate *predicate = [CNContact predicateForContactsWithIdentifiers:@[obj]];
        
        NSArray * contacts = [store unifiedContactsMatchingPredicate:predicate keysToFetch:@[CNContactGivenNameKey] error:nil];
        
        CNMutableContact *contact1 = [[contacts objectAtIndex:0] mutableCopy];
        
        
        CNSaveRequest * saveRequest = [[CNSaveRequest alloc]init];
        
        [saveRequest deleteContact:contact1];
        
        [store executeSaveRequest:saveRequest error:nil];
        if (idx == self.selectArray.count - 1) {
            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
            [self openContact];
        }
    }];
    
}

- (void)clickBtn:(UIButton *)sender
{
    if (sender.tag == 100) {
        
        YLBGenerateController *vc = [YLBGenerateController new];
        YLBNavigationController *nav = [[YLBNavigationController alloc] initWithRootViewController:vc];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
        
    }else if (sender.tag == 200){
            
        self.bottomView.hidden = sender.selected;
        self.friendTableView.contentInset = sender.selected ? UIEdgeInsetsZero : UIEdgeInsetsMake(0, 0, 55, 0);
        
        sender.selected = !sender.selected;
            
        [self.friendTableView reloadData];
        
    }
}

//请求通讯录权限
#pragma mark 请求通讯录权限
- (void)requestContactAuthorAfterSystemVersion9{

    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (status != CNAuthorizationStatusAuthorized)
    {
        [self showAlertViewAboutNotAuthorAccessContact];
        return;
    } else { //已经授权
        //有通讯录权限-- 进行下一步操作
        [self openContact];
    }
    
}

//有通讯录权限-- 进行下一步操作
- (void)openContact{
    
    [self.dataArray removeAllObjects];
    [self.selectArray removeAllObjects];
    
    WeakSelf(self);
    
    // 获取指定的字段,并不是要获取所有字段，需要指定具体的字段
    NSArray *fetchKeys = @[[CNContactFormatter descriptorForRequiredKeysForStyle:CNContactFormatterStyleFullName],CNContactPhoneNumbersKey,CNContactThumbnailImageDataKey,CNContactOrganizationNameKey];
    CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:fetchKeys];
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    
    [contactStore enumerateContactsWithFetchRequest:fetchRequest error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        
        NSString *name = [CNContactFormatter stringFromContact:contact style:CNContactFormatterStyleFullName];
        UIImage *image = [UIImage imageWithData:contact.thumbnailImageData];
        
        FriendInfoModel *model = [FriendInfoModel new];
        model.userName = name;
        model.photoImg = image;
        model.identifiers = contact.identifier;
        [weakself.dataArray addObject:model];
        NSLog(@"---++:%@", model.identifiers);
        
    }];
    
    self.footerLabel.text = [NSString stringWithFormat:@"%lu位联系人",(unsigned long)weakself.dataArray.count];
    
    [BMChineseSortSetting share].specialCharPositionIsFront = NO;
    
    [BMChineseSort sortAndGroup:self.dataArray key:@"userName" finish:^(bool isSuccess, NSMutableArray *unGroupedArr, NSMutableArray *sectionTitleArr, NSMutableArray<NSMutableArray *> *sortedObjArr) {
        if (isSuccess) {
            // 第一个字母是否为#
            self.lettersArray = sectionTitleArr;
            self.sortArray = sortedObjArr;
            
            [self.friendTableView reloadData];
            
        }
    }];
    
}


//提示没有通讯录权限
- (void)showAlertViewAboutNotAuthorAccessContact{
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"请授权通讯录权限"
                                          message:@"请在iPhone的\"设置-隐私-通讯录\"选项中,允许花解解访问你的通讯录"
                                          preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:OKAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark
#pragma mark tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.lettersArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.sortArray[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddressBookCell" forIndexPath:indexPath];
    
    cell.frendModel = self.sortArray[indexPath.section][indexPath.row];
    
    cell.icon.hidden = !self.rightBtn.selected;
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 15)];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    NSString *letterString =  self.lettersArray[section];
    UILabel *letterLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, headerView.frame.origin.y, headerView.frame.size.width-15, headerView.frame.size.height)];
    letterLabel.textColor = [UIColor grayColor];
    letterLabel.font = [UIFont systemFontOfSize:10.f];
    letterLabel.text =letterString;
    [headerView addSubview:letterLabel];
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView==self.friendTableView) {
        return 15.0;
    }
    return CGFLOAT_MIN;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.lettersArray objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.lettersArray;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddressBookCell" forIndexPath:indexPath];
    FriendInfoModel *model = self.sortArray[indexPath.section][indexPath.row];
    
    if (self.rightBtn.selected == YES) {
        
        cell.icon.image = [UIImage imageNamed:@"add_heck"];
        
        if (model.isSelected) {
            
            model.indexPath = [NSString stringWithFormat:@"%ld", indexPath.row];
            
        }else{
            
        }
        
        
        model.isSelected = !model.isSelected;
        
        [self.friendTableView reloadData];
    }
    
    
}

@end
