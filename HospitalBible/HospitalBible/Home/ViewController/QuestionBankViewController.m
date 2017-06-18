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
@interface QuestionBankViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *placeImageArr;

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
                           [UIImage imageNamed:@"bitmap_08"],];
    
    [self initCollectionView];
    
    if (!self.dataSources.count) {
        [HomeViewModel requestDiseasequestionListWithClassId:@"0" successHandler:^(id result) {
            self.dataSources = result;
            [self.collectionView reloadData];
        } errorHandler:^(NSError *error) {
            
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
    return self.dataSources.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DiseaseQuestionClass *model = self.dataSources[indexPath.row];
    QuestionBankCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"QuestionBankCell" forIndexPath:indexPath];
    cell.titleLabel.text = model.pname;
    cell.imagePicView.image = [UIImage imageNamed:self.placeImageArr[indexPath.item]];
    [cell.selfTestButton bk_addEventHandler:^(id  _Nonnull sender) {
        SelfTestViewController *testVC = [[SelfTestViewController alloc] init];
        [self.navigationController pushViewController:testVC animated:YES];
        
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
