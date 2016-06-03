//
//  JJNetworkEntity.h
//  NewProject
//
//  Created by 金晓浩 on 16/5/11.
//  Copyright © 2016年 XiaoHaoJin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JJNetworking.h"

@interface JJNetworkEntity : NSObject

+ (void)getDiscorverListWithsuccess:(JJNetworkingSuccessBlock)successBlock
        failure:(JJNetworkingFailureBlock)failureBlock
       callBack:(JJNetworkingCallBackBlock)callBackBlock;

+ (void)getRadioListWithRadioID:(NSString *)radioID
                          start:(NSInteger)start
                          limit:(NSInteger)limit
                        success:(JJNetworkingSuccessBlock)successBlock
                        failure:(JJNetworkingFailureBlock)failureBlock
                       callBack:(JJNetworkingCallBackBlock)callBackBlock;

+ (void)getRadioPlayerTingID:(NSString *)tingID
                      success:(JJNetworkingSuccessBlock)successBlock
                      failure:(JJNetworkingFailureBlock)failureBlock
                     callBack:(JJNetworkingCallBackBlock)callBackBlock;

@end
