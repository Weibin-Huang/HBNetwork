//
//  HBNetworkQueue.h
//  HBNetwork_Demo
//
//  Created by AlanWong on 15/10/27.
//  Copyright © 2015年 AlanWong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HBNetworkRequest.h"
@interface HBNetworkQueue : NSObject
@property (nonatomic,strong) NSMutableArray * requestArray;
@property (nonatomic,strong) NSOperationQueue * operationQueue;

+ (HBNetworkQueue *)sharedInstance;
- (void)startRequet:(HBNetworkRequest *)request;
- (void)isRequesting:(HBNetworkRequest *)request;
- (void)cancelRequet:(HBNetworkRequest *)request;
- (void)cancelAllRequets;
@end
