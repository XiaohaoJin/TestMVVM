//
//  JJRadioPlayerViewModel.m
//  NewProject
//
//  Created by 金晓浩 on 16/5/15.
//  Copyright © 2016年 XiaoHaoJin. All rights reserved.
//

#import "JJRadioPlayerViewModel.h"

@implementation JJRadioPlayerViewModel

- (void)jj_requestRefresh
{
    [super jj_requestRefresh];
    [JJNetworkEntity getRadioPlayerTingID:_tingID success:^(NSDictionary * _Nonnull responseDict) {
        NSDictionary *dataDic = [responseDict objectForKey:@"data"];
        NSDictionary *playInfoDic = [dataDic objectForKey:@"playInfo"];
        JJRadioPlayerModel *model = [JJRadioPlayerModel yy_modelWithDictionary:playInfoDic];
        _musicUrl = model.musicUrl;
        _imageUrl = model.imgUrl;
        
        [self jj_successBlock];
    } failure:^(NSError * _Nonnull error) {
        
    } callBack:^{
        [self jj_callBackBlock];
    }];
}

@end
