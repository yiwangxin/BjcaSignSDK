//
//  MainTabBarController.m
//  YWXSignSDKDemo
//
//  Created by szyx on 2021/3/25.
//

#import "MainTabBarController.h"
#import "YWXBaseNavigationController.h"
#import "YWXBjcaSignSDKViewController.h"
@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubController];
}

- (void)addSubController {
    YWXBjcaSignSDKViewController *bjcaSignSDKController = [[YWXBjcaSignSDKViewController alloc] init];
    [self setChildViewController:bjcaSignSDKController title:@"旧签名" imageName:@"arrow_up" seleceImageName:@"arrow_down"];
}

-(void)setChildViewController:(UIViewController*)controller
                        title:(NSString *)title
                    imageName:(NSString *)imageName
              seleceImageName:(NSString *)selectImageName {
    controller.title = title;
    controller.tabBarItem.title = title;
    controller.tabBarItem.image = [UIImage imageNamed:imageName];
    controller.tabBarItem.selectedImage = [UIImage imageNamed:selectImageName];
    YWXBaseNavigationController *navController = [[YWXBaseNavigationController alloc] initWithRootViewController:controller];
    [self addChildViewController:navController];
}

@end
