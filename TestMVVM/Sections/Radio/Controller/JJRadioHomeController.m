//
//  JJHomeController.m
//  MVVMTest
//
//  Created by 金晓浩 on 16/6/2.
//  Copyright © 2016年 XiaoHaoJin. All rights reserved.
//

#import "JJRadioHomeController.h"
#import "JJRadioHomeViewModel.h"
#import "JJAnimateCycleImageView.h"
#import "JJRadioListController.h"

@interface JJRadioHomeController ()
Strong_Property(JJRadioHomeViewModel, viewModel);
Strong_Property(JJAnimateCycleImageView, cycleImage)

@end

@implementation JJRadioHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.cycleImage];

    [self configViewModel];
}


- (void)configViewModel
{
    _viewModel = [JJRadioHomeViewModel new];
    // 读取缓存
    _viewModel.imageArray = [_viewModel jj_unarchiveFromCacheWithFileName:imageArrayFileName];
    _viewModel.dataArray = [_viewModel jj_unarchiveFromCacheWithFileName:dataArrayFileName];
    
    [_cycleImage refreshDataWithArray:_viewModel.imageArray];
    
    __weak typeof(self) weakSelf = self;
    // 请求成功的回调
    [_viewModel setJj_successBlock:^{
        [weakSelf.cycleImage refreshDataWithArray:weakSelf.viewModel.imageArray];
        
    }]; 
    
    // 请求成功或失败的回调
    [_viewModel setJj_callBackBlock:^{
        [JJLoadingView hideFromView:weakSelf.view];
    }];
    
    [JJLoadingView showFromView:self.view];
    [_viewModel jj_requestRefresh];

    
}

- (JJAnimateCycleImageView *)cycleImage
{
    if (!_cycleImage) {
        _cycleImage = [JJAnimateCycleImageView new];
        _cycleImage.frame = CGRectMake(40, 20, ScreenWidth - 80, ScreenHeight- 44-20-49 - 40);
        WS;
        [_cycleImage setTouchUpInsideBlock:^(NSUInteger idx) {
            SWS;
           JJRadioListController *listVC = [[JJRadioListController alloc] init];
            listVC.radioID = strongSelf.viewModel.dataArray[idx].radioID;
           [strongSelf.navigationController pushViewController:listVC animated:YES];            
        }];
    }
    return _cycleImage;
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
