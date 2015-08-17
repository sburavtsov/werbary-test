//
//  NSURL+Query.h
//  OAuthClient
//
//  Created by daemmon on 6/29/15.
//  Copyright (c) 2015 daemmon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (Query)
+(NSURL *)urlWithString:(NSString *)string query:(NSDictionary *)query;
-(NSDictionary *)queryDictionaryValue;
@end
