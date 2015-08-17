//
//  NSURL+Query.m
//  OAuthClient
//
//  Created by daemmon on 6/29/15.
//  Copyright (c) 2015 daemmon. All rights reserved.
//

#import "NSURL+Query.h"
#import "NSDictionary+QueryString.h"

@implementation NSURL (Query)

+(NSURL *)urlWithString:(NSString *)string query:(NSDictionary *)query{
    NSString *urlString = [NSString stringWithFormat:@"%@?%@",[string stringByStandardizingPath],[query queryStringValue]];
    return [NSURL URLWithString:urlString];
}

-(NSDictionary *)queryDictionaryValue{
   return [NSDictionary dictionaryWithQueryString:[self queryStringValue]];
}


-(NSString *)queryStringValue{
    NSString *absoluteString = [self absoluteString];
    NSArray *components = nil;

    
    if([(components = [absoluteString componentsSeparatedByString:@"?"]) count] > 1){
        return [components lastObject];
    }
    if([(components = [absoluteString componentsSeparatedByString:@"#"]) count] > 1){
        return [components lastObject];
    }

    return nil;
}




@end
