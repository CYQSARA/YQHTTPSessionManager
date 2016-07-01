//
//  YQHTTPSessionManager.m
//  self－AFN框架二次封装
//
//  Created by Cuiyongqin on 16/5/20.
//  Copyright © 2016年 Cuiyongqin. All rights reserved.
//

#import "YQHTTPSessionManager.h"

@protocol YQHTTPProxy <NSObject>

@optional
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;


@end

@interface YQHTTPSessionManager ()<YQHTTPProxy>

@end

@implementation YQHTTPSessionManager

+ (instancetype)sharedTools {
    static YQHTTPSessionManager *tools;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tools = [[self alloc]init];
        tools.responseSerializer.acceptableContentTypes = [tools.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];

    });
    return tools;
}

- (void)requestMethod:(HTTPMethods)method urlString:(NSString *)urlString parameters:(id)parameters finished:(void (^)(id, NSError *))finished {
   NSString *methods = method == GET ? @"GET" : @"POST";
    [[self dataTaskWithHTTPMethod:methods URLString:urlString parameters:parameters uploadProgress:nil downloadProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        finished(responseObject,nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        finished(nil,error);
    }] resume];
}

@end






