//
//  YQHTTPSessionManager.h
//  self－AFN框架二次封装
//
//  Created by Cuiyongqin on 16/5/20.
//  Copyright © 2016年 Cuiyongqin. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM(NSUInteger, HTTPMethods) {
    GET,
    POST,
};

@interface YQHTTPSessionManager : AFHTTPSessionManager
+ (instancetype)sharedTools;

- (void) requestMethod: (HTTPMethods)method   urlString: (NSString *)urlString parameters:(id) parameters finished: (void(^)(id responseObject, NSError *error))finished;

@end
