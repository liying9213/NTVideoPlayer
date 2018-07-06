//
//  NTWarnViewManager.m
//  NTVideoPlayer
//
//  Created by 李莹 on 2018/7/6.
//  Copyright © 2018年 liying. All rights reserved.
//

#import "NTWarnViewManager.h"
#import "NTInputWarnView.h"

@implementation NTWarnViewManager

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

@end
