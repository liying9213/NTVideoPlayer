//
//  NTVideoParseView.m
//  NTVideoPlayer
//
//  Created by 李莹 on 2019/1/16.
//  Copyright © 2019 liying. All rights reserved.
//

#import "NTVideoParseView.h"
#import <WebKit/WebKit.h>
#import "NTLocalDataManage.h"
#import "NTWarnViewManager.h"
@interface NTVideoParseView()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webview;
@property (weak, nonatomic) IBOutlet UIView *warnView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *downLoadButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (nonatomic, copy) NSString *videoPath;
@property (nonatomic, assign) BOOL finishLoad;
@property (nonatomic, copy) NSArray *parseArray;
@property (nonatomic, assign) NSInteger parseIndex;

@end

@implementation NTVideoParseView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.textView.font = [UIFont normalFontOfSize:14 WithFontType:Normal];
    self.playButton.titleLabel.font = [UIFont normalFontOfSize:16 WithFontType:Normal];
    self.downLoadButton.titleLabel.font = [UIFont normalFontOfSize:16 WithFontType:Normal];
    self.warnView.layer.masksToBounds = YES;
    self.warnView.layer.cornerRadius = 4.0f;
    [self getParseData];
}

- (void)parseWebView{
    self.activityIndicatorView.hidden = NO;
    [self.activityIndicatorView startAnimating];
    self.videoPath = nil;
    self.finishLoad = NO;
    [self.webview stopLoading];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.parseArray[self.parseIndex],[self.urlPath stringByReplacingOccurrencesOfString:@" " withString:@""]]]
                                                  cachePolicy:NSURLRequestUseProtocolCachePolicy
                                              timeoutInterval:10.0f];
    
    [self.webview loadRequest:request];
}

- (void)getParseData{
    self.parseArray = [NTLocalDataManage getParseData];
}

- (void)resetView{
    if (self.finishLoad && self.videoPath.length>0) {
        self.textView.text = self.videoPath;
        [self.playButton setTitle:@"播放" forState:UIControlStateNormal];
        [self.downLoadButton setTitle:@"下载" forState:UIControlStateNormal];
    }
    else{
        self.textView.text = @"解析失败，是否重试";
        [self.playButton setTitle:@"取消" forState:UIControlStateNormal];
        [self.downLoadButton setTitle:@"重试" forState:UIControlStateNormal];
    }
    self.activityIndicatorView.hidden = YES;
    [self.activityIndicatorView stopAnimating];
}

- (IBAction)playAction:(id)sender {
    if (self.videoPath.length>0) {
        !self.playAction ? : self.playAction(self.videoPath);
    }
    else{
        [self closeAction:nil];
    }
}

- (IBAction)downLoadAction:(id)sender {
    if (self.videoPath.length>0) {
        !self.downLoadAction ? : self.downLoadAction(self.videoPath);
    }
    else{
        self.parseIndex++;
        if (self.parseIndex>=self.parseArray.count) {
            self.parseIndex = 0;
        }
        [self parseWebView];
    }
}

- (IBAction)closeAction:(id)sender {
    [self.webview stopLoading];
    !self.cancleAction ? : self.cancleAction();
}

#pragma mark - webView

- (WKWebView *)webview{
    if (!_webview) {
        _webview = [[WKWebView alloc] initWithFrame:CGRectZero];
        _webview.navigationDelegate = self;
        if (@available(iOS 9.0, *)) {
            _webview.allowsLinkPreview = NO;
        }
        if (IS_IPHONE_X) {
            if (@available(iOS 11.0, *)) {
                self.webview.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }
        }
        _webview.hidden = YES;
        [self.warnView addSubview:_webview];
    }
    return _webview;
}

#pragma mark - webViewDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    NSString *JsStr = @"(document.getElementsByTagName(\"video\")[0]).src";
    [webView evaluateJavaScript:JsStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        if(![response isEqual:[NSNull null]] && response != nil){
            //截获到视频地址了
            self.videoPath = response;
            NSLog(@"response == %@",response);
            [self resetView];
        }else{
            //没有视频链接
        }
        [self resetView];
    }];
    self.finishLoad = YES;
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    self.finishLoad = YES;
}
@end
