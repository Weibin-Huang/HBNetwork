//
//  UIApplication+HBNetwork.h
//  HBNetwork_Demo
//
//  Created by AlanWong on 15/10/27.
//  Copyright © 2015年 AlanWong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (HBNetwork)
-(void)pushActiveNetworkOperation;
-(void)popActiveNetworkOperation;
@end
