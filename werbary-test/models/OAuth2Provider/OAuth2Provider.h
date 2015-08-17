//
//  OAuth2Provider.h
//  werbary-test
//
//  Created by Sergey Buravtsov on 8/16/15.
//  Copyright (c) 2015 Sergey Buravtsov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <iOS-OAuth2Authorization/OA2Authorization.h>

@interface OAuth2Provider : NSObject <OA2Provider>

@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *clientId;
@property(strong, nonatomic) NSString *redirectURLString;
@property(strong, nonatomic) NSString *authorizeURLString;
@property(strong, nonatomic) NSString *scope;

@end