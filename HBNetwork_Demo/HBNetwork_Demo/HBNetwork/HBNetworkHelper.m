//
//  HBNetworkHelper.m
//  HBNetwork_Demo
//
//  Created by AlanWong on 15/10/27.
//  Copyright © 2015年 AlanWong. All rights reserved.
//

#import "HBNetworkHelper.h"
#import "HBNetworkConfig.h"
#import "AFNetworkReachabilityManager.h"
#import "NSString+NBNetwork.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>

NSString * const HBNetworkReachabilityChangeNotification = @"HBNetworkReachabilityChangeNotification";

@interface HBNetworkHelper()
@property (nonatomic,strong,readwrite) NSString * ipAddress;
@property (nonatomic,strong,readwrite) NSString * baseUrl;
@property (nonatomic,strong) AFNetworkReachabilityManager * mainServerManager;
@end

@implementation HBNetworkHelper

+ (HBNetworkHelper *)helper{
    static HBNetworkHelper * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        _ipAddress = [self localWifiIPAddress];
        _baseUrl = [HBNetworkConfig defaultConfig].baseUrl;
        [self initMonitor];
    }
    return self;
}

- (void)dealloc{
    [[AFNetworkReachabilityManager sharedManager]stopMonitoring];
    if (_mainServerManager) {
        [_mainServerManager stopMonitoring];
    }
}

- (BOOL)isMoitoringMainServerReachability{
    return _mainServerManager ? YES : NO;
}

-(BOOL)isCurrentReachableToInternet{
    return [[AFNetworkReachabilityManager sharedManager]isReachable];
}

- (BOOL)reachableToInternetOnStatus:(HBNetworkReachabilityStatus)status{
    return status == HBNetworkReachabilityStatusReachableViaWiFi || status == HBNetworkReachabilityStatusReachableViaWWAN;
}

-(void)startMainServerReachabilityMonitor{
    if (_mainServerManager) {
        return;
    }
    struct sockaddr_in address;
    bzero(&address, sizeof(address));
    address.sin_len = sizeof(address);
    address.sin_family = AF_INET;
    address.sin_addr.s_addr = inet_addr([[self.baseUrl absoluteBodyURL] UTF8String]);
    address.sin_port = [self.baseUrl port];
    _mainServerManager = [AFNetworkReachabilityManager managerForAddress:&address];
    __block __weak typeof(self) weakSelf = self;
    [_mainServerManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if ([weakSelf reachableToInternetOnStatus:[weakSelf stausConvertByAFStatus:status]]) {
            weakSelf.baseUrl = [HBNetworkConfig defaultConfig].baseUrl;
            [weakSelf.mainServerManager stopMonitoring];
            weakSelf.mainServerManager = nil;
        }
    }];
    [_mainServerManager startMonitoring];
}

- (void)initMonitor{
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        _ipAddress = [self localWifiIPAddress];
        [[NSNotificationCenter defaultCenter]postNotificationName:HBNetworkReachabilityChangeNotification object:nil userInfo:@{HBNetworkReachabilityStatusUserInfoKey:@([self stausConvertByAFStatus:status])}];
    }];
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
}

-(HBNetworkReachabilityStatus)stausConvertByAFStatus:(AFNetworkReachabilityStatus)status{
    if (status == AFNetworkReachabilityStatusReachableViaWiFi) {
        return HBNetworkReachabilityStatusReachableViaWiFi;
    }
    else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
        return HBNetworkReachabilityStatusReachableViaWWAN;
    }
    else if (status == AFNetworkReachabilityStatusNotReachable){
        return HBNetworkReachabilityStatusNotReachable;
    }
    else{
        return HBNetworkReachabilityStatusUnknown;
    }
}

-(NSString *)localWifiIPAddress{
    BOOL success = NO;
    struct ifaddrs * addrs;
    const struct ifaddrs * cursor;
    success = getifaddrs(&addrs) == 0;
    if (success) {
        cursor = addrs;
        while (cursor != NULL) {
            if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0) {
                NSString * name = [NSString stringWithUTF8String:cursor->ifa_name];
                if([name isEqualToString:@"en0"]){
                    return [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
                }
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    return @"192.169.0.1";
}
@end
