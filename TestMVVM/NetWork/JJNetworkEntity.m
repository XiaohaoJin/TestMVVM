//
//  JJNetworkEntity.m
//  NewProject
//
//  Created by 金晓浩 on 16/5/11.
//  Copyright © 2016年 XiaoHaoJin. All rights reserved.
//

#import "JJNetworkEntity.h"

@implementation JJNetworkEntity

+ (void)getDiscorverListWithsuccess:(JJNetworkingSuccessBlock)successBlock
                            failure:(JJNetworkingFailureBlock)failureBlock
                           callBack:(JJNetworkingCallBackBlock)callBackBlock
{
    
    [JJNetworking postWithPath:ApiDiscoverList
                    parameters:nil
                       success:successBlock
                       failure:failureBlock
                      callBack:callBackBlock];

}


+ (void)getRadioListWithRadioID:(NSString *)radioID
                          start:(NSInteger)start
                          limit:(NSInteger)limit
                      success:(JJNetworkingSuccessBlock)successBlock
                      failure:(JJNetworkingFailureBlock)failureBlock
                     callBack:(JJNetworkingCallBackBlock)callBackBlock
{
    NSDictionary *params = @{ @"start": @(start),
                              @"limit": @(limit),
                              @"radioid": radioID,
                              @"client": @2 };
    [JJNetworking postWithPath:ApiDiscoverListOfList
                    parameters:params
                       success:successBlock
                       failure:failureBlock
                      callBack:callBackBlock];
}

+ (void)getRadioPlayerTingID:(NSString *)tingID
                      success:(JJNetworkingSuccessBlock)successBlock
                      failure:(JJNetworkingFailureBlock)failureBlock
                     callBack:(JJNetworkingCallBackBlock)callBackBlock
{
    if (!tingID.length) {
        return;
    }
    NSDictionary *params = @{
                             @"tingid": tingID
                             };
    [JJNetworking postWithPath:ApiRadioDetailInfo
                    parameters:params success:successBlock
                       failure:failureBlock
                      callBack:callBackBlock];
    
}

@end
