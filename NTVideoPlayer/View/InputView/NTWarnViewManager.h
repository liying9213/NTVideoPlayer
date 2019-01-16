//
//  NTWarnViewManager.h
//  NTVideoPlayer
//
//  Created by 李莹 on 2018/7/6.
//  Copyright © 2018年 liying. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTWarnViewManager : NSObject

+(void)showErrorViewWith:(NSString *)error;

+(void)showWarnViewNoImageWith:(NSString *)content;

+(void)showSuccessViewWith:(NSString *)success;

+(void)showStatusViewWith:(NSString *)Status;

+(void)showWaitingView;

+(void)hiddenWaitingView;

+ (void)shoWWarnWithCancle:(NSString *)cancle withSure:(NSString *)sure withCancleAction:(void (^)(void))cancleAction  withSureAction:(void (^)(NSString *content))sureAction;

+ (void)shoWParseWarnWithPath:(NSString *)path withCancleAction:(void (^)(void))cancleAction withPlayAction:(void (^)(NSString *content))playAction withDownLoadAction:(void (^)(NSString *content))downLoadAction;

@end
