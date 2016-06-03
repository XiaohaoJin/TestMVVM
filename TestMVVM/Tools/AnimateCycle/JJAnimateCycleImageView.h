//
//  JJAnimateCycleImageView.h
//  NewProject
//
//  Created by 金晓浩 on 16/5/13.
//  Copyright © 2016年 XiaoHaoJin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JJAnimateCycleImageViewImageClickBlock)(NSUInteger idx);

@interface JJAnimateCycleImageView : UIView

//** 存储所有图片路径 */
@property (nonatomic, strong) NSArray *imageUrlArray;
/** 当前显示的图片的下标 */
@property (nonatomic, assign) NSUInteger currentIdx;


/**
 *  刷新数据的方法
 *
 *  @param array 图片的URL地址
 */
- (void)refreshDataWithArray:(NSArray *)array;

@property (nonatomic, copy) JJAnimateCycleImageViewImageClickBlock touchUpInsideBlock;
/**
 *  设置点击图片的回调
 *
 *  @param touchUpInsideBlock ImageClickBlock
 */
- (void)setTouchUpInsideBlock:(JJAnimateCycleImageViewImageClickBlock)touchUpInsideBlock;



@end
