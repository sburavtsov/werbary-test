//
//  OAuth2Credentials.m
//  werbary-test
//
//  Created by Sergey Buravtsov on 8/16/15.
//  Copyright (c) 2015 Sergey Buravtsov. All rights reserved.
//

#import "OAuth2Credentials.h"

@implementation OAuth2Credentials

+ (instancetype)credentialsWithQueryDictValue:(NSDictionary *)queryDictValue {
    
    return [[self alloc] initWithQueryDictValue:queryDictValue];
}

- (id)initWithQueryDictValue:(NSDictionary *)queryDictValue {
    
    if (self = [super init]) {
        
        _accessToken = queryDictValue[@"access_token"];
        NSTimeInterval expiresInTimeinterval = [queryDictValue[@"expires_in"] integerValue];
        _expiresAt = [NSDate dateWithTimeIntervalSinceNow:expiresInTimeinterval];
    }
    
    return self;
}

@end
