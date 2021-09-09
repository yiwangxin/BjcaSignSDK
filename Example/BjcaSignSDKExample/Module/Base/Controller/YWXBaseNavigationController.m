//
//  YWXBaseNavigationController.m
//  YWXSignSDKDemo
//
//  Created by szyx on 2021/3/25.
//

#import "YWXBaseNavigationController.h"

@interface YWXBaseNavigationController ()

@end

@implementation YWXBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    UINavigationBar *navigationBar = self.navigationBar;
    [navigationBar setShadowImage:[UIImage new]];
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
