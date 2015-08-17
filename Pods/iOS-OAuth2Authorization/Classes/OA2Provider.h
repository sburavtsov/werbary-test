//
//  OA2Provider.h
//  OAuthClient
//
//  Created by daemmon on 6/28/15.
//  Copyright (c) 2015 daemmon. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol OA2Credentials;
@protocol OA2Provider <NSObject>

-(NSString *)name;
-(NSString *)clientId;
-(NSString *)authorizeURLString;
-(NSURL *)authorizeURL;
-(NSString *)scope;
-(NSString *)redirectURLString;

@property(nonatomic) Class urlHandlerClass;
@property(nonatomic) Class credentialsClass;

@property(strong,nonatomic) id <OA2Credentials> credentials;






@end
