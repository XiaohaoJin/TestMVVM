//
//  JJNetworking.h
//  NewProject
//
//  Created by 金晓浩 on 16/5/11.
//  Copyright © 2016年 XiaoHaoJin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

// 此宏内的参数、返回值类型为_Nonnull类型
NS_ASSUME_NONNULL_BEGIN

typedef void(^JJNetworkingSuccessBlock)(NSDictionary * responseDict);
typedef void(^JJNetworkingFailureBlock)(NSError * _Nonnull error);
typedef void(^JJNetworkingCallBackBlock)(void);


@interface JJNetworkManager : AFHTTPSessionManager

+ (instancetype)shareManager;

@end

@interface JJNetworking : NSObject

/* get */
+ (void)getWithPath:(NSString *)path
         parameters:(NSDictionary *)parameters
            success:(JJNetworkingSuccessBlock)successBlock
            failure:(JJNetworkingFailureBlock)failureBlock
           callBack:(JJNetworkingCallBackBlock)callBackBlock;

/* post */
+ (void)postWithPath:(NSString *)path
          parameters:(NSDictionary *)parameters
             success:(JJNetworkingSuccessBlock)successBlock
             failure:(JJNetworkingFailureBlock)failureBlock
            callBack:(JJNetworkingCallBackBlock)callBackBlock;

/* put */
+ (void)putWithPath:(NSString *)path
         parameters:(NSDictionary *)parameters
            success:(JJNetworkingSuccessBlock)successBlock
            failure:(JJNetworkingFailureBlock)failureBlock
           callBack:(JJNetworkingCallBackBlock)callBackBlock;

/* delete */
+ (void)deleteWithPath:(NSString *)path
            parameters:(NSDictionary *)parameters
               success:(JJNetworkingSuccessBlock)successBlock
               failure:(JJNetworkingFailureBlock)failureBlock
              callBack:(JJNetworkingCallBackBlock)callBackBlock;

/* 头像 */
+ (void)uploadImageWithPath:(NSString *)path
                 parameters:(NSDictionary *)parameters
                      image:(UIImage *)image
                       name:(NSString *)name
                  imageName:(NSString *)imageName
                  imageType:(NSString *)imageType
                    success:(JJNetworkingSuccessBlock)successBlock
                    failure:(JJNetworkingFailureBlock)failureBlock
                   callBack:(JJNetworkingCallBackBlock)callBackBlock;


NS_ASSUME_NONNULL_END

@end
