//
//  HBNetworkRequest.m
//  HBNetwork_Demo
//
//  Created by AlanWong on 15/10/27.
//  Copyright © 2015年 AlanWong. All rights reserved.
//

#import "HBNetworkRequest.h"
#import "AFNetworking.h"
@interface HBNetworkRequest()
@property (nonatomic,strong) NSMutableDictionary * headers;
@property (nonatomic,strong) NSMutableDictionary * files;
@property (nonatomic,strong) NSData * body;
@property (nonatomic,strong) NSMutableDictionary * params;
@property (nonatomic,strong) NSMutableURLRequest * httpRequest;
@property (nonatomic,strong) NSURL * url;
@property (nonatomic,strong) AFHTTPRequestOperation * httpRequestOperation;
@property (nonatomic,strong) AFHTTPRequestSerializer * httpRequestSerializer;

@property (nonatomic,assign) long long bytesRead;
@property (nonatomic,assign) long long bytesReadTotal;

@property (nonatomic,assign) long long bytesWritten;
@property (nonatomic,assign) long long bytesWrittenTotal;

@end

@implementation HBNetworkRequest

@end
