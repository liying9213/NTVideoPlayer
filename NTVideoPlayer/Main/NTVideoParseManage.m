//
//  NTVideoParseManage.m
//  NTVideoPlayer
//
//  Created by 李莹 on 2019/1/14.
//  Copyright © 2019 liying. All rights reserved.
//

#import "NTVideoParseManage.h"
#import "NTRequestManager.h"

static NTVideoParseManage * parseManager = nil;
@implementation NTVideoParseManage

+ (NTVideoParseManage *)shareManager{
    @synchronized(self){
        if (parseManager == nil) {
            parseManager = [[NTVideoParseManage  alloc] init];
        }
    }
    return parseManager;
}

- (void)videoParseWithPath:(NSString *)path withResult:(void(^)(NSDictionary *parseResult))parseblock{
    self.parseBlock = parseblock;
}


@end
