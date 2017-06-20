//
//  AddSickViewController.m
//  HospitalBible
//
//  Created by 边瑞康 on 2017/5/25.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "AddSickViewController.h"
#import "AddSickTableViewCell.h"
#import "UserInfoDocumentTypeCell.h"
#import "UserInfoSexCell.h"
#import "AddSickViewModel.h"

@interface AddSickFootView : UIView
@property (nonatomic, copy) void (^addSickNextBlock)();
@property (nonatomic, strong) UIButton *tradeSuccessBtn;
@end

@implementation AddSickFootView
- (instancetype)initWithFrame:(CGRect)frame;
{
    if (self = [super initWithFrame:frame]) {
        [self initializeUI];
    }
    return self;
}
- (void)initializeUI
{
    _tradeSuccessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_tradeSuccessBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_tradeSuccessBtn setBackgroundColor:[UIColor colorWithHexString:@"00A49F"]];
    [_tradeSuccessBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_tradeSuccessBtn addTarget:self action:@selector(tradeSuccessBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _tradeSuccessBtn.layer.cornerRadius = 20;
    _tradeSuccessBtn.layer.masksToBounds = YES;
    _tradeSuccessBtn.layer.borderWidth = 1;
    
    [self addSubview:_tradeSuccessBtn];
    
    _tradeSuccessBtn.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-32-[_tradeSuccessBtn(44)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tradeSuccessBtn)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-120-[_tradeSuccessBtn]-120-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tradeSuccessBtn)]];
}
- (void)tradeSuccessBtnClick
{
    if (self.addSickNextBlock) {
        self.addSickNextBlock();
    }
}

@end




@interface AddSickViewController ()<UITableViewDelegate, UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *dataSources;
@property(nonatomic,strong)NSString* personSex; //性别


@end

@implementation AddSickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"添加就诊人";
    _dataSources = getAddSickTitleAndIndexList();
    [self initTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)initTableView
{
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    tableview.delegate = self;
    tableview.dataSource = self;
    AddSickFootView *footView = [[AddSickFootView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    tableview.tableFooterView =self.footview ;
    
    _saveBtn.layer.cornerRadius = 20;
    _saveBtn.layer.masksToBounds = YES;
    _saveBtn.layer.borderWidth = 1;
    _saveBtn.layer.borderColor = [UIColor colorWithHexString:@"00A49F"].CGColor;
    
    self.myTextView.layer.borderWidth = 1;
    self.myTextView.layer.borderColor = [UIColor colorWithHexString:@"DEDEDE"].CGColor;
    self.myTextView.layer.masksToBounds = YES;
    self.myTextView.delegate = self;
    [self.view addSubview:tableview];
    self.tableview = tableview;
    
    [_tableview registerNib:[UINib nibWithNibName:@"AddSickTableViewCell" bundle:nil] forCellReuseIdentifier:@"AddSickTableViewCell"];
    
    [_tableview registerNib:[UINib nibWithNibName:@"UserInfoDocumentTypeCell" bundle:nil] forCellReuseIdentifier:@"UserInfoDocumentTypeCell"];
    
    [_tableview registerNib:[UINib nibWithNibName:@"UserInfoSexCell" bundle:nil] forCellReuseIdentifier:@"UserInfoSexCell"];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSources.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==1)
    {
        UserInfoDocumentTypeCell*cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfoDocumentTypeCell"];
        cell.accessoryType =UITableViewCellAccessoryNone;
        return cell;

    }else if(indexPath.row==3)
    {
        UserInfoSexCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfoSexCell"];
        [cell setSelectSexBlock:^(NSInteger tag) {
            if (tag ==0 ) {
                _personSex = @"M";
            }else{
            
                _personSex = @"F";
            }
        }];
        cell.accessoryType =UITableViewCellAccessoryNone;
        return cell;

        
    }
    else {
        AddSickTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddSickTableViewCell"];
        cell.accessoryType =UITableViewCellAccessoryNone;
        cell.model = _dataSources[indexPath.row];
        
        if (indexPath.row == 4) {
            cell.textfield.keyboardType = UIKeyboardTypePhonePad;
        }else if (indexPath.row == 5 || indexPath.row == 6 || indexPath.row == 7) {
            cell.textfield.keyboardType = UIKeyboardTypeDecimalPad;
        }else{
            cell.textfield.keyboardType = UIKeyboardTypeDefault;
        }
        return cell;
    }
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.view endEditing:YES];
}

-(void)textViewDidBeginEditing:(UITextView *)textView{

    if ([textView.text isEqualToString:@"请简单描述病情" ]) {
        textView.text = nil;
    }
}


- (IBAction)saveAction:(id)sender {
    [self.view endEditing:YES];
    AddSickTableViewCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSString *str = cell.textfield.text;
    AddSickTableViewCell *cell1 = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    NSString *str1 = cell1.textfield.text;
    AddSickTableViewCell *cell2 = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    NSString *str2 = cell2.textfield.text;
    AddSickTableViewCell *cell3 = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    NSString *str3 = cell3.textfield.text;
    AddSickTableViewCell *cell4 = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
    NSString *str4 = cell4.textfield.text;
    
    AddSickTableViewCell *cell5 = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0]];
    NSString *str5 = cell5.textfield.text;
    AddSickTableViewCell *cell6 = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:8 inSection:0]];
    NSString *str6 = cell6.textfield.text;

    
    NSDictionary *params = @{
                             @"pname":NOTNIL(str),
                             @"email":@"",
                             @"address":NOTNIL(str6),
                             @"regdate":@"",
                             @"idtype":@"0",
                             @"idcard":NOTNIL(str1),
                             @"imgurl":@"",
                             @"height":NOTNIL(str4),
                             @"qQNum":@"",
                             @"weChat":@"",
                             @"weight":NOTNIL(str5),
                             @"sex":NOTNIL(_personSex),
                             @"birthday":@"",
                             @"userId":[UserInfoShareClass sharedManager].userId,
                             @"pdescribe":NOTNIL(self.myTextView.text),
                             @"cartevital":@"",
                             @"IDCard":@"",

                             
                             };
    [[ERHNetWorkTool sharedManager] requestDataWithUrl:PATIENT_SAVE params:params success:^(NSDictionary *responseObject) {
        if (self.addSuccessBlock) {
            self.addSuccessBlock();
        }
        [self showErrorMessage:@"添加成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
    }];
}
@end
