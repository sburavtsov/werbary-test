//
//  OA2Authorization.m
//  OAuthClient
//
//  Created by daemmon on 6/28/15.
//  Copyright (c) 2015 daemmon. All rights reserved.
//

#import "OA2Authorization.h"
#import <UIKit/UIApplication.h>
#import "NSURL+Query.h"
#import "OA2Credentials.h"

static NSString * const URL_HANDLER_DEFAULT_KEY = @"default_url_handler";

@interface OA2Authorization ()
@property(nonatomic) Class urlHandlerClass;
@end


@implementation OA2Authorization

+(OA2Authorization *)authorizationWithProvider:(id <OA2Provider> )provider{
    return [[self alloc] initWithProvider:provider];
}

+(OA2Authorization *)authorizationWithProviders:(NSArray *)providers{
    return [[self alloc] initWithProviders:providers];
}

-(id)initWithProviders:(NSArray *)providers{
    if(self = [super init]){
        _providers = providers;
        _urlHandlerClasses = [[NSDictionary alloc] init];
    }
    return self;
}

-(id)initWithProvider:(id <OA2Provider> )provider{
    return [self initWithProviders:@[provider]];
}

-(id <OA2AuthorizationURLHandler>)authorizeProvider:(NSString *)providerName success:(OA2AuthorizationSuccess)success error:(OA2AuthorizationError)error{
    id <OA2Provider> provider = [self providerForName:providerName];
    id <OA2AuthorizationURLHandler> urlHandler = [[[provider urlHandlerClass] alloc] init];
    [urlHandler setProvider:provider success:^(NSURL *tokenURL) {
        NSDictionary  *query = [tokenURL queryDictionaryValue];
        id <OA2Credentials> credentials = [[provider credentialsClass] credentialsWithQueryDictValue:query];
        success(credentials);
    } error:error];
    return urlHandler;
}

-(id <OA2Provider>)providerForName:(NSString *)name{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.name == %@",name];
    id <OA2Provider> providers = [[[self providers] filteredArrayUsingPredicate:predicate] firstObject];
    return providers;
}





@end
