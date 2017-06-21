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
    
    [cell.historyRecordButton bk_addEventHandler:^(id  _Nonnull sender) {
        HistoryDetailViewController *historyVC = [[HistoryDetailViewController alloc] init];
        historyVC.model = model;
        [self.navigationController pushViewController:historyVC animated:NO];
    
    } forControlEvents:(UIControlEventTouchUpInside)];
    return cell;
}
-(NSMutableArray *)dataSources{
    if (!_dataSources) {
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
}
@end
