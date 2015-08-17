//
//  NSString+URLEncoding.h
//  OAuthClient
//
//  Created by daemmon on 6/28/15.
//  Copyright (c) 2015 daemmon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLEncoding)
- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;
@end
