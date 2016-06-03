//
//  JJPlayManager.m
//  NewProject
//
//  Created by 金晓浩 on 16/5/15.
//  Copyright © 2016年 XiaoHaoJin. All rights reserved.
//

#import "JJPlayManager.h"

@implementation JJPlayManager

+ (JJPlayManager *)shareManager
{
    static JJPlayManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [self new];
    });
    return manager;
}

- (void)playWithUrlString:(NSString *)urlString
{
    _player = [[AVQueuePlayer alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    [_player play];
}

@end
