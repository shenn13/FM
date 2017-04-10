//
//  FMDetailViewController.m
//  fm
//
//  Created by shen on 17/3/4.
//  Copyright © 2017年 shen. All rights reserved.
//

#import "FMDetailViewController.h"
#import "FMDetailModel.h"
#import "FMDetailTableViewCell.h"
#import "AudioPlayerController.h"

@interface FMDetailViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *_detailDataArr;
    UITableView *_tableView;
    
    NSInteger _numPage;
}

@end

@implementation FMDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _detailDataArr = [NSMutableArray array];
    _numPage = 1;
    [self getFMDetailDataNetworkingWithPage:1 isLoadMore:NO];
}


-(void)getFMDetailDataNetworkingWithPage:(NSInteger )page isLoadMore:(BOOL)isLoadMore{
    NSString *newStr = [NSString stringWithFormat:@"http://api2.qingting.fm/v6/media/channelondemands/%@/programs/order/0/curpage/%ld/pagesize/20",_FMIDStr,(long)page];
    [[AFNetworkingManager manager] getDataWithUrl:newStr parameters:nil successBlock:^(id data) {
        
        NSArray *arr = data[@"data"];
        
        if (!isLoadMore) {
            [_detailDataArr removeAllObjects];
        } if (arr.count == 0) {
            [_tableView.mj_footer endRefreshingWithNoMoreData];
            
        }else {
            for (NSDictionary *dict in arr) {
                
                FMDetailModel *detailModel = [[FMDetailModel alloc] init];
                [detailModel setValuesForKeysWithDictionary:dict];
                [_detailDataArr addObject:detailModel];
                
            }
            if (!_tableView) {
                
                [self createTableView];
            }
            
            [_tableView reloadData];
            
        }
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        
    } failureBlock:^(NSString *error) {
        
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        NSLog(@"---------------%@",error);
    }];
}


-(void)createTableView{
    
    UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,150)];
    [headImage sd_setImageWithURL:[NSURL URLWithString:[_thumbsArr valueForKey:@"medium_thumb"]] placeholderImage:nil];
    
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight ) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.tableHeaderView = headImage;
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [_tableView.mj_header beginRefreshing];
    [self.view addSubview:_tableView];
    
}
#pragma 下拉刷新
- (void)refreshData{
    
    _numPage = 1;
    
    [self getFMDetailDataNetworkingWithPage:1 isLoadMore:NO];
    
}

- (void)loadMoreData{
    
    _numPage ++;
    
    [self getFMDetailDataNetworkingWithPage:_numPage isLoadMore:YES];
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _detailDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FMDetailTableViewCell *cell = [FMDetailTableViewCell cellWithTableView:tableView];
    cell.FMDetailModel = _detailDataArr[indexPath.row];
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:[_thumbsArr valueForKey:@"medium_thumb"]] placeholderImage:nil];;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;{
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AudioPlayerController *audio = [AudioPlayerController audioPlayerController];
    
    [audio initWithArray:_detailDataArr index:indexPath.row];
    
    [self presentViewController:audio animated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
