//
//  JJRadioPlayerController.m
//  NewProject
//
//  Created by 金晓浩 on 16/5/15.
//  Copyright © 2016年 XiaoHaoJin. All rights reserved.
//

#import "JJRadioPlayerController.h"
#import "JJRadioPlayerViewModel.h"
#import "JJPlayManager.h"

@interface JJRadioPlayerController ()
Strong_Property(JJRadioPlayerViewModel, viewModel)
Strong_Property(UIImageView, backImageView)
Strong_Property(UIImageView, animateImageView)
Strong_Property(JJPlayManager, player)
BOOL_Property(isPlaying)

@end

@implementation JJRadioPlayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.backImageView];
    [_backImageView addSubview:self.animateImageView];
    [self configViewModel];
    
    CMTime currentTime = [self.player.player currentTime];

 
}

- (void)configViewModel
{
    _viewModel = [JJRadioPlayerViewModel new];
    _viewModel.tingID = self.tingID;
    WS;
    [_viewModel setJj_successBlock:^{
        SWS;
        [strongSelf.animateImageView yy_downloadImage:strongSelf.viewModel.imageUrl
                                     placeholderImage:nil
                                    imageResizeToSize:CGSizeMake(ScreenWidth - 120, ScreenWidth - 120)
                                    roundCornerRadius:(ScreenWidth - 120)/2.0];
        strongSelf.player = [JJPlayManager shareManager];
        [strongSelf.player playWithUrlString:strongSelf.viewModel.musicUrl];
        [strongSelf startAnimate:nil];
        
        
    }];
    
    // 请求成功或失败的回调
    [_viewModel setJj_callBackBlock:^{
        [JJLoadingView hideFromView:weakSelf.view];
    }];
    
    [JJLoadingView showFromView:self.view];
    [_viewModel jj_requestRefresh];
    
}

- (UIImageView *)backImageView
{
    if (!_backImageView) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(20, (ScreenHeight - ScreenWidth + 40)/2.0 , ScreenWidth - 40, ScreenWidth - 40);
        imageView.layer.cornerRadius = (ScreenWidth - 40)/2.0;
        imageView.backgroundColor = [UIColor colorWithHexString:@"#999999"];
        imageView.layer.borderWidth = 10;
        imageView.layer.borderColor = [UIColor colorWithHexString:@"#cccccc"].CGColor;
        imageView.userInteractionEnabled = YES;
        _backImageView = imageView;
    }
    return _backImageView;
}

- (UIImageView *)animateImageView
{
    if (!_animateImageView) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(40, 40, ScreenWidth - 40 - 80, ScreenWidth - 40 - 80);
        _animateImageView = imageView;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playerIsStartOrStop)];
        _animateImageView.userInteractionEnabled = YES;
        [_animateImageView addGestureRecognizer:tap];
        
        //添加动画
        CABasicAnimation *monkeyAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        monkeyAnimation.toValue = [NSNumber numberWithFloat:2.0 *M_PI];
        monkeyAnimation.duration = 10.f;
        monkeyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        monkeyAnimation.cumulative = NO;
        monkeyAnimation.removedOnCompletion = NO; //No Remove
        
        monkeyAnimation.repeatCount = FLT_MAX;
        [imageView.layer addAnimation:monkeyAnimation forKey:@"AnimatedKey"];
        [imageView stopAnimating];
        
        // 加载动画 但不播放动画
        imageView.layer.speed = 0.0;
        
        
    }
    return _animateImageView;
}

- (void)playerIsStartOrStop {
    //_player.player.status == AVPlayerStatusReadyToPlay
    if (_isPlaying == NO) {
        [self stopAnimate:nil];
        [_player.player pause];
        _isPlaying = YES;
    }
    else
    {
        [self startAnimate:nil];
        [_player.player play];
        _isPlaying = NO;
    }
    
}

//开始动画
- (void)startAnimate:(id)sender {
        self.animateImageView.layer.speed = 1.0;
        self.animateImageView.layer.beginTime = 0.0;
        CFTimeInterval pausedTime = [self.animateImageView.layer timeOffset];
        CFTimeInterval timeSincePause = [self.animateImageView.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
        self.animateImageView.layer.beginTime = timeSincePause;
}

//停止动画并保存当前的角度
- (void)stopAnimate:(id)sender {
    if (_player.player.status == AVPlayerStatusReadyToPlay) {
        CFTimeInterval pausedTime = [self.animateImageView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
        self.animateImageView.layer.speed = 0.0;
        self.animateImageView.layer.timeOffset = pausedTime;
        
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
