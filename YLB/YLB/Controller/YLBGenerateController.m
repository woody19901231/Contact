//
//  YLBGenerateController.m
//  YLB
//
//  Created by goulala on 2019/3/18.
//  Copyright © 2019年 goulala. All rights reserved.
//

#import "YLBGenerateController.h"

@interface YLBGenerateController ()

@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@property (nonatomic, strong) NSMutableArray *nameArr;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation YLBGenerateController

- (NSMutableArray *)nameArr
{
    if (!_nameArr) {
        _nameArr = [NSMutableArray array];
    }
    return _nameArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_backBtn setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
    
    [self.view endEditing:YES];
    
}

- (IBAction)backBtn:(UIButton *)sender {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)synthesisBtn:(UIButton *)sender {
    
    [self batchAddContact:_textField.text];
}

// **** 批量添加联系人
- (void)batchAddContact:(NSString *)batchStr {
    
    // 英文逗号隔开
    
    if (batchStr.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请输入手机号(逗号隔开)"];
        return ;
    }
    
    [SVProgressHUD show];
    
    NSArray *contactArr = [batchStr componentsSeparatedByString:@","];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [contactArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CNMutableContact *contact = [[CNMutableContact alloc] init];
            
            contact.givenName = [NSString randomNameMaxLength:3 minLength:2];
            
            [self.nameArr addObject:contact.givenName];
            
            CNLabeledValue *homePhone = [CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberiPhone value:[CNPhoneNumber phoneNumberWithStringValue:contactArr[idx]]];
            
            contact.phoneNumbers = @[homePhone];
            
            CNSaveRequest *request = [[CNSaveRequest alloc] init];
            [request addContact:contact toContainerWithIdentifier:nil];
            
            CNContactStore *store = [[CNContactStore alloc] init];
            
            [store executeSaveRequest:request error:nil];
            
            if (idx == contactArr.count - 1) {
                [SVProgressHUD showSuccessWithStatus:@"添加成功"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"REFRESHTABLE" object:nil];
            }
            
        }];
    });
    
    
}



@end
