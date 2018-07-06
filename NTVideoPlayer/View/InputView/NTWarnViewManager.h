//
//  NTWarnViewManager.h
//  NTVideoPlayer
//
//  Created by 李莹 on 2018/7/6.
//  Copyright © 2018年 liying. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTWarnViewManager : NSObject

+ (void)shoWWarnWithCancle:(NSString *)cancle withSure:(NSString *)sure withCancleAction:(void (^)(void))cancleAction  withSureAction:(void (^)(NSString *content))sureAction;

@end
