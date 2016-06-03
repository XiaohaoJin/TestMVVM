//
//  JJLoadingView.h
//  NewProject
//
//  Created by 金晓浩 on 16/5/13.
//  Copyright © 2016年 XiaoHaoJin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJLoadingView : UIView
@property (nonatomic, copy) NSString *toastType;

+ (void)show;
+ (void)hide;

+ (void)showFromView:(UIView *)superView;
+ (void)hideFromView:(UIView *)superView;

+ (void)showAnimation;
+ (void)showAnimationFromView:(UIView *)superView;
+ (void)hideAnimation;
+ (void)hideAnimationFromView:(UIView *)superView;

@end
