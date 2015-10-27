//
//  UIApplication+HBNetwork.m
//  HBNetwork_Demo
//
//  Created by AlanWong on 15/10/27.
//  Copyright © 2015年 AlanWong. All rights reserved.
//

#import "UIApplication+HBNetwork.h"

static NSUInteger __internalOperationCount = 0;

@implementation UIApplication (HBNetwork)
-(void)pushActiveNetworkOperation{
    @synchronized(self) {
        __internalOperationCount++;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!self.isNetworkActivityIndicatorVisible && __internalOperationCount > 0) {
                self.networkActivityIndicatorVisible = YES;
            }
        });
    }
}

-(void)popActiveNetworkOperation{
    @synchronized(self) {
        if (__internalOperationCount == 0) {
            return;
        }
        __internalOperationCount--;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.isNetworkActivityIndicatorVisible && __internalOperationCount == 0) {
                self.networkActivityIndicatorVisible = NO;
            }
        });
    }
}
@end
