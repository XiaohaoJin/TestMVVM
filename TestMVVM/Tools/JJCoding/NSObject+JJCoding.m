//
//  NSObject+JJCoding.m
//  NewProject
//
//  Created by 金晓浩 on 16/5/15.
//  Copyright © 2016年 XiaoHaoJin. All rights reserved.
//

#import "NSObject+JJCoding.h"
#import <objc/runtime.h>

@implementation NSObject (JJCoding)

- (void)jj_encode:(NSCoder *)encoder
{
    [self jj_coding:encoder type:JJCodingTypeEncode];
}

- (void)jj_decode:(NSCoder *)decoder
{
    [self jj_coding:decoder type:JJCodingTypeDecode];
}

- (void)jj_coding:(NSCoder *)coder type:(JJCodingType)codingType
{
    // 用来存储属性的个数
    unsigned int count;
    // 获取属性列表
    objc_property_t *properties = class_copyPropertyList(self.class, &count);
    
    for (unsigned int i = 0; i < count; i++)
    {
        // 获取一个属性
        objc_property_t property = properties[i];
        // 获取一个属性名
        const char *name = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        if ([propertyName isEqualToString:@"hash"] ||
            [propertyName isEqualToString:@"superclass"] ||
            [propertyName isEqualToString:@"description"] ||
            [propertyName isEqualToString:@"debugDescription"]) {
            return;
        }
        // 存储一个属性值
        NSString *propertyValue = '\0';
        // 归档
        if (JJCodingTypeEncode == codingType)
        {
            propertyValue = [self valueForKey:propertyName];
//            NSLog(@"===%@, %@", propertyName, propertyValue);
            if (propertyValue.length && propertyName.length) [coder encodeObject:propertyValue forKey:propertyName];
        }
        // 解档
        else if (JJCodingTypeDecode == codingType)
        {
            propertyValue = [coder decodeObjectForKey:propertyName];
//            NSLog(@"---%@, %@", propertyName, propertyValue);
            if (propertyValue.length && propertyName.length) [self setValue:propertyValue forKey:propertyName];
        }
    }
    // 释放
    free(properties);
}

@end
