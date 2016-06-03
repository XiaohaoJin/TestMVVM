//
//  JJNetworkStatusManager.m
//  TestMVVM
//
//  Created by 金晓浩 on 16/6/3.
//  Copyright © 2016年 XiaoHaoJin. All rights reserved.
//

#import "JJNetworkStatusManager.h"
#import "AFNetworkReachabilityManager.h"

@implementation JJNetworkStatusManager


+ (instancetype)sharedManager {
    
    static JJNetworkStatusManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [self new];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        // 要检测网络连接状态，必须要先调用单例的startMonitoring方法开启监听
        [manager startMonitoring];
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            switch (status) {
                case AFNetworkReachabilityStatusUnknown: {
                    // 未识别
                    NSLog(@"%@",@"未识别");
                    _networkStatus = AFNetworkReachabilityStatusUnknown;
                    break;
                }
                case AFNetworkReachabilityStatusNotReachable: {
                    // 未连接
                    NSLog(@"%@",@"未连接");
                    _networkStatus = AFNetworkReachabilityStatusNotReachable;
                    break;
                }
                case AFNetworkReachabilityStatusReachableViaWWAN: {
                    // 3G
                    NSLog(@"%@",@"3G");
                    _networkStatus = AFNetworkReachabilityStatusReachableViaWWAN;
                    break;
                }
                case AFNetworkReachabilityStatusReachableViaWiFi: {
                    // WiFi
                    NSLog(@"%@",@"WiFi");
                    _networkStatus = AFNetworkReachabilityStatusReachableViaWiFi;
                    break;
                }
                default: {
                    break;
                }
            }
        }];
    }
    return self;
}

@end
