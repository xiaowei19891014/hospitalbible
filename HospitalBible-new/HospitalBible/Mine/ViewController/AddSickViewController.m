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
#import "NSString+EAddition.h"

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
@property (nonatomic,strong) NSMutableDictionary *mutabDict;


@end

@implementation AddSickViewController

- (NSMutableDictionary *)mutabDict
{
    if (!_mutabDict) {
        _mutabDict = [[NSMutableDictionary alloc] init];
    }
    return _mutabDict;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"添加患者";
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
    
    
    [_tableview registerNib:[UINib nibWithNibName:@"UserInfoDocumentTypeCell" bundle:nil] forCellReuseIdentifier:@"UserInfoDocumentTypeCell"];
    
    [_tableview registerNib:[UINib nibWithNibName:@"UserInfoSexCell" bundle:nil] forCellReuseIdentifier:@"UserInfoSexCell"];

    if (_model) {
        _saveBtn.hidden = YES;
        _myTextView.editable = NO;
        _myTextView.text = _model.pdescribe;
        self.title = @"个人信息";
    }
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

    }else if(indexPath.row==4)
    {
        UserInfoSexCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfoSexCell"];
        [cell setSelectSexBlock:^(NSInteger tag) {
            if (tag ==0 ) {
                _personSex = @"M";
            }else{
            
                _personSex = @"F";
            }
        }];
        if (_model) {
            cell.manBtn.selected = NO;
            cell.womanBtn.selected = NO;
            
            if ([_model.sex isEqualToString:@"M"]) {
                cell.manBtn.selected =YES;
            }else{
                cell.womanBtn.selected =YES;
            }
            
        }
        cell.accessoryType =UITableViewCellAccessoryNone;
        return cell;
    }
    else {
        
        NSString *str = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
        AddSickTableViewCell *cell;
        if (self.mutabDict[str]) {
            cell = self.mutabDict[str];
        }else{
            cell = [[[NSBundle mainBundle] loadNibNamed:@"AddSickTableViewCell" owner:self options:nil] firstObject];
            cell.accessoryType =UITableViewCellAccessoryNone;
            cell.model = _dataSources[indexPath.row];
            
            if (_model) {
                cell.textfield.enabled = NO;
                if (indexPath.row == 0) {
                    cell.textfield.text = _model.pname;
                }
                if (indexPath.row == 2) {
                    cell.textfield.text = _model.idcard;
                }
                if (indexPath.row == 3) {
                    cell.textfield.text = _model.cartevital;
                }
                if (indexPath.row == 5) {
                    cell.textfield.text = _model.phoneNum;
                }
                if (indexPath.row == 6) {
                    cell.textfield.text = _model.age;
                }
                if (indexPath.row == 7) {
                    cell.textfield.text = _model.height;
                }
                if (indexPath.row == 8) {
                    cell.textfield.text = _model.weight;
                }
                if (indexPath.row == 9) {
                    cell.textfield.text = _model.address;
                }
            }
            
            self.mutabDict[str] =cell;
        }
        
        if (indexPath.row == 5) {
            cell.textfield.keyboardType = UIKeyboardTypePhonePad;
        }else if (indexPath.row == 6 || indexPath.row == 7 || indexPath.row == 8) {
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
    
//    AddSickTableViewCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    AddSickTableViewCell *cell = self.mutabDict[@"0"];
    NSString *str = cell.textfield.text;
//    AddSickTableViewCell *cell1 = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    AddSickTableViewCell *cell1 = self.mutabDict[@"2"];
    NSString *str1 = cell1.textfield.text;
    
//    AddSickTableViewCell *cell7 = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    AddSickTableViewCell *cell7 = self.mutabDict[@"3"];
    NSString *str7 = cell7.textfield.text;
    
//    AddSickTableViewCell *cell2 = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    AddSickTableViewCell *cell2 = self.mutabDict[@"5"];
    NSString *str2 = cell2.textfield.text;
    AddSickTableViewCell *cell3 = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
    NSString *str3 = cell3.textfield.text;
    AddSickTableViewCell *cell4 = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0]];
    NSString *str4 = cell4.textfield.text;
    
    AddSickTableViewCell *cell5 = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:8 inSection:0]];
    NSString *str5 = cell5.textfield.text;
    AddSickTableViewCell *cell6 = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:9 inSection:0]];
    NSString *str6 = cell6.textfield.text;

    if (_personSex.length == 0) {
        [self showErrorMessage:@"请选择性别"];
        return;
    }
    if(str.length == 0)
    {
        [self showErrorMessage:@"请输入姓名"];
        return;
    }
    
    if (str7.length == 0) {
        [self showErrorMessage:@"请输入就诊卡号"];
        return;
    }
    
    
//    {"pname": "哥哥12",
//        "email": "eeee",
//        "address": "四川省成都市武侯区武科西四路中华锦绣二期",
//        "regdate": "2017-02-13 ",
//        "idtype": "122",
//        "IDCard": "6410316556456",
//        "imgurl": "/2017-05-24/thumb_59250d86ce8aa.jpg",
//        "height": "115.3",
//        "qQNum":"111",
//        "weChat":"110",
//        "weight": "175.36",
//        "sex": "M",
//        "birthday": "1920-04-21",
//        "userId": "15000410210",
//        "pdescribe": "我有病了",
//        "cartevital": "258478444",
//        "phoneNum":"13809155658"
//    }
    NSDictionary *params = @{
                             @"pname":NOTNIL(str),
                             @"email":@"",
                             @"address":NOTNIL(str6),
                             @"regdate":@"",
                             @"idtype":@"0",
                             @"IDCard":NOTNIL(str1),
                             @"imgurl":@"",
                             @"height":NOTNIL(str4),
                             @"qQNum":@"",
                             @"weChat":@"",
                             @"weight":NOTNIL(str5),
                             @"sex":NOTNIL(_personSex),
                             @"birthday": [NSString isValidID:str1]? [str1 substringWithRange:NSMakeRange(6, 8)] : @"",
                             @"userId":[UserInfoShareClass sharedManager].userId,
                             @"pdescribe":NOTNIL(self.myTextView.text),
                             @"phoneNum":NOTNIL(str2),
                             @"age":NOTNIL(str3),
                             @"cartevital":NOTNIL(str7)
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
