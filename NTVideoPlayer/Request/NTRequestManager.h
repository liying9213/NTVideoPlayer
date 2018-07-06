//
//  NTRequestManager.h
//  NTVideoPlayer
//
//  Created by 李莹 on 2018/7/6.
//  Copyright © 2018年 liying. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
typedef enum{
    /**
     * Content-Type:application/json
     */
    HYDEContentTypeJson = 0 ,
    /**
     * Content-Type:application/x-plist.
     */
    HYDEContentTypePlist = 1,
    /**
     * Content-Type:application/x-www-form-urlencoded.
     */
    HYDEContentTypeUrlencoded = 2,
    
} HYDEContentType;

typedef void(^ResponseBlock)(NSError *error, NSDictionary *response);

@interface NTRequestManager : NSObject
/**
 get请求
 
 @param url 地址
 @param params 参数
 @param block 回调
 */
+ (void)getSessionWithURL:(NSString *)url params:(NSDictionary *)params block:(ResponseBlock)block;

/**
 post请求
 
 @param url 地址
 @param params 参数
 @param contentType content-Type类型
 @param block 回调
 */
+ (void)postSessionWithURL:(NSString *)url params:(NSDictionary *)params contentType:(HYDEContentType)contentType block:(ResponseBlock)block;


/**
 get同步请求
 
 @param url 地址
 @param params 参数
 @param block 回调
 */
+ (void)startSynchronousGetWithURL:(NSString *)url params:(NSDictionary *)params block:(ResponseBlock)block;

/**
 post同步请求
 
 @param url 地址
 @param params 参数
 @param block 回调
 */
+ (void)startSynchronousPostWithURL:(NSString *)url params:(NSDictionary *)params block:(ResponseBlock)block;

/**
 文件上传
 
 @param urlPath 地址
 @param filePath 文件地址
 @param type 文件类型
 @param params 参数
 @param block 回调
 */
+ (void)uploadWithURL:(NSString *)urlPath withFilePath:(NSString *)filePath withType:(NSString *)type params:(NSDictionary *)params block:(ResponseBlock)block;

/**
 文件上传(formData)
 
 @param urlPath 地址
 @param fileData 文件Data
 @param type 文件类型
 @param params 参数
 @param block 回调
 */
+ (void)uploadFileWithURL:(NSString *)urlPath withFileData:(NSData *)fileData withType:(NSString *)type params:(NSDictionary *)params block:(ResponseBlock)block;

@end
