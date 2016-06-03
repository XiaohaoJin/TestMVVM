//
//  JJBaseViewModel.h
//  MVVMTest
//
//  Created by 金晓浩 on 16/6/2.
//  Copyright © 2016年 XiaoHaoJin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, JJRequestType)
{
    JJRequestTypeRefresh = 0,
    JJRequestTypeLoadMore
};

@interface JJBaseViewModel : NSObject

Assign_Property(NSInteger, index)
Assign_Property(NSInteger, pageNum)
Block_Property(dispatch_block_t, jj_successBlock)
Block_Property(dispatch_block_t, jj_failureBlock)
Block_Property(dispatch_block_t, jj_callBackBlock)

- (dispatch_block_t)jj_successBlock;
- (dispatch_block_t)jj_failureBlock;
- (dispatch_block_t)jj_callBackBlock;

- (void)setJj_successBlock:(dispatch_block_t)jj_successBlock;
- (void)setJj_failureBlock:(dispatch_block_t)jj_failureBlock;
- (void)setJj_callBackBlock:(dispatch_block_t)jj_callBackBlock;

- (void)jj_requestRefresh NS_REQUIRES_SUPER;
- (void)jj_requestLoadMore NS_REQUIRES_SUPER;
- (void)jj_requestWithIndex:(NSInteger)idx
                requestType:(JJRequestType)requestType NS_REQUIRES_SUPER;

#pragma mark - 数据缓存
- (void)jj_archiverToCacheWithObject:(id)object fileName:(NSString *)fileName;
- (id)jj_unarchiveFromCacheWithFileName:(NSString *)fileName;

#pragma mark - public
- (NSString *)jj_sandboxCachePath;

@end
