//
//  NTInputWarnView.h
//  NTVideoPlayer
//
//  Created by 李莹 on 2018/7/6.
//  Copyright © 2018年 liying. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NTInputWarnView : UIView

@property (copy, nonatomic) void(^cancleAction)(void);
@property (copy, nonatomic) void(^sureAction)(NSString *content);

- (void)resetViewWithCancle:(NSString *)cancle withSure:(NSString *)sure withCancleAction:(void (^)(void))cancleAction  withSureAction:(void (^)(NSString *content))sureAction;
@end
