//
//  QuestionBankViewController.m
//  HospitalBible
//
//  Created by me on 17/5/15.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "QuestionBankViewController.h"
#import "QuestionBankCell.h"
#import "SelfTestViewController.h"
#import "UIControl+BlocksKit.h"
#import "HistoryDetailViewController.h"
#import "HomeViewModel.h"
#import "SickCallViewController.h"

@interface QuestionBankViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *placeImageArr;
@property (nonatomic, strong) NSArray *collectionArr;
@property (nonatomic) BOOL isFinished;

@end

@implementation QuestionBankViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"题库";
    self.view.backgroundColor = [UIColor whiteColor];
    self.placeImageArr = @[[UIImage imageNamed:@"bitmap_01"],
                           [UIImage imageNamed:@"bitmap_02"],
                           [UIImage imageNamed:@"bitmap_03"],
                           [UIImage imageNamed:@"bitmap_04"],
                           [UIImage imageNamed:@"bitmap_05"],
                           [UIImage imageNamed:@"bitmap_06"],
                           [UIImage imageNamed:@"bitmap_07"],
                           [UIImage imageNamed:@"bitmap_08"]];
    
    [self initCollectionView];
    
    if (!self.dataSources.count) {
        [self showLoadingHUD];
        [HomeViewModel requestDiseasequestionListWithClassId:@"0" successHandler:^(id result) {
            [self hideLoadingHUD];
            self.dataSources = result;
            [self loadCollectedData];
        } errorHandler:^(NSError *error) {
            [self hideLoadingHUD];
        }];
    }else{
        [self loadCollectedData];
    }
}

- (void)loadCollectedData
{
    if (self.isCateGory) {
//        /api/chr/collection/diseasequestionlist
//        {"items": [{"id": "1"},{"id": "3"}]}
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
        [self.dataSources enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            DiseaseQuestionClass *model = (DiseaseQuestionClass *)obj;
            NSDictionary *dict = @{@"id":model.id};
            [arr addObject:dict];
        }];
        
        [self showLoadingHUD];
        NSDictionary *dict = @{@"userId":[UserInfoShareClass sharedManager].userId,@"items":arr};
        [[ERHNetWorkTool sharedManager] requestDataWithUrl:DISEASEQUEASETION_COLLECTION_LIST params:dict success:^(NSDictionary *responseObject) {
            [self hideLoadingHUD];
            self.isFinished = YES;
            self.collectionArr = responseObject[@"collectionflag"];
            [self.collectionView reloadData];
        } failure:^(NSError *error) {
            [self hideLoadingHUD];
            [self showErrorMessage:@"数据请求失败！"];
        }];
    }else{
        [self.collectionView reloadData];
    }
}

-(void)initCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    CGFloat itemW = (SCREEN_WIDTH - 40)/3.0-0.5;
    CGFloat itemH = 1.2*itemW;
    flowLayout.itemSize = CGSizeMake(itemW, itemH);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
    [self.collectionView registerNib:[UINib nibWithNibName:@"QuestionBankCell" bundle:nil] forCellWithReuseIdentifier:@"QuestionBankCell"];
    self.collectionView.backgroundColor = [UIColor colorWithHexString:@"EBFBF4"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.isCateGory) {
        if (self.isFinished) {
            return self.dataSources.count;
        }
        return 0;
    }
    return self.dataSources.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DiseaseQuestionClass *model = self.dataSources[indexPath.row];
    
    QuestionBankCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"QuestionBankCell" forIndexPath:indexPath];
    cell.titleLabel.text = model.pname;
    if (indexPath.row < self.placeImageArr.count) {
        [cell.imagePicView sd_setImageWithURL:[NSURL URLWithString:model.imgurl] placeholderImage:self.placeImageArr[indexPath.item]];
    }
    [cell.selfTestButton bk_addEventHandler:^(id  _Nonnull sender) {
        
        SickCallViewController *vc = [[SickCallViewController alloc] init];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
        
    } forControlEvents:(UIControlEventTouchUpInside)];
    
    if (self.isCateGory) {
        NSDictionary *dict = self.collectionArr[indexPath.row];
        NSString *title = [dict[@"flag"] isEqualToString:@"true"] ? @"已收藏" : @"收藏";
        [cell.historyRecordButton setTitle:title forState:UIControlStateNormal];
    }
    
    [cell.historyRecordButton bk_addEventHandler:^(id  _Nonnull sender) {
        if (self.isCateGory) {
            UIButton *btn = (UIButton *)sender;
            if ([btn.currentTitle isEqualToString:@"收藏"]) {
                [self updateCollectedState:model cell:cell indexP:indexPath.row isDelete:NO];
            }else{
                [self updateCollectedState:model cell:cell indexP:indexPath.row isDelete:YES];
            }
        }else{
            HistoryDetailViewController *historyVC = [[HistoryDetailViewController alloc] init];
            historyVC.model = model;
            [self.navigationController pushViewController:historyVC animated:NO];
        }
    } forControlEvents:(UIControlEventTouchUpInside)];
    return cell;
}
-(NSMutableArray *)dataSources{
    if (!_dataSources) {
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
}

- (void)updateCollectedState:(DiseaseQuestionClass *)model cell:(QuestionBankCell *)cell indexP:(NSInteger)index isDelete:(BOOL)isDelete
{
    //            //收藏微课堂
    //#define COLLECTION_DISCOVER  [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/collection/discover"]
    //            //取消微课堂
    //#define COLLECTION_DELETE  [NSString stringWithFormat:@"%@%@",kURL,@"/api/chr/collection/delete"]
    //            {
    //                TableID : 5;
    //                userId : 13299052676;
    //                type : 0
    //            }
    
    NSDictionary *dict = @{@"TableID":model.id,
                           @"userId":[UserInfoShareClass sharedManager].userId,
                           @"type":@"1"};
    [self showLoadingHUD];
    if (isDelete) {
         [[ERHNetWorkTool sharedManager] requestDataWithUrl:COLLECTION_DELETE params:dict success:^(NSDictionary *responseObject) {
             [self hideLoadingHUD];
//             [self showErrorMessage:@"取消收藏成功"];
             [cell.historyRecordButton setTitle:@"收藏" forState:UIControlStateNormal];
         } failure:^(NSError *error) {
             [self hideLoadingHUD];
         }];
    }else{
         [[ERHNetWorkTool sharedManager] requestDataWithUrl:COLLECTION_DISCOVER params:dict success:^(NSDictionary *responseObject) {
             [self hideLoadingHUD];
//             [self showErrorMessage:@"收藏成功！"];
             [cell.historyRecordButton setTitle:@"已收藏" forState:UIControlStateNormal];
         } failure:^(NSError *error) {
             [self hideLoadingHUD];
         }];
    }
}

@end
