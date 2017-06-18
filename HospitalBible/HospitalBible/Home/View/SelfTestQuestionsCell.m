//
//  QuestionBankCell.m
//  HB
//
//  Created by LIFEI on 2017/5/15.
//  Copyright © 2017年 break. All rights reserved.
//

#import "SelfTestQuestionsCell.h"
#import "ChooseAnswersCell.h"
#import "QuestionBankViewModel.h"
#import "UIControl+BlocksKit.h"
@interface SelfTestQuestionsCell()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *optionList;
@end
@implementation SelfTestQuestionsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"ChooseAnswersCell" bundle:nil] forCellReuseIdentifier:@"ChooseAnswersCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] init];
}

-(void)setModel:(DiseaseQuestionModel *)mdel{
    _mdel = mdel;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-40, 44)];
    title.text = mdel.title;
    [headerView addSubview:title];
    _tableView.tableHeaderView = headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DiseaseQuestionChoiceModel *choice = _mdel.choiceList[indexPath.row];
    NSString *str = choice.fContext;
    return [QuestionBankViewModel calculateAnswersRowHeightWithText:str fontSize:12.0 textWidth:SCREEN_WIDTH-60];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _mdel.choiceList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DiseaseQuestionChoiceModel *choice = _mdel.choiceList[indexPath.row];
    ChooseAnswersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChooseAnswersCell" forIndexPath:indexPath];
    cell.optionLabel.text = choice.fContext;
    [cell setChooseAnswerUpperCaseWithIndex:indexPath.row];
    
    [cell.selectResultButton bk_addEventHandler:^(UIButton *sender) {
        //[self refreshSelectResultStateWithSelectSender:sender selectIndexPath:indexPath];
    } forControlEvents:(UIControlEventTouchUpInside)];
    return cell;
}

//-(void)refreshSelectResultStateWithSelectSender:(UIButton *)sender selectIndexPath:(NSIndexPath *)selectIndexPath{
//    if (!sender.selected) {//未选择，选中项，其他项不选
//        _model.selectedResult = getUpperCaseWithIndex(selectIndexPath.row);
//        sender.selected = !sender.selected;
//        for (int i = 0; i < _model.options.count; i++) {
//            if (i != selectIndexPath.row) {
//                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
//                ChooseAnswersCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//                cell.selectResultButton.selected = NO;
//            }
//        }
//    }
//}

@end
