//
//  NTVideoParseView.h
//  NTVideoPlayer
//
//  Created by 李莹 on 2019/1/16.
//  Copyright © 2019 liying. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NTVideoParseView : UIView

@property (nonatomic, copy) NSString * urlPath;

@property (copy, nonatomic) void(^cancleAction)(void);
@property (copy, nonatomic) void(^playAction)(NSString *content);
@property (copy, nonatomic) void(^downLoadAction)(NSString *content);
- (void)parseWebView;
@end

NS_ASSUME_NONNULL_END
