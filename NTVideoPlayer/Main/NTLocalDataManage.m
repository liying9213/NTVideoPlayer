//
//  NTLocalDataManage.m
//  NTVideoPlayer
//
//  Created by 李莹 on 2019/1/15.
//  Copyright © 2019 liying. All rights reserved.
//

#import "NTLocalDataManage.h"

@implementation NTLocalDataManage

+ (NSArray *)getHomeData{
    NSDictionary * homeData = [self getLocalDataWithName:@"NTHomeData"];
    return homeData[@"home"];
}

+ (NSArray *)getParseData{
    NSDictionary * homeData = [self getLocalDataWithName:@"NTHomeData"];
    return homeData[@"parsePath"];
}

+ (NSDictionary *)getLocalDataWithName:(NSString *)name{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    NSDictionary *homeData = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    return homeData;
}

@end
