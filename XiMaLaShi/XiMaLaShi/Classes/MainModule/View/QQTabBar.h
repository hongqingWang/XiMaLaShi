//
//  QQTabBar.h
//  XiMaLaShi
//
//  Created by 王红庆 on 2018/8/23.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QQTabBar : UITabBar

/**
 点击中间按钮的执行代码块
 */
@property (nonatomic, copy) void(^middleClickBlock)(BOOL isPlaying);

@end
