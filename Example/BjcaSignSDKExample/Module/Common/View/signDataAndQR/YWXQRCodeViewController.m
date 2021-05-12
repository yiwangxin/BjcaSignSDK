//
//  YWXQRCodeViewController.m
//  YWXSignSDKDemo
//
//  Created by szyx on 2021/4/6.
//  Copyright © 2021 Beijing Digital Yixin Technology Co., Ltd. All rights reserved.
//

#import "YWXQRCodeViewController.h"
#import <WebKit/WebKit.h>
#import "Masonry.h"

@interface YWXQRCodeViewController ()

@property (nonatomic,strong)  WKWebView *webView;

@property (nonatomic,strong)  UIButton *closeButtom;

@property (nonatomic,strong) UIImageView *qrCodeImageView;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UILabel *qrcodeMessageLabel;

@end

@implementation YWXQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.titleLabel.text = self.title;
    if (self.urlString) {
        NSURL *loadUrl = [[NSURL alloc] initWithString:self.urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:loadUrl];
        [self.webView loadRequest:request];
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        longPress.minimumPressDuration = 1;
        [self.webView addGestureRecognizer:longPress];
    }
    if (self.imageBase64) {
        [self.qrCodeImageView setHidden:NO];
        NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:self.imageBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        UIImage *_decodedImage = [UIImage imageWithData:decodedData];
        self.qrCodeImageView.image = _decodedImage;
        [self discernQRCodeMessage:_decodedImage];
    }
}

-(void)discernQRCodeMessage:(UIImage *)image {
    //1. 初始化扫描仪，设置设别类型和识别质量
    CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
//    UIImage * image = self.qrCodeImageView.image;
    CGImageRef ref = image.CGImage;
    //2. 扫描获取的特征组
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:ref]];
    //3. 获取扫描结果
    CIQRCodeFeature *feature = [features objectAtIndex:0];
    NSString *scannedResult = feature.messageString;
    self.qrcodeMessageLabel.text = [NSString stringWithFormat:@"%@\n%@",@"二维码内容：",scannedResult];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
- (void)handleLongPress:(UILongPressGestureRecognizer *)sender{
    if (sender.state != UIGestureRecognizerStateBegan) return;
    CGPoint touchPoint = [sender locationInView:self.webView];
    // 获取长按位置对应的图片url的JS代码
    NSString *imgJS = [NSString stringWithFormat:@"document.elementFromPoint(%f,%f).src", touchPoint.x, touchPoint.y];

    // 执行对应的JS代码 获取url
    [self.webView evaluateJavaScript:imgJS completionHandler:^(id _Nullable imgUrl, NSError * _Nullable error) {
        if (imgUrl) {
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];
            UIImage *image = [UIImage imageWithData:data];
            [self discernQRCodeMessage:image];
        }
    }];
}

- (void)initUI {
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    
    but.titleLabel.adjustsFontSizeToFitWidth = YES;
    but.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    but.titleLabel.font = [UIFont systemFontOfSize:20];
    [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [but setTitle:@"关闭" forState:UIControlStateNormal];
    [self.view addSubview:but];
    [but addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    but.frame = CGRectMake(10, 30, 100, 30);
    
    [self.view addSubview:self.webView];
    self.webView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *webViewTop = [NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:80];
    NSLayoutConstraint *webViewLeading = [NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    NSLayoutConstraint *webViewTrailing = [NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    NSLayoutConstraint *webViewBottom = [NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self.view addConstraints:@[webViewTop, webViewLeading, webViewTrailing, webViewBottom]];
    [self.view addSubview:self.qrCodeImageView];
    [self.qrCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.webView.mas_top).offset(20);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.offset(200);
        make.height.offset(200);
    }];
    [self.view addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(40);
        make.centerX.equalTo(self.view.mas_centerX);
//        make.width.offset(200);
//        make.height.offset(40);
    }];
    [self.view addSubview:self.qrcodeMessageLabel];
    [self.qrcodeMessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.webView.mas_bottom).offset(-30);
        make.leading.equalTo(self.webView.mas_leading).offset(20);
        make.trailing.equalTo(self.webView.mas_trailing).offset(-20);
        
    }];
}

- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (WKWebView *)webView {
    if (_webView == nil) {
        _webView = [[WKWebView alloc] init];
    }
    return _webView;
}

- (UIImageView *)qrCodeImageView {
    if (_qrCodeImageView == nil) {
        _qrCodeImageView = [[UIImageView alloc] init];
        _qrCodeImageView.layer.borderWidth = 1;
        _qrCodeImageView.layer.borderColor = [UIColor blackColor].CGColor;
        [_qrCodeImageView setHidden:YES];
    }
    return _qrCodeImageView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (UILabel *)qrcodeMessageLabel {
    if (_qrcodeMessageLabel == nil) {
        _qrcodeMessageLabel = [[UILabel alloc] init];
        _qrcodeMessageLabel.textColor = [UIColor blackColor];
        _qrcodeMessageLabel.numberOfLines = 0;
    }
    return _qrcodeMessageLabel;
}

@end
