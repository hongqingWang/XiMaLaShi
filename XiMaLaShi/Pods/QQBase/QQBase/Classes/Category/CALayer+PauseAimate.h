//
//  CALayer+PauseAimate.h
//  XiMaLaShi
//
//  Created by 王红庆 on 2018/8/23.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (PauseAimate)

// 暂停动画
- (void)pauseAnimate;

// 恢复动画
- (void)resumeAnimate;

@end
