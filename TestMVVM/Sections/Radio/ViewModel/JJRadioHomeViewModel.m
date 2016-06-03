//
//  JJRadioHomeViewModel.m
//  MVVMTest
//
//  Created by 金晓浩 on 16/6/2.
//  Copyright © 2016年 XiaoHaoJin. All rights reserved.
//

#import "JJRadioHomeViewModel.h"

@implementation JJRadioHomeViewModel

- (void)jj_requestRefresh
{
    [super jj_requestRefresh];
    
    [JJNetworkEntity getDiscorverListWithsuccess:^(NSDictionary * _Nonnull responseDict) {
        
        _dataArray = [NSMutableArray array];
        _imageArray = [NSMutableArray array];
        
        NSArray *allListArray = [[responseDict objectForKey:@"data"] objectForKey:@"alllist"];
        for (NSDictionary *dic in allListArray) {
            JJRadioHomeModel *model = [JJRadioHomeModel yy_modelWithDictionary:dic];
            [_dataArray addObject:model];
            
        }
        
        [_dataArray enumerateObjectsUsingBlock:^(JJRadioHomeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_imageArray addObject:obj.coverimg];
            
        }];
        [self jj_successBlock];
        
        
        // 缓存模型数组zzz
        [self jj_archiverToCacheWithObject:_dataArray fileName:dataArrayFileName];
        [self jj_archiverToCacheWithObject:_imageArray fileName:imageArrayFileName];
        
       
        
        
    } failure:^(NSError * _Nonnull error) {
        [self jj_failureBlock];
    } callBack:^{
        [self jj_callBackBlock];
    }];
}


@end
