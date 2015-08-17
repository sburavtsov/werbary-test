//
//  OAuth2Credentials.h
//  werbary-test
//
//  Created by Sergey Buravtsov on 8/16/15.
//  Copyright (c) 2015 Sergey Buravtsov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <iOS-OAuth2Authorization/OA2Credentials.h>

@interface OAuth2Credentials : NSObject <OA2Credentials>

@property(strong, nonatomic) NSString *accessToken;
@property(strong, nonatomic) NSDate *expiresAt;

@end
