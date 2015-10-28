//
//  NSString+NBNetwork.m
//  HBNetwork_Demo
//
//  Created by AlanWong on 15/10/27.
//  Copyright © 2015年 AlanWong. All rights reserved.
//

#import "NSString+NBNetwork.h"

@implementation NSString (NBNetwork)
- (NSString *)absoluteBodyURL{
    NSURL * url = [NSURL URLWithString:self];
    if ([self length] == 0 || url == nil) {
        return @"";
    }
    NSString * string = [self copy];
    if (url.scheme && url.resourceSpecifier) {
        string = url.resourceSpecifier;
        if ([string hasPrefix:@"//"]) {
            string = [string substringFromIndex:2];
        }
    }
    if (url.port) {
        NSRange range = [string rangeOfString:@([url.port integerValue]).description];
        string = [string substringWithRange:NSMakeRange(0, range.location)];
    }
    NSMutableCharacterSet * characterSet = [NSMutableCharacterSet characterSetWithCharactersInString:@":"];
    [characterSet addCharactersInString:@"/"];
    string = [string stringByTrimmingCharactersInSet:characterSet];
    return string;
}

- (NSInteger)port{
    NSURL * url = [NSURL URLWithString:self];
    return [[url port]integerValue];
}

@end
