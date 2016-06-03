//
//  JJAnimateCycleImageView.m
//  NewProject
//
//  Created by 金晓浩 on 16/5/13.
//  Copyright © 2016年 XiaoHaoJin. All rights reserved.
//

#import "JJAnimateCycleImageView.h"

CGFloat kImageViewMargin = 20.0f;
#define AnimateDuration 0.5

#define LineWidth ScreenWidth*0.8

@interface JJAnimateCycleImageView () <UIScrollViewDelegate>
// 存储所有的UIView对象
@property (nonatomic, strong) NSMutableArray *contentViewArray;
// 存储所有的UIImageView对象
@property (nonatomic, strong) NSMutableArray *imageViewArray;
// 用于滚动展示图片
@property (nonatomic, strong) UIScrollView *scrollView;


//// 记录上次放大的视图
//@property (nonatomic, strong) UIView *lastView;
//
@property (nonatomic, strong) UILabel * backgroundLabel;
@property (nonatomic, strong) UILabel * currentLabel;


@end
@implementation JJAnimateCycleImageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSelf];
        [self addSubview:self.scrollView];
        [self addSubview:self.backgroundLabel];
    }
    return self;
}

- (void)initSelf {
    
    _imageUrlArray = [NSArray array];
    _contentViewArray = [NSMutableArray array];
    _imageViewArray = [NSMutableArray array];
    _currentIdx = 0;
}

#pragma mark 刷新数据的方法
- (void)refreshDataWithArray:(NSArray *)array {
    
    if (!array.count) {
        return;
    }
    // 保存图片网址
    _imageUrlArray = array;
    // 从数组中移除所有的imageView对象
    [_imageViewArray removeAllObjects];
    [_contentViewArray removeAllObjects];
    
    for (UIView *view in _scrollView.subviews) {
        [view removeFromSuperview];
    }
    
    self.currentLabel.frame = CGRectMake(0, 0, LineWidth/_imageUrlArray.count, 2);
    [self.backgroundLabel addSubview:self.currentLabel];
    
    
    // 循环创建所有要显示的图片，添加到scrollView上
    for (int i = 0; i < _imageUrlArray.count; i++) {
        UIImageView *imageView = [UIImageView new];
//        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView yy_downloadImage:array[i] placeholderImage:nil];
  
        // 给imageView添加点击事件
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClickAction)];
        [imageView addGestureRecognizer:tapGes];
        imageView.userInteractionEnabled = YES;
        
        [_imageViewArray addObject:imageView];
        
        UIView *view = [UIView new];
        [view addSubview:imageView];
        [_contentViewArray addObject:view];
        [_scrollView addSubview:view];
    }
    
    // 重新配置frame
    [self configUI];
}
#pragma mark - action

- (void)imageClickAction
{
    
    if (_touchUpInsideBlock)
    {
        _touchUpInsideBlock(_currentIdx);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
     [self configUI];
      _backgroundLabel.frame = CGRectMake(0, RectHeight(self.scrollView)+kImageViewMargin*3+10, LineWidth, 2);
}

- (void)configUI
{
    CGSize size = self.bounds.size;
    self.scrollView.frame = CGRectMake(0, 0, size.width, size.height);
    //    self.scrollView.backgroundColor = [UIColor redColor];
    // 设置所有图片容器的位置
    [_contentViewArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = (UIView *)obj;
        view.frame = CGRectMake(idx * size.width, 0, size.width, size.height);
    }];
    
    // 设置所有图片的位置
    [_imageViewArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *imageView = (UIImageView *)obj;
        // 使第一张图片有放大效果
        if (0 == idx) {
            imageView.frame = CGRectMake(0, 0, size.width, size.height);
        }else {
            imageView.frame = CGRectMake(kImageViewMargin, kImageViewMargin, size.width - kImageViewMargin*2, size.height - kImageViewMargin*2);
        }
    }];
    _currentIdx = 0;
    _scrollView.contentSize = CGSizeMake(_imageUrlArray.count * size.width, 0);
}


#pragma mark - scrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 记录当前显示的是第几张imageView
    _currentIdx = _scrollView.contentOffset.x / self.bounds.size.width;
    
    CGSize size = self.bounds.size;
    CGFloat offsetX = _scrollView.contentOffset.x - (size.width * _currentIdx);
    
    BOOL isLeft = NO;
    if (offsetX > 0) {
        // 向左滑
//        DLog(@"向左滑:  %lf",offsetX);
        isLeft = YES;
    }else {
        // 向右滑
//        DLog(@"向右滑:  %lf",offsetX);
        offsetX = -offsetX;
    }
    
    // 获取需要显示的imageView
    NSUInteger needShowIdx = 0;
    if (isLeft) {
        if (_imageViewArray.count - 1 == _currentIdx) {
            // 当前显示的是最后一个，如果还是向左滑就直接return
            return ;
        }
        needShowIdx = _currentIdx + 1;
    }else {
        if (0 == _currentIdx) {
            // 当前显示的是第一个，如果还是向右滑就直接return
            return ;
        }
        needShowIdx = _currentIdx - 1;
    }

    CGFloat zoomVolume = kImageViewMargin * (offsetX / size.width);
    DLog(@"needShowIdx:  %zi currentIdx: %zi ===%f",needShowIdx, _currentIdx, zoomVolume);
    
    UIImageView *needShowImageView = _imageViewArray[needShowIdx];
    // 放大需要显示的iamgeView
    needShowImageView.frame = CGRectMake(kImageViewMargin - zoomVolume, kImageViewMargin - zoomVolume, size.width - kImageViewMargin*2 + zoomVolume*2, size.height - kImageViewMargin*2 + zoomVolume*2);
    
    // 缩小当前显示的imageView
    UIImageView *currentImageView = _imageViewArray[_currentIdx];
    currentImageView.frame = CGRectMake(zoomVolume, zoomVolume, size.width - zoomVolume*2, size.height - zoomVolume*2);
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    // 记录当前显示的是第几张imageView
    _currentIdx = _scrollView.contentOffset.x / self.bounds.size.width;
    
    CGFloat num =self.imageUrlArray.count;
    CGFloat currentWidth = LineWidth/num;
    [UIView animateWithDuration:0.3 animations:^{
        self.currentLabel.frame = CGRectMake(currentWidth*_currentIdx, 0, currentWidth, 2);
    }];
    [self.backgroundLabel addSubview:self.currentLabel];
}


#pragma mark - lazy laod

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.clipsToBounds = NO;
        
    }
    return _scrollView;
}


- (UILabel *)currentLabel
{
    if (!_currentLabel) {
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor blackColor];
        
        _currentLabel = label;
    }
    return _currentLabel;
}

- (UILabel *)backgroundLabel
{
    if (!_backgroundLabel) {
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor grayColor];
        
        _backgroundLabel = label;
        
        [_backgroundLabel addSubview:self.currentLabel];
    }
    return _backgroundLabel;
}


@end
