//
//  HBNetworkQueue.m
//  HBNetwork_Demo
//
//  Created by AlanWong on 15/10/27.
//  Copyright © 2015年 AlanWong. All rights reserved.
//

#import "HBNetworkQueue.h"

@implementation HBNetworkQueue
+ (HBNetworkQueue *)sharedInstance{
    static HBNetworkQueue * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
@end
