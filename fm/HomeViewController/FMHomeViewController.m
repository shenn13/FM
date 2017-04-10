//
//  FMHomeViewController.m
//  fm
//
//  Created by shen on 17/3/4.
//  Copyright © 2017年 shen. All rights reserved.
//

#import "FMHomeViewController.h"
#import "FMHomeCollectionViewCell.h"
#import "FMHomeModel.h"
#import "FMDetailViewController.h"
#import "AudioPlayerController.h"

@interface FMHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    UICollectionView *_collectView;
    NSMutableArray *_dataArr;
    
    NSInteger _numPage;
}

@end

@implementation FMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"my fm";
    
    _numPage = 1;
    
    _dataArr = [NSMutableArray array];
    
    [self getFMDataNetworkingWithPage:1 isLoadMore:NO];
    [self createRightItem];
}

-(void)createRightItem{
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 6, 80, 30)];
    [rightBtn setBackgroundColor:[UIColor redColor]];
    [rightBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
-(void)rightItemClick{
    
    if ([[AudioPlayerController audioPlayerController] isPlaying]) {
      [self presentViewController:[AudioPlayerController audioPlayerController] animated:YES completion:nil];
    }else{
        
        [self showMiddleHint:@"尚未加载。。。"];
    }
    
}


-(void)getFMDataNetworkingWithPage:(NSInteger )page  isLoadMore:(BOOL)isLoadMore{
    
    
    NSString *newStr = [NSString stringWithFormat:@"http://api2.qingting.fm/v6/media/categories/521/channels/order/bytrend/0/attr/508/curpage/%ld/pagesize/30",(long)page];
    
    [[AFNetworkingManager manager] getDataWithUrl:newStr parameters:nil successBlock:^(id data) {
        
        NSArray *arr = data[@"data"];
        
        if (!isLoadMore) {
            
            [_dataArr removeAllObjects];
            
        } if (arr.count == 0) {
            
            [_collectView.mj_footer endRefreshingWithNoMoreData];
            
        }else {
            
            for (NSDictionary *dict in arr) {
                
                FMHomeModel *homeModel = [[FMHomeModel alloc] init];
                //            homeModel = [[FMHomeModel alloc] initWithDictionary:dict error:nil];
                [homeModel setValuesForKeysWithDictionary:dict];
                [_dataArr addObject:homeModel];
                
            }
            if (!_collectView) {
                
                [self createCollectView];
            }
            
            [_collectView reloadData];
        }
        [_collectView.mj_header endRefreshing];
        [_collectView.mj_footer endRefreshing];
        
    } failureBlock:^(NSString *error) {
        NSLog(@"---------------%@",error);
    }];
}

-(void)createCollectView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight) collectionViewLayout:layout];
    _collectView.delegate = self;
    _collectView.dataSource = self;
    _collectView.alwaysBounceVertical = YES;
    
    
    _collectView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    
    _collectView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [_collectView.mj_header beginRefreshing];
    
    _collectView.backgroundColor = [UIColor whiteColor];
    [_collectView registerClass:[FMHomeCollectionViewCell class] forCellWithReuseIdentifier:@"FMHomeCell"];
    [self.view addSubview:_collectView];
    
}

#pragma 下拉刷新
- (void)refreshData{
    
    _numPage = 1;
    
    [self getFMDataNetworkingWithPage:1 isLoadMore:NO];
}

- (void)loadMoreData{
    
    _numPage ++;
    
    [self getFMDataNetworkingWithPage:_numPage isLoadMore:YES];
    
}

#pragma mark --UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FMHomeModel *homeModel = _dataArr[indexPath.row];
    FMDetailViewController *detailVC = [[FMDetailViewController alloc] init];
    detailVC.FMIDStr = homeModel.id;
    detailVC.thumbsArr = homeModel.thumbs;
    [self.navigationController pushViewController:detailVC animated:NO];
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((kScreenWidth - 60)/3, 180);
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArr.count;
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FMHomeCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"FMHomeCell" forIndexPath:indexPath];
    cell.model = _dataArr[indexPath.row];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
# pragma mark - HUD

- (void)showMiddleHint:(NSString *)hint {
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hint;
    hud.label.font = [UIFont systemFontOfSize:15];
    hud.margin = 10.f;
    [hud setY:0];
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1.0];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
