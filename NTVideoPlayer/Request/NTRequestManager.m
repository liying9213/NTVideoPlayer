//
//  NTRequestManager.m
//  NTVideoPlayer
//
//  Created by 李莹 on 2018/7/6.
//  Copyright © 2018年 liying. All rights reserved.
//

#import "NTRequestManager.h"

@implementation NTRequestManager
/**
 get请求
 
 @param url 地址
 @param params 参数
 @param block 回调
 */
+ (void)getSessionWithURL:(NSString *)url params:(NSDictionary *)params block:(ResponseBlock)block{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/text",@"text/plain", @"text/javascript",@"application/x-json",@"text/html", nil];
    session.requestSerializer.timeoutInterval = 10.0f;
    [self addHTTPHeaderFieldwith:session];
    [session GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(nil, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(error,@{@"msg":@"网络连接失败！",@"code":@"-9999"});
    }];
}

/**
 post请求
 
 @param url 地址
 @param params 参数
 @param block 回调
 */
+ (void)postSessionWithURL:(NSString *)url params:(NSDictionary *)params contentType:(HYDEContentType)contentType block:(ResponseBlock)block{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/text",@"text/plain", @"text/javascript",@"application/x-json",@"text/html", nil];
    session.requestSerializer.timeoutInterval = 10.0f;
    session.requestSerializer = contentType == 0 ? [AFJSONRequestSerializer serializer] : contentType == 1 ? [AFPropertyListRequestSerializer serializer] : [AFHTTPRequestSerializer serializer];
    [self addHTTPHeaderFieldwith:session];
    [session POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(nil, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(error,@{@"msg":@"网络连接失败！",@"code":@"-9999"});
    }];
}

/**
 get同步请求
 
 @param url 地址
 @param params 参数
 @param block 回调
 */
+ (void)startSynchronousGetWithURL:(NSString *)urlPath params:(NSDictionary *)params block:(ResponseBlock)block
{
    NSMutableString* paramsString = nil;
    if (params) {
        paramsString = [NSMutableString stringWithString:@""];
        for (NSString* key in [[params allKeys] sortedArrayUsingSelector:@selector(compare:)]) {
            [paramsString appendFormat:@"%@=%@&", key, [self urlEncode:params[key]] ];
        }
        if ([paramsString hasSuffix:@"&"]) {
            paramsString = [[NSMutableString alloc] initWithString: [paramsString substringToIndex: paramsString.length-1]];
        }
    }
    
    NSURL * url =  [NSURL URLWithString:urlPath];
    
    //set the request params
    if (params) {
        
        //add GET params to the query string
        url = [NSURL URLWithString:[NSString stringWithFormat: @"%@%@%@",
                                    [url absoluteString],
                                    [url query] ? @"&" : @"?",
                                    paramsString
                                    ]];
    }
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = 10.0f;
    request.HTTPMethod = @"GET";
    
    NSError *error = nil;
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error) {
        block(error,@{@"msg":@"网络连接失败！",@"code":@"-9999"});
    }
    else{
        NSDictionary * responseObject =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        block(nil,responseObject);
    }
}

/**
 post同步请求
 
 @param url 地址
 @param params 参数
 @param block 回调
 */
+ (void)startSynchronousPostWithURL:(NSString *)url params:(NSDictionary *)params block:(ResponseBlock)block
{
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.timeoutInterval = 10.0f;
    request.HTTPMethod = @"POST";
    NSString *param ;
    
    if ([params.class isSubclassOfClass:NSDictionary.class] && params.allKeys.count>0) {
        for (NSString * key in params.allKeys) {
            if (param) {
                param = [NSString stringWithFormat:@"%@&%@=%@",param,key,params[key]];
            }
            else{
                param = [NSString stringWithFormat:@"%@=%@",key,params[key]];
            }
        }
    }
    
    request.HTTPBody = [param dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error) {
        block(error,@{@"msg":@"网络连接失败！",@"code":@"-9999"});
    }
    else{
        NSDictionary * responseObject =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        block(nil,responseObject);
    }
}


/**
 文件上传(流)
 
 @param urlPath 地址
 @param filePath 文件地址
 @param type 文件类型
 @param params 参数
 @param block 回调
 */
+ (void)uploadWithURL:(NSString *)urlPath withFilePath:(NSString *)filePath withType:(NSString *)type params:(NSDictionary *)params block:(ResponseBlock)block{
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session POST:urlPath parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSURL *url=[NSURL fileURLWithPath:filePath];
        //name是传输的文件的类型
        [formData appendPartWithFileURL:url name:@"file" fileName:[filePath lastPathComponent] mimeType:@"application/octet-stream" error:nil];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(nil,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(error,@{@"msg":@"网络连接失败！",@"code":@"-9999"});
    }];
}


/**
 文件上传(formData)
 
 @param urlPath 地址
 @param fileData 文件Data
 @param type 文件类型
 @param params 参数
 @param block 回调
 */
+ (void)uploadFileWithURL:(NSString *)urlPath withFileData:(NSData *)fileData withType:(NSString *)type params:(NSDictionary *)params block:(ResponseBlock)block{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"multipart/form-data", @"text/json",@"text/text",@"text/plain", @"text/javascript",@"application/x-json",@"text/html",@"multipart/form-data", nil];
    [session POST:urlPath parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:fileData name:@"file" fileName:@"file.jpeg" mimeType:@"image/jpeg"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(nil,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(error,@{@"msg":@"网络连接失败！",@"code":@"-9999"});
    }];
}

+ (void)addHTTPHeaderFieldwith:(AFHTTPSessionManager *)manager{
}

+(NSString*)urlEncode:(id<NSObject>)value
{
    //make sure param is a string
    if ([value isKindOfClass:[NSNumber class]]) {
        value = [(NSNumber*)value stringValue];
    }
    
    NSAssert([value isKindOfClass:[NSString class]], @"request parameters can be only of NSString or NSNumber classes. '%@' is of class %@.", value, [value class]);
    
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                 NULL,
                                                                                 (__bridge CFStringRef) value,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                 kCFStringEncodingUTF8));
}


@end
