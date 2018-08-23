//
//  QQTabBarController.m
//  XiMaLaShi
//
//  Created by 王红庆 on 2018/8/23.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import "QQTabBarController.h"
#import "QQTabBar.h"
#import "QQNavigationController.h"
#import "UIImage+QQImage.h"
#import "QQTabBarMiddleView.h"

@interface QQTabBarController ()

@end

@implementation QQTabBarController

+ (instancetype)shareInstance {
    
    static QQTabBarController *tabbarC;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tabbarC = [[QQTabBarController alloc] init];
    });
    return tabbarC;
}

+ (instancetype)tabBarControllerWithAddChildVCsBlock: (void(^)(QQTabBarController *tabBarC))addVCBlock {
    
    QQTabBarController *tabbarVC = [[QQTabBarController alloc] init];
    if (addVCBlock) {
        addVCBlock(tabbarVC);
    }
    
    return tabbarVC;
}


-(void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tabbar
    [self setUpTabbar];
    
}

- (void)setUpTabbar {
    [self setValue:[[QQTabBar alloc] init] forKey:@"tabBar"];
}

/**
 *  根据参数, 创建并添加对应的子控制器
 *
 *  @param vc                需要添加的控制器(会自动包装导航控制器)
 *  @param isRequired             标题
 *  @param normalImageName   一般图片名称
 *  @param selectedImageName 选中图片名称
 */
- (void)addChildVC: (UIViewController *)vc normalImageName: (NSString *)normalImageName selectedImageName:(NSString *)selectedImageName isRequiredNavController: (BOOL)isRequired {
    
    if (isRequired) {
        QQNavigationController *nav = [[QQNavigationController alloc] initWithRootViewController:vc];
        nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage originImageWithName:normalImageName] selectedImage:[UIImage originImageWithName:selectedImageName]];
        
        [self addChildViewController:nav];
    }else {
        [self addChildViewController:vc];
    }
    
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
    
    UIViewController *vc = self.childViewControllers[selectedIndex];
    if (vc.view.tag == 666) {
        vc.view.tag = 888;
        
        QQTabBarMiddleView *middleView = [QQTabBarMiddleView middleView];
        middleView.middleClickBlock = [QQTabBarMiddleView shareInstance].middleClickBlock;
        middleView.isPlaying = [QQTabBarMiddleView shareInstance].isPlaying;
        middleView.middleImg = [QQTabBarMiddleView shareInstance].middleImg;
        CGRect frame = middleView.frame;
        frame.size.width = 65;
        frame.size.height = 65;
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        frame.origin.x = (screenSize.width - 65) * 0.5;
        frame.origin.y = screenSize.height - 65;
        middleView.frame = frame;
        [vc.view addSubview:middleView];
    }
}

@end
