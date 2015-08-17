//
//  OA2Authorization.h
//  OAuthClient
//
//  Created by daemmon on 6/28/15.
//  Copyright (c) 2015 daemmon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OA2AuthorizationURLHandler.h"
#import "OA2Provider.h"


@interface OA2Authorization : NSObject

@property(strong,nonatomic,readonly) NSArray *providers;
@property(strong,nonatomic,readonly) NSDictionary *urlHandlerClasses;


+(OA2Authorization *)authorizationWithProvider:(id <OA2Provider> )provider;
+(OA2Authorization *)authorizationWithProviders:(NSArray *)providers;

-(id)initWithProvider:(id <OA2Provider> )provider;
-(id)initWithProviders:(NSArray *)providers;

-(id <OA2AuthorizationURLHandler>)authorizeProvider:(NSString *)providerName success:(OA2AuthorizationSuccess)success error:(OA2AuthorizationError)error;

-(id <OA2Provider>)providerForName:(NSString *)name;
@end
