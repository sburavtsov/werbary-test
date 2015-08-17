//
//  OA2Token.h
//  OAuthClient
//
//  Created by daemmon on 6/29/15.
//  Copyright (c) 2015 daemmon. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OA2Credentials  <NSObject>
+(instancetype)credentialsWithQueryDictValue:(NSDictionary *)queryDictValue;
-(NSString *)accessToken;
-(NSDate *)expiresAt;
@end




