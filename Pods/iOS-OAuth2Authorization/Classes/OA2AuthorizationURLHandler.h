//
//  OA2AuthorizationURLHandler.h
//  OAuthClient
//
//  Created by daemmon on 6/28/15.
//  Copyright (c) 2015 daemmon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OA2AuthorizeCallBacks.h"
#import "OA2Provider.h"

@protocol OA2AuthorizationURLHandler <NSObject>

-(void)setProvider:(id <OA2Provider>)provider success:(OA2AuthorizationSuccess)success error:(OA2AuthorizationError)error;
@optional
-(void)startURLHandling;

@end
