//
//  OAuth2Provider.m
//  werbary-test
//
//  Created by Sergey Buravtsov on 8/16/15.
//  Copyright (c) 2015 Sergey Buravtsov. All rights reserved.
//

#import "OAuth2Provider.h"
#import <iOS-OAuth2Authorization/NSURL+Query.h>

@implementation OAuth2Provider

@synthesize credentials = _credentials;
@synthesize urlHandlerClass = _urlHandlerClass;
@synthesize credentialsClass = _credentialsClass;

- (NSURL *)authorizeURL{
    
    NSDictionary *urlQueryDict = @{@"client_id" : _clientId,
                                   @"scope" : _scope,
                                   @"redirect_uri" : _redirectURLString,
                                   @"response_type" : @"token"};
    
    NSURL *url = [NSURL urlWithString:_authorizeURLString query:urlQueryDict];
    
    return url;
}

@end
