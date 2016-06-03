//
//  UIImageView+YYWebImage.m
//  NewProject
//
//  Created by 金晓浩 on 16/5/15.
//  Copyright © 2016年 XiaoHaoJin. All rights reserved.
//

#import "UIImageView+YYWebImage.h"

@implementation UIImageView (YYWebImage)

- (void)yy_downloadImage:(NSString *)urlString placeholderImage:(UIImage *)placeholder
{
    if (urlString && urlString.length) {
        [self yy_setImageWithURL:[NSURL URLWithString:urlString]
                     placeholder:placeholder
                         options:YYWebImageOptionProgressiveBlur |YYWebImageOptionSetImageWithFadeAnimation
                        progress:nil
                       transform:nil
                      completion:nil
         ];;
    }else {
        self.image = placeholder;
    }
}

- (void)yy_downloadImage:(NSString *)urlString placeholderImage:(UIImage *)placeholder imageResizeToSize:(CGSize)size roundCornerRadius:(CGFloat)radius
{
    
    if (urlString && urlString.length) {
        [self yy_setImageWithURL:[NSURL URLWithString:urlString]
                     placeholder:placeholder
                         options:YYWebImageOptionProgressiveBlur |YYWebImageOptionSetImageWithFadeAnimation
                        progress:nil
                       transform:^UIImage *(UIImage *image, NSURL *url) {
                           
                           image = [image yy_imageByResizeToSize:size contentMode:UIViewContentModeCenter];
                           return [image yy_imageByRoundCornerRadius:radius];
                       }
                      completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
                          if (from == YYWebImageFromDiskCache) {
                              NSLog(@"load from disk cache");
                          }
                      }];;
    }else {
        self.image = placeholder;
    }
}

@end
