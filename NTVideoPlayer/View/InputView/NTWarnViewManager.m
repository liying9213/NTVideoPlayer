//
//  NTWarnViewManager.m
//  NTVideoPlayer
//
//  Created by 李莹 on 2018/7/6.
//  Copyright © 2018年 liying. All rights reserved.
//

#import "NTWarnViewManager.h"
#import <SVProgressHUD.h>
#import "NTInputWarnView.h"
#import "NTVideoParseView.h"

@implementation NTWarnViewManager

+ (void)showErrorViewWith:(NSString *)error{
    [SVProgressHUD dismiss];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setMinimumDismissTimeInterval:1];
    [SVProgressHUD setCornerRadius:8.0f];
    [SVProgressHUD showErrorWithStatus:error];
}

+(void)showSuccessViewWith:(NSString *)success{
    [SVProgressHUD dismiss];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setMinimumDismissTimeInterval:1];
    [SVProgressHUD setCornerRadius:8.0f];
    [SVProgressHUD showSuccessWithStatus:success];
}

+(void)showWarnViewNoImageWith:(NSString *)content{
    [SVProgressHUD dismiss];
    [SVProgressHUD setSuccessImage:nil];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setMinimumDismissTimeInterval:1];
    [SVProgressHUD setCornerRadius:8.0f];
    [SVProgressHUD showSuccessWithStatus:content];
}

+(void)showStatusViewWith:(NSString *)Status{
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setMinimumDismissTimeInterval:2.0];
    [SVProgressHUD setCornerRadius:8.0f];
    [SVProgressHUD showWithStatus:Status];
}

+(void)showWaitingView{
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setCornerRadius:8.0f];
    [SVProgressHUD show];
}

+(void)hiddenWaitingView{
    [SVProgressHUD dismiss];
}

+ (void)shoWWarnWithCancle:(NSString *)cancle withSure:(NSString *)sure withCancleAction:(void (^)(void))cancleAction  withSureAction:(void (^)(NSString *content))sureAction{
    __block NTInputWarnView *view = [[NSBundle mainBundle] loadNibNamed:@"NTWarnView" owner:nil options:nil][0];
    [view resetViewWithCancle:cancle withSure:sure withCancleAction:^{
        !cancleAction ? : cancleAction();
        [UIView animateWithDuration:0.15
                         animations:^{
                             view.alpha = 0.0;
                         }
                         completion:^(BOOL finished) {
                             if (finished) {
                                 [view removeFromSuperview];
                                 view = nil;
                             }
                         }];
    } withSureAction:^(NSString *content) {
        !sureAction ? : sureAction(content);
        [UIView animateWithDuration:0.15
                         animations:^{
                             view.alpha = 0.0;
                         }
                         completion:^(BOOL finished) {
                             if (finished) {
                                 [view removeFromSuperview];
                                 view = nil;
                             }
                         }];
    }];
    UIWindow *window = [UIApplication sharedApplication].windows[0];
    [window addSubview:view];
    view.frame = window.bounds;
    view.alpha = 0;
    [UIView animateWithDuration:0.15
                     animations:^{
                         view.alpha = 1.0;
                     }
                     completion:^(BOOL finished){
                     }];
}

+ (void)shoWParseWarnWithPath:(NSString *)path withCancleAction:(void (^)(void))cancleAction withPlayAction:(void (^)(NSString *content))playAction withDownLoadAction:(void (^)(NSString *content))downLoadAction{
    __block NTVideoParseView *view = [[NSBundle mainBundle] loadNibNamed:@"NTWarnView" owner:nil options:nil][1];
    view.urlPath = path;
    [view parseWebView];
    view.cancleAction = ^{
        !cancleAction ? : cancleAction();
        [UIView animateWithDuration:0.15
                         animations:^{
                             view.alpha = 0.0;
                         }
                         completion:^(BOOL finished) {
                             if (finished) {
                                 [view removeFromSuperview];
                                 view = nil;
                             }
                         }];
    };
    view.playAction = ^(NSString * _Nonnull content) {
        !playAction ? : playAction(content);
        [UIView animateWithDuration:0.15
                         animations:^{
                             view.alpha = 0.0;
                         }
                         completion:^(BOOL finished) {
                             if (finished) {
                                 [view removeFromSuperview];
                                 view = nil;
                             }
                         }];
        
    };
    view.downLoadAction = ^(NSString * _Nonnull content) {
        !downLoadAction ? : downLoadAction(content);
        [UIView animateWithDuration:0.15
                         animations:^{
                             view.alpha = 0.0;
                         }
                         completion:^(BOOL finished) {
                             if (finished) {
                                 [view removeFromSuperview];
                                 view = nil;
                             }
                         }];
        
    };
    UIWindow *window = [UIApplication sharedApplication].windows[0];
    [window addSubview:view];
    view.frame = window.bounds;
    view.alpha = 0;
    [UIView animateWithDuration:0.15
                     animations:^{
                         view.alpha = 1.0;
                     }
                     completion:^(BOOL finished){
                     }];
}

@end
