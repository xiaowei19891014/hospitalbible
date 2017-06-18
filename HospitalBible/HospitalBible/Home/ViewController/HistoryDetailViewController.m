//
//  HistoryDetailViewController.m
//  HB
//
//  Created by LIFEI on 2017/5/24.
//  Copyright © 2017年 break. All rights reserved.
//

#import "HistoryDetailViewController.h"
#import "HistoryDetailSectionHeaderView.h"
#import "ChooseAnswersCell.h"
#import "AnswerModel.h"
#import "QuestionBankViewModel.h"
#import "HistoryDetailViewModel.h"

@interface HistoryDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *dataSources;

@end

@implementation HistoryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"历史详情";
    [self test];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:(UITableViewStyleGrouped)];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"ChooseAnswersCell" bundle:nil] forCellReuseIdentifier:@"ChooseAnswersCell"];
    //[self.tableView registerClass:[HistoryDetailSectionHeaderView class] forHeaderFooterViewReuseIdentifier:@"HistoryDetailSectionHeaderView"];
    [self.view addSubview:self.tableView];
    
//    /api/chr/result/list
//    逆流鱼
//    逆流鱼
//    {"userid":2,"classid":1}
    
    
    NSDictionary *params = @{@"userid":[UserInfoShareClass sharedManager].userId,
                         @"classid":NOTNIL(self.model.id)};
    [[ERHNetWorkTool sharedManager] requestDataWithUrl:DISEASEQUEASETION_HISTORY_LIST params:params success:^(NSDictionary *responseObject) {
        NSLog(@"---%@--",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"---%@--",error);
    }];
    
}

-(void)test{
    
    AnswerModel *model1 = [AnswerModel new];
    model1.index = @"第一题";
    model1.title = @"你好吗penguin能力风险测评旨在帮助您了解自己的风险偏好和风险承受能力风险测风险测评旨在帮助您了解自己的风险偏好和风险承受能力风险测评旨在帮助您风险测评旨在帮助您了解自己的风险偏好和风险承受能力风险测评旨在帮助您";
    model1.options = @[@"1、风险测评旨在帮助您了解自己的风险偏好和风险承受能力风险测评旨在帮助您了解自己的风险偏好和风险承受能力风险测评旨在帮助您了解自己的风险偏好和风险承受能力风险测评旨在帮助您了解自己的风险偏好和风险承受能力",
                       @"2、您提供的信息应当真实、准确、完整，我们的风险评价将基于",
                       @"3、本测试结果的有效期为12个月"];
    model1.result =@[@"1、风险测评旨在帮助您了解自己的风险偏好和风险承受能力风险测评旨在帮助您了解自己的风险偏好和风险承受能力风险测评旨在帮助您了解自己的风险偏好和风险承受能力风险测评旨在帮助您了解自己的风险偏好和风险承受能力"];
    ;
    
    AnswerModel *model2 = [AnswerModel new];
    model2.index = @"第二题";
    model2.title = @"这是第二个题帮助您了解自己的风险偏好和";
    model2.options = @[@"1、风险测评旨在帮助您了解自己的风险偏好和风险承受能力",
                       @"2、您提供的信息应当真实、准确、完整，我们的风险评价将基于",
                       @"3、本测试结果的有效期为12个月"];
    model2.result =@[@"1、风险测评旨在帮助您了解自己的风险偏好和风险承受能力"];
    
    AnswerModel *model3 = [AnswerModel new];
    model3.title = @"这是第三个题";
    model3.index = @"第三题";
    model3.options = @[@"1、风险测评旨在帮助您了解自己的风险偏好和风险承受能力",
                       @"2、您提供的信息应当真实、准确、完整，我们的风险评价将基于",
                       @"3、本测试结果的有效期为12个月"];
    model3.result =@[@"1、风险测评旨在帮助您了解自己的风险偏好和风险承受能力",
                     @"3、本测试结果的有效期为12个月"];
    
    [self.dataSources addObjectsFromArray:@[model1,model2,model3]];
}
-(NSMutableArray *)dataSources{
    if (!_dataSources) {
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSources.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    AnswerModel *model = self.dataSources[section];
    return [HistoryDetailViewModel calculateSectionViewHeightWithIndexText:model.index andTitleText:model.title];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.0;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    AnswerModel *model = self.dataSources[section];
    return model.result.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AnswerModel *model = self.dataSources[indexPath.section];
    
    NSString *str = model.result[indexPath.row];
    
    return [QuestionBankViewModel calculateAnswersRowHeightWithText:str fontSize:12.0 textWidth:SCREEN_WIDTH-60];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    AnswerModel *model = self.dataSources[section];
    static NSString *sectionID = @"HistoryDetailSectionHeaderView";
    HistoryDetailSectionHeaderView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionID];
    if (!sectionView) {
        sectionView = [[HistoryDetailSectionHeaderView alloc] initWithReuseIdentifier:sectionID];
    }
    [sectionView setIndexText:model.index titleText:model.title];
    return sectionView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 86,1)];
    line1.backgroundColor = [UIColor colorWithHexString:@"00A49F"];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-86, 0, SCREEN_WIDTH-86,1)];
    line2.backgroundColor = [UIColor colorWithHexString:@"E7E7E7"];
    [view addSubview:line1];
    [view addSubview:line2];
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChooseAnswersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChooseAnswersCell" forIndexPath:indexPath];
    AnswerModel *model = self.dataSources[indexPath.section];
    
    NSString *str = model.result[indexPath.row];
    
    cell.optionLabel.text = str;
    [cell setChooseAnswerUpperCaseWithIndex:indexPath.row];
    return cell;
    
}
@end
