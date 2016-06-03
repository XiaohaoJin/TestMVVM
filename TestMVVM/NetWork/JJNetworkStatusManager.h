//
//  JJNetworkStatusManager.h
//  TestMVVM
//
//  Created by 金晓浩 on 16/6/3.
//  Copyright © 2016年 XiaoHaoJin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, JJNetworkStatusType) {
    JJNetworkStatusUnknown = -1,        // 未识别
    JJNetworkStatusNotReachable = 0,    // 未连接
    JJNetworkStatusWWAN,                // 3G
    JJNetworkStatusWiFi                 // WiFi
    
};

@interface JJNetworkStatusManager : NSObject

Assign_Property(NSInteger, networkStatus)

+ (instancetype)sharedManager;

@end
