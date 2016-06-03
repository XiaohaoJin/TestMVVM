//
//  JJPlayManager.h
//  NewProject
//
//  Created by 金晓浩 on 16/5/15.
//  Copyright © 2016年 XiaoHaoJin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface JJPlayManager : NSObject

Strong_Property(AVQueuePlayer, player)

+ (JJPlayManager *)shareManager;
- (void)playWithUrlString:(NSString *)urlString;

@end
