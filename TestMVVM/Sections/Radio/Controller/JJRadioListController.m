//
//  JJRadioListController.m
//  TestMVVM
//
//  Created by 金晓浩 on 16/6/2.
//  Copyright © 2016年 XiaoHaoJin. All rights reserved.
//

#import "JJRadioListController.h"
#import "JJRadioListCell.h"
#import "JJRadioListViewModel.h"
#import "JJRadioPlayerController.h"


@interface JJRadioListController () <UITableViewDataSource, UITableViewDelegate>

Strong_Property(UITableView, tableView)
Strong_Property(JJRadioListViewModel, viewModel)

@end

@implementation JJRadioListController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    
    [self configViewModel];
    [self configRefresh];
}


- (void)configViewModel
{
    _viewModel = [[JJRadioListViewModel alloc] init];
    _viewModel.radioID = self.radioID;
    
    _viewModel.dataArray = [_viewModel jj_unarchiveFromCacheWithFileName:[dataArrayFileName stringByAppendingString:_radioID]];
    _viewModel.nameArray = [_viewModel jj_unarchiveFromCacheWithFileName:[nameArrayFileName stringByAppendingString:_radioID]];
    _viewModel.imageArray = [_viewModel jj_unarchiveFromCacheWithFileName:[imageArrayFileName stringByAppendingString:_radioID]];
    [self.tableView reloadData];
    
    __weak typeof(self) weakSelf = self;
    
    [_viewModel setJj_successBlock:^{
        [weakSelf.tableView reloadData];
    }];
    // 请求成功或失败的回调
    [_viewModel setJj_callBackBlock:^{
        [JJLoadingView hideFromView:weakSelf.view];
        
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
    
    [JJLoadingView showFromView:self.view];
    [_viewModel jj_requestRefresh];
    
}

- (void)configRefresh
{
    WS;
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.viewModel jj_requestRefresh];
    }];
    
    MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf.viewModel jj_requestLoadMore];
    }];
    
    self.tableView.mj_header = header;
    self.tableView.mj_footer = footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JJRadioPlayerController *playerVC = [[JJRadioPlayerController alloc] init];
    
    playerVC.tingID = _viewModel.dataArray[indexPath.row].tingid;
    [self.navigationController pushViewController:playerVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"redioListID";
    JJRadioListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[JJRadioListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell.iconImage yy_downloadImage:_viewModel.imageArray[indexPath.row] placeholderImage:nil imageResizeToSize:CGSizeMake(60, 60) roundCornerRadius:30];
    
    cell.nameLabel.text = _viewModel.nameArray[indexPath.row];
    [cell.nameLabel setColumnSpace:10];
    return cell;
}


- (UITableView *)tableView
{
    if (!_tableView)
    {
        UITableView *tableView = [[UITableView alloc]init];
        tableView.frame = self.view.frame;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 80;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView = tableView;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning
{
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
