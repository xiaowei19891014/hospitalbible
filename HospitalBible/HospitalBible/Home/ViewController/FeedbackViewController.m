//
//  FeedbackViewController.m
//  HospitalBible
//
//  Created by me on 17/5/23.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *telTextFeild;
@property (weak, nonatomic) IBOutlet UITextView *feedTextView;

@property (weak, nonatomic) IBOutlet UIButton *summitButton;


@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    self.title = @"意见反馈";
    self.telTextFeild.layer.borderWidth = 1;
    self.telTextFeild.layer.borderColor = [UIColor colorWithHexString:@"DEDEDE"].CGColor;

    
    self.feedTextView.delegate = self;
    self.feedTextView.layer.borderWidth = 1;
    self.feedTextView.layer.borderColor = [UIColor colorWithHexString:@"DEDEDE"].CGColor;
    self.feedTextView.layer.masksToBounds = YES;
    
   
    self.summitButton.layer.cornerRadius = 22;
    self.summitButton.layer.masksToBounds = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestNetWork {
    [self showLoadingHUD];
    NSDictionary *params = @{
                             @"userId":NOTNIL([UserInfoShareClass sharedManager].userId),
                             @"title":_telTextFeild.text,
                             @"content":_feedTextView.text,
                             @"imgurls":@"22222",

                             };
    [[ERHNetWorkTool sharedManager] requestDataWithUrl:FEEDBACK_SAVE params:params success:^(id responseObject) {
        
        [self hideLoadingHUD];
    } failure:^(NSError *error) {
        [self hideLoadingHUD];
    }];
}


- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"限定三百字"]) {
        textView.text = @"";
    }
    
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length<1) {
        textView.text = @"限定三百字";
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)feedAction:(UIButton *)sender {
    if (_telTextFeild.text.length == 0) {
        [EUnit showToastWithTitle:@"请输入联系方式"];
        return;
    }
    if (_feedTextView.text.length == 0 || [_feedTextView.text isEqualToString:@"限定三百字"]) {
        [EUnit showToastWithTitle:@"请输入意见反馈"];
        return;
    }
    [self requestNetWork ];
}
@end
