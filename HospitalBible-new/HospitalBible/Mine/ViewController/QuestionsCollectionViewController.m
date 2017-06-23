//
//  QuestionsCollectionViewController.m
//  HospitalBible
//
//  Created by LIFEI on 2017/5/25.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import "QuestionsCollectionViewController.h"
#import "ERHErrorRequestView.h"
#import "MircoClassDetailViewController.h"
#import "MircoClasssCell.h"
#import "HistoryDetailViewController.h"
#import "QuestionBankCell.h"
@interface QuestionsCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic , strong) UITableView *tableview;
@property (nonatomic , strong) NSMutableArray *dataSources;


@end

@implementation QuestionsCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCollectionView];

    
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
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-44) collectionViewLayout:flowLayout];
    [self.collectionView registerNib:[UINib nibWithNibName:@"QuestionBankCell" bundle:nil] forCellWithReuseIdentifier:@"QuestionBankCell"];
    self.collectionView.backgroundColor = [UIColor colorWithHexString:@"EBFBF4"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QuestionBankCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"QuestionBankCell" forIndexPath:indexPath];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    HistoryDetailViewController *detailVC = [[HistoryDetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

- (NSMutableArray *)dataSources
{
    if (!_dataSources) {
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
}


@end
