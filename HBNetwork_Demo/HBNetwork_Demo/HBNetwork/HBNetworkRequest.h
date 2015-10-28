//
//  HBNetworkRequest.h
//  HBNetwork_Demo
//
//  Created by AlanWong on 15/10/27.
//  Copyright © 2015年 AlanWong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HBNetworkResponse.h"
@class HBNetworkRequest;

typedef HBNetworkRequest * (^HBNetworkRequestBlock)(id key, ...);
typedef void (^HBNetworkRequestFinishedBlock)( HBNetworkRequest * req );
typedef void (^HBNetworkRequestUpdateProgressBlock)( HBNetworkRequest * req );
typedef void (^HBNetworkRequestDownloadProgressBlock)( HBNetworkRequest * req );

typedef NS_ENUM(NSInteger,HBNetworkRequestSerializer){
    HBNetworkRequestSerializerDefault      = 0,
    HBNetworkRequestSerializerJSON         = 1,
    HBNetworkRequestSerializerPropertyList = 2,
};

typedef NS_ENUM(NSInteger,HBNetworkResponseSerializer){
    HBNetworkResponseSerializerDefault      = 0,
    HBNetworkResponseSerializerXML          = 1,
    HBNetworkResponseSerializerPropertyList = 2,
    HBNetworkResponseSerializerImageLoader  = 3,
};

@interface HBNetworkRequest : NSObject

@property (nonatomic, readonly) HBNetworkRequestBlock header;
@property (nonatomic, readonly) HBNetworkRequestBlock body;
@property (nonatomic, readonly) HBNetworkRequestBlock param;
@property (nonatomic, readonly) HBNetworkRequestBlock file;

@property (nonatomic, readonly) long long bytesRead;
@property (nonatomic, readonly) long long bytesReadTotal;
@property (nonatomic, readonly) long long bytesWritten;
@property (nonatomic, readonly) long long bytesWrittenTotal;

@property (nonatomic, readonly) id responseObject;
@property (nonatomic, strong, readwrite) HBNetworkResponse * response;

@property (nonatomic, copy, readwrite) HBNetworkRequestFinishedBlock         finishedBlcok;
@property (nonatomic, copy, readwrite) HBNetworkRequestUpdateProgressBlock   updateProgressBlock;
@property (nonatomic, copy, readwrite) HBNetworkRequestDownloadProgressBlock downloadProgressBlock;

@property (nonatomic, copy) NSString * httpMethod;
@property (nonatomic, copy) NSString * baseUrl;
@property (nonatomic, strong) NSURL * requestUrl;
@property (nonatomic, assign) BOOL encodingParamsInURI;
@property (nonatomic, assign) HBNetworkRequestSerializer requestSerializer;
@property (nonatomic, assign) HBNetworkResponseSerializer responseSerializer;

+ (HBNetworkRequest *)requestWithRequest:(NSURLRequest *)request;
+ (HBNetworkRequest *)requestWithURLString:(NSString *)URLString;
+ (HBNetworkRequest *)requestWithURLString:(NSString *)URLString
                             completeBlock:(HBNetworkRequestFinishedBlock)completeBlock;
@end
