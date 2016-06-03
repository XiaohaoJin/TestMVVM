//
//  JJRadioListViewModel.m
//  TestMVVM
//
//  Created by 金晓浩 on 16/6/2.
//  Copyright © 2016年 XiaoHaoJin. All rights reserved.
//

#import "JJRadioListViewModel.h"

@implementation JJRadioListViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.index = 1;
        self.pageNum = 9;
        
       
    }
    return self;
}

- (void)jj_requestRefresh
{
    [super jj_requestRefresh];
    self.index = 1;
    [self jj_requestWithIndex:self.index requestType:JJRequestTypeRefresh];
    
}

- (void)jj_requestLoadMore
{
    [super jj_requestLoadMore];
    [self jj_requestWithIndex:++self.index requestType:JJRequestTypeLoadMore];
    
}

- (void)jj_requestWithIndex:(NSInteger)idx requestType:(JJRequestType)requestType
{
    [super jj_requestWithIndex:idx requestType:requestType];
    
    _imageArray = [NSMutableArray array];
    _nameArray = [NSMutableArray array];
    _dataArray = [NSMutableArray array];
    
    JJNetworkingSuccessBlock success = ^(NSDictionary * _Nonnull responseDict) {
        
        NSLog(@"====  %@",responseDict);
        if (JJRequestTypeRefresh == requestType) {
            [_imageArray removeAllObjects];
            [_nameArray removeAllObjects];
            [_dataArray removeAllObjects];
        }
        
        NSArray *listArray = [[responseDict objectForKey:@"data"] objectForKey:@"list"];
        for (NSDictionary *dic in listArray)
        {
            JJRadioListModel *model = [JJRadioListModel yy_modelWithDictionary:dic];
            [_imageArray addObject:model.coverimg];
            [_nameArray addObject:model.title];
            [_dataArray addObject:model];
        }
        
        [self jj_archiverToCacheWithObject:_imageArray fileName:[imageArrayFileName stringByAppendingString:_radioID]];
        [self jj_archiverToCacheWithObject:_nameArray fileName:[nameArrayFileName stringByAppendingString:_radioID]];
        [self jj_archiverToCacheWithObject:_dataArray fileName:[dataArrayFileName stringByAppendingString:_radioID]];
        
        [self jj_successBlock];
        
    };
    
    JJNetworkingFailureBlock failure = ^(NSError * _Nonnull error) {
        
    };
    JJNetworkingCallBackBlock callBack = ^{
        [self jj_callBackBlock];
    };
    
    
    [JJNetworkEntity getRadioListWithRadioID:_radioID
                                       start:idx
                                       limit:self.pageNum
                                     success:success
                                     failure:failure
                                    callBack:callBack];
}

@end
