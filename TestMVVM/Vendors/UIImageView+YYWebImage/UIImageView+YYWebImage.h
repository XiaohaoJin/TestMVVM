//
//  UIImageView+YYWebImage.h
//  NewProject
//
//  Created by 金晓浩 on 16/5/15.
//  Copyright © 2016年 XiaoHaoJin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYWebImage.h>

@interface UIImageView (YYWebImage)

- (void)yy_downloadImage:(NSString *)urlString placeholderImage:(UIImage *)placeholder;

- (void)yy_downloadImage:(NSString *)urlString placeholderImage:(UIImage *)placeholder imageResizeToSize:(CGSize)size roundCornerRadius:(CGFloat)radius;


@end
