//
//  HBNetworkConfig.h
//  HBNetwork_Demo
//
//  Created by AlanWong on 15/10/27.
//  Copyright © 2015年 AlanWong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBNetworkConfig : NSObject
@property (nonatomic,strong) NSString * baseUrl;
@property (nonatomic,strong) NSString * backupUrl;
@property (nonatomic,strong) NSString * isOpenMode;

+ (HBNetworkConfig *)sharedInstance;

@end
