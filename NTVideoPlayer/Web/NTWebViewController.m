//
//  NTWebViewController.m
//  NTVideoPlayer
//
//  Created by 李莹 on 2019/1/14.
//  Copyright © 2019 liying. All rights reserved.
//

#import "NTWebViewController.h"
#import <WebKit/WebKit.h>
#import "UIViewController+NTNavigation.h"
#import "NTWarnViewManager.h"
#import "NTVideoParseManage.h"

@interface NTWebViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *webview;

@end

@implementation NTWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetNavView];
    [NTWarnViewManager showWaitingView];
    [self loadWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)resetNavView{
    [self setNavLeftItemTitle:nil ImageName:@"backIon" WithAction:@"backAction"];
    [self setNavRightItemTitle:nil ImageName:@"add_skills" WithAction:@"videoAction"];
}


- (void)loadWebView{
    [NTWarnViewManager showWaitingView];
    [self.webview stopLoading];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[self.urlPath stringByReplacingOccurrencesOfString:@" " withString:@""]]
                                                  cachePolicy:NSURLRequestUseProtocolCachePolicy
                                              timeoutInterval:15.0f];
    
    [self.webview loadRequest:request];
}

#pragma mark - resetView

- (WKWebView *)webview{
    if (!_webview) {
        _webview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - NaviBarHeight)];
        _webview.navigationDelegate = self;
        if (@available(iOS 9.0, *)) {
            _webview.allowsLinkPreview = NO;
        }
        if (IS_IPHONE_X) {
            if (@available(iOS 11.0, *)) {
                self.webview.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }
        }
        [self.view addSubview:_webview];
    }
    return _webview;
}

#pragma mark - webViewDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    [NTWarnViewManager hiddenWaitingView];
    NSString *JsStr = @"(document.getElementsByTagName(\"video\")[0]).src";
    [webView evaluateJavaScript:JsStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        if(![response isEqual:[NSNull null]] && response != nil){
            //截获到视频地址了
            NSLog(@"response == %@",response);
        }else{
            //没有视频链接
        }
    }];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    [NTWarnViewManager showErrorViewWith:@"页面加载失败！"];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)videoAction{
    [NTWarnViewManager shoWParseWarnWithPath:self.webview.URL.absoluteString withCancleAction:^{
        
    } withPlayAction:^(NSString *content) {
        NSLog(@"=play====%@",content);
    } withDownLoadAction:^(NSString *content) {
        NSLog(@"=down====%@",content);
    }];
}

@end
