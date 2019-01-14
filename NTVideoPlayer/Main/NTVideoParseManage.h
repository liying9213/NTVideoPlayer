//
//  NTVideoParseManage.h
//  NTVideoPlayer
//
//  Created by 李莹 on 2019/1/14.
//  Copyright © 2019 liying. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NTVideoParseManage : NSObject

@property (nonatomic, copy) void (^parseBlock)(NSDictionary *parseResult);

+ (NTVideoParseManage *)shareManager;

- (void)videoParseWithPath:(NSString *)path withResult:(void(^)(NSDictionary *parseResult))parseblock;

@end

NS_ASSUME_NONNULL_END
