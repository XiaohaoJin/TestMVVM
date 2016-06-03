//
//  JJBaseViewModel.m
//  MVVMTest
//
//  Created by 金晓浩 on 16/6/2.
//  Copyright © 2016年 XiaoHaoJin. All rights reserved.
//

#import "JJBaseViewModel.h"

@implementation JJBaseViewModel

- (dispatch_block_t)jj_successBlock
{
    if (_jj_successBlock)
    {
        _jj_successBlock();
    }
    return _jj_successBlock;
}

- (dispatch_block_t)jj_failureBlock
{
    if (_jj_failureBlock)
    {
        _jj_failureBlock();
    }
    return _jj_failureBlock;
}

- (dispatch_block_t)jj_callBackBlock
{
    if (_jj_callBackBlock)
    {
        _jj_callBackBlock();
        
    }
    [JJLoadingView hide];
    return _jj_callBackBlock;
}


- (void)jj_requestRefresh
{
    
}

- (void)jj_requestLoadMore
{
    
}

- (void)jj_requestWithIndex:(NSInteger)idx
                requestType:(JJRequestType)requestType
{
        
}


#pragma mark - 数据缓存

- (void)jj_archiverToCacheWithObject:(id)object fileName:(NSString *)fileName
{
    if (!object) {
        return;
    }
    NSString *path = [[self jj_sandboxCachePath] stringByAppendingPathComponent:fileName];
    [NSKeyedArchiver archiveRootObject:object toFile:path];
}

- (id)jj_unarchiveFromCacheWithFileName:(NSString *)fileName
{
    NSString *path = [[self jj_sandboxCachePath] stringByAppendingPathComponent:fileName];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}


#pragma mark - public

- (NSString *)jj_sandboxCachePath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingPathComponent:@"/Caches/"];
}

@end
