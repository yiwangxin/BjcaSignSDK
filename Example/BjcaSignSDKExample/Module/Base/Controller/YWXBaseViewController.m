//
//  YWXBaseViewController.m
//  YWXSignSDKDemo
//
//  Created by szyx on 2021/3/25.
//

#import "YWXBaseViewController.h"

@interface YWXBaseViewController ()

@end

@implementation YWXBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    // Do any additional setup after loading the view.
}

#pragma mark - 基础方法
/// 弹窗提醒
/// @param title 标题
/// @param code 状态码
/// @param message 信息
/// @param info 结果信息
-(void)showAlertWith:(NSString *)title code:(NSString *)code message:(NSString *)message info:(id)info {
    [self showAlertWith:title code:code message:message info:info confirm:nil];
    
}


-(void)showAlertWith:(NSString *)title code:(NSString *)code message:(NSString *)message info:(id)info confirm:(void (^ __nullable)(UIAlertAction *action))confirm {
    NSMutableString *dataString = [NSMutableString stringWithFormat:@""];
    if ([info isKindOfClass:[NSDictionary class]]) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:info options:NSJSONWritingPrettyPrinted error:nil];
        NSString *dataDeatilString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [dataString appendFormat:@"%@",dataDeatilString];
    }
    NSString *messageString = [NSString stringWithFormat:@"status:%@\nmessage:%@\ndata:%@",code,message,dataString];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:confirm];
    NSString *titleText = [NSString stringWithFormat:@"%@%@",title,code];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:titleText message:messageString preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:sureAction];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self presentViewController:alertController animated:YES completion:nil];
    });
    
}

- (UIImage *)ywx_imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    //开启图片上下文
    UIGraphicsBeginImageContext(rect.size);
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置颜色
    CGContextSetFillColorWithColor(context, [color CGColor]);
    //设置rect
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //上下文使用完毕,关闭上下文
    UIGraphicsEndImageContext();
    //返回image
    return image;
}


@end
