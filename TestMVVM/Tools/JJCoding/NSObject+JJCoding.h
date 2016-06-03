//
//  NSObject+JJCoding.h
//  NewProject
//
//  Created by 金晓浩 on 16/5/15.
//  Copyright © 2016年 XiaoHaoJin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, JJCodingType)
{
    JJCodingTypeEncode,
    JJCodingTypeDecode
};

@interface NSObject (JJCoding)

/**
 *  解码（从文件解析对象）
 */
- (void)jj_decode:(NSCoder *)decoder;
/**
 *  编码（将对象写入文件）
 */
- (void)jj_encode:(NSCoder *)encoder;


/**
 *  属性归档的实现
 */
#define JJCodingImplementation \
- (instancetype)initWithCoder:(NSCoder *)coder \
{ \
self = [super init]; \
if (self) { \
[self jj_decode:coder]; \
} \
return self; \
} \
\
- (void)encodeWithCoder:(NSCoder *)aDecoder \
{ \
[self jj_encode:aDecoder]; \
}

@end
