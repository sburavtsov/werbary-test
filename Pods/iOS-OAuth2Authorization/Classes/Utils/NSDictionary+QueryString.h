//
//  NSDictionary+QueryString.h
//  OAuthClient
//
//  Created by daemmon on 6/28/15.
//  Copyright (c) 2015 daemmon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (QueryString)
+ (NSDictionary *)dictionaryWithQueryString:(NSString *)queryString;
- (NSString *)queryStringValue;
@end
