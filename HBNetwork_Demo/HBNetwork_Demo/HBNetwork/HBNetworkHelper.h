//
//  HBNetworkHelper.h
//  HBNetwork_Demo
//
//  Created by AlanWong on 15/10/27.
//  Copyright © 2015年 AlanWong. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const HBNetworkReachabilityChangeNotification;

extern NSString *const HBNetworkReachabilityStatusUserInfoKey; // NSNumber of NSInterger

typedef NS_ENUM(NSInteger,HBNetworkReachabilityStatus) {
    HBNetworkReachabilityStatusUnknown          = -1,
    HBNetworkReachabilityStatusNotReachable     = 0,
    HBNetworkReachabilityStatusReachableViaWWAN = 1,
    HBNetworkReachabilityStatusReachableViaWiFi = 2,
};

@interface HBNetworkHelper : NSObject

+ (HBNetworkHelper *)helper;

- (void)startMainServerReachabilityMonitor;

- (BOOL)isMoitoringMainServerReachability;

- (BOOL)isCurrentReachableToInternet;

- (BOOL)reachableToInternetOnStatus:(HBNetworkReachabilityStatus)status;

@end
