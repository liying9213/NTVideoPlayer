//
//  NTVideoParseManage.m
//  NTVideoPlayer
//
//  Created by 李莹 on 2019/1/14.
//  Copyright © 2019 liying. All rights reserved.
//

#import "NTVideoParseManage.h"
#import "NTRequestManager.h"
#import <extobjc.h>

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
    [self getData:[self getParsePath:path]];
}

- (NSString *)getParsePath:(NSString *)path{
//    return [NSString stringWithFormat:@"http://www.sjzvip.com/jiexi1.php?url=%@",path];
    return [NSString stringWithFormat:@"http://www.1717yun.com/jx/ty.php?url=%@",path];
    
}

- (void)getData:(NSString *)path{
    @weakify(self)
    [NTRequestManager getSessionWithHtmlURL:path params:nil block:^(NSError *error, NSDictionary *response) {
        @strongify(self)
        !self.parseBlock ? : self.parseBlock(response);
    }];
}

@end
