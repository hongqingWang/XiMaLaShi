//
//  QQTabBarMiddleView.m
//  XiMaLaShi
//
//  Created by 王红庆 on 2018/8/23.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import "QQTabBarMiddleView.h"
#import "CALayer+PauseAimate.h"

@interface QQTabBarMiddleView ()

@property (weak, nonatomic) IBOutlet UIImageView *middleImageView;

@property (weak, nonatomic) IBOutlet UIButton *playButton;

@end

@implementation QQTabBarMiddleView

static QQTabBarMiddleView *_shareInstance;

+ (instancetype)shareInstance {
    if (_shareInstance == nil) {
        _shareInstance = [QQTabBarMiddleView middleView];
    }
    return _shareInstance;
}


+ (instancetype)middleView {
    
    QQTabBarMiddleView *middleView = [[[NSBundle mainBundle] loadNibNamed:@"QQTabBarMiddleView" owner:nil options:nil] firstObject];
    return middleView;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.middleImageView.layer.masksToBounds = YES;
    self.middleImg = self.middleImageView.image;
    
    [self.middleImageView.layer removeAnimationForKey:@"playAnnimation"];
    CABasicAnimation *basicAnnimation = [[CABasicAnimation alloc] init];
    basicAnnimation.keyPath = @"transform.rotation.z";
    basicAnnimation.fromValue = @0;
    basicAnnimation.toValue = @(M_PI * 2);
    basicAnnimation.duration = 30;
    basicAnnimation.repeatCount = MAXFLOAT;
    basicAnnimation.removedOnCompletion = NO;
    [self.middleImageView.layer addAnimation:basicAnnimation forKey:@"playAnnimation"];
    
    [self.middleImageView.layer pauseAnimate];
    
    
    [self.playButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 监听播放状态的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isPlayerPlay:) name:@"playState" object:nil];
    
    // 监听播放图片的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setPlayImage:) name:@"playImage" object:nil];
}

- (void)isPlayerPlay:(NSNotification *)notification {
    BOOL isPlay = [notification.object boolValue];
    self.isPlaying = isPlay;
}

- (void)setPlayImage:(NSNotification *)notification {
    UIImage *image = notification.object;
    self.middleImg = image;
}

- (void)btnClick:(UIButton *)btn {
    
    if (self.middleClickBlock) {
        self.middleClickBlock(self.isPlaying);
    }
    
}


- (void)setIsPlaying:(BOOL)isPlaying {
    
    if (_isPlaying == isPlaying) {
        return;
    }
    _isPlaying = isPlaying;
    if (isPlaying) {
        [self.playButton setImage:nil forState:UIControlStateNormal];
        [self.middleImageView.layer resumeAnimate];
        
    }else {
        
        UIImage *image = [UIImage imageNamed:@"tabbar_np_play"];
        [self.playButton setImage:image forState:UIControlStateNormal];
        
        [self.middleImageView.layer pauseAnimate];
    }
}

-(void)setMiddleImg:(UIImage *)middleImg {
    _middleImg = middleImg;
    self.middleImageView.image = middleImg;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.middleImageView.layer.cornerRadius = self.middleImageView.frame.size.width * 0.5;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
