//
//  JJNetworking.m
//  NewProject
//
//  Created by 金晓浩 on 16/5/11.
//  Copyright © 2016年 XiaoHaoJin. All rights reserved.
//

#import "JJNetworking.h"

@implementation JJNetworkManager

+ (instancetype)shareManager
{
    static JJNetworkManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[JJNetworkManager alloc] initWithBaseURL:[NSURL URLWithString: [self baseURL]]];
        // 设置请求超时时间
        manager.requestSerializer.timeoutInterval = 30;
        // 请求的数据类型
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        // 请求头类型
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        // 返回的数据类型
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", @"application/x-javascript", @"text/plain", @"image/gif", nil];
        
        // AFSecurityPolicy
        manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
    });
    
    return manager;
}

#pragma mark BaseURL
+ (NSString *)baseURL
{
#ifdef QA_TEST
    return HOST_TEST_DAMIAN;
#else
    return HOST_LINE_DOMAIN;
#endif
}


@end

@implementation JJNetworking

+ (void)getWithPath:(NSString *)path
         parameters:(NSString *)parameters
            success:(JJNetworkingSuccessBlock)successBlock
            failure:(JJNetworkingFailureBlock)failureBlock
           callBack:(JJNetworkingCallBackBlock)callBackBlock
{
    JJNetworkManager * manager = [JJNetworkManager shareManager];
    [manager GET:path
      parameters:parameters
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         successBlock(responseObject);
         callBackBlock();
     }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        failureBlock(error);
        callBackBlock();
    }];
    
  }

+ (void)postWithPath:(NSString *)path parameters:(NSString *)parameters success:(JJNetworkingSuccessBlock)successBlock failure:(JJNetworkingFailureBlock)failureBlock callBack:(JJNetworkingCallBackBlock)callBackBlock
{
//    NSLog(@"Api = %@,parameters = %@", path, parameters);
    JJNetworkManager * manager = [JJNetworkManager shareManager];
    [manager POST:path parameters:parameters
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
//         NSLog(@"responseObject = %@",responseObject);
         successBlock(responseObject);
         callBackBlock();
     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         failureBlock(error);
         callBackBlock();
     }];

}

+(void)putWithPath:(NSString *)path
        parameters:(NSDictionary *)parameters
           success:(JJNetworkingSuccessBlock)successBlock
           failure:(JJNetworkingFailureBlock)failureBlock
          callBack:(JJNetworkingCallBackBlock)callBackBlock
{
    JJNetworkManager * manager = [JJNetworkManager shareManager];
    [manager PUT:path parameters:parameters
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        successBlock(responseObject);
        callBackBlock();
    }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        failureBlock(error);
        callBackBlock();
    }];
}

+ (void)deleteWithPath:(NSString *)path
            parameters:(NSDictionary *)parameters
               success:(JJNetworkingSuccessBlock)successBlock
               failure:(JJNetworkingFailureBlock)failureBlock
              callBack:(JJNetworkingCallBackBlock)callBackBlock
{
    JJNetworkManager * manager = [JJNetworkManager shareManager];
    [manager DELETE:path parameters:parameters
            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         successBlock(responseObject);
         callBackBlock();
     }
            failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         failureBlock(error);
         callBackBlock();
     }];
    
    
    
}


+ (void)uploadImageWithPath:(NSString *)path
                 parameters:(NSDictionary *)parameters
                      image:(UIImage *)image
                       name:(NSString *)name
                  imageName:(NSString *)imageName
                  imageType:(NSString *)imageType
                    success:(JJNetworkingSuccessBlock)successBlock
                    failure:(JJNetworkingFailureBlock)failureBlock
                   callBack:(JJNetworkingCallBackBlock)callBackBlock
{
    JJNetworkManager * manager = [JJNetworkManager shareManager];
    [manager POST:path parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //  为1.0的时候, 不压缩, 越小图片质量就越小. 如果设置为0, 则使用默认值(0.6)进行压缩
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:imageData name:name fileName:imageName mimeType:[NSString stringWithFormat:@"image/%@",imageType]]; // png/jpeg
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
        callBackBlock();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
        callBackBlock();
    }];

}

@end
