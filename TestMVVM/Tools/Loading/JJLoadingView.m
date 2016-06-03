//
//  JJLoadingView.m
//  NewProject
//
//  Created by 金晓浩 on 16/5/13.
//  Copyright © 2016年 XiaoHaoJin. All rights reserved.
//

#import "JJLoadingView.h"

#define DVV_ANIMATE_DURATION 0.2
#define DVV_LOADING_SIDE_WIDTH 70
#define DVV_LOADING_CORNER_RADIUS 10

#define DVV_TOAST_TYPE_LOADING @"dvv_type_loading"
#define DVV_TOAST_TYPE_MESSAGE @"dvv_type_message"
#define DVV_TOAST_TYPE_ANIMATION @"dvv_type_animation"
@implementation JJLoadingView

+ (void)show {
    [self showFromView:[UIApplication sharedApplication].keyWindow];
}
+ (void)hide {
    [self hideFromView:[UIApplication sharedApplication].keyWindow];
}

+ (void)showFromView:(UIView *)superView {
    
    // 如果已经存在则不再添加
    for (UIView *itemView in superView.subviews) {
        if ([itemView isKindOfClass:[JJLoadingView class]] &&
            [((JJLoadingView *)itemView).toastType isEqualToString:DVV_TOAST_TYPE_LOADING]) {
            return ;
        }
    }
    JJLoadingView *view = [JJLoadingView new];
    view.toastType = DVV_TOAST_TYPE_LOADING;
    view.frame = CGRectMake(0, 0, DVV_LOADING_SIDE_WIDTH, DVV_LOADING_SIDE_WIDTH);
    [view.layer setMasksToBounds:YES];
    [view.layer setCornerRadius:DVV_LOADING_CORNER_RADIUS];
    view.center = CGPointMake(superView.bounds.size.width / 2.f, superView.bounds.size.height / 2.f);
    view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    
    UIActivityIndicatorView *activityView = [UIActivityIndicatorView new];
    activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    activityView.center = CGPointMake(DVV_LOADING_SIDE_WIDTH / 2.f, DVV_LOADING_SIDE_WIDTH / 2.f);
    
    [view addSubview:activityView];
    [activityView startAnimating];
    view.alpha = 0;
    [superView addSubview:view];
    [UIView animateWithDuration:DVV_ANIMATE_DURATION animations:^{
        view.alpha = 1;
    }];
}
+ (void)hideFromView:(UIView *)superView {
    
    for (UIView *itemView in superView.subviews) {
        
        if ([itemView isKindOfClass:[JJLoadingView class]] && [((JJLoadingView *)itemView).toastType isEqualToString:DVV_TOAST_TYPE_LOADING]) {
            
            [UIView animateWithDuration:DVV_ANIMATE_DURATION animations:^{
                itemView.alpha = 0;
            } completion:^(BOOL finished) {
                [itemView removeFromSuperview];
                
                return ;
            }];
        }
    }
}



@end
