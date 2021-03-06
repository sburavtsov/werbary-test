//
//  InstagramDataProvider.m
//  werbary-test
//
//  Created by Sergey Buravtsov on 8/17/15.
//  Copyright (c) 2015 Sergey Buravtsov. All rights reserved.
//

#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "InstagramDataProvider.h"

@interface InstagramDataProvider ()
@property (strong, nonatomic) NSString *accessToken;
@property (strong, atomic) NSMutableArray *imagesData;
@property (strong, nonatomic) NSNumber *userMediaCount;
@end

@implementation InstagramDataProvider

-(void)obtainMediaCount {

    NSDictionary *params = @{@"access_token":self.accessToken};
    [[AFHTTPRequestOperationManager manager] GET:@"https://api.instagram.com/v1/users/self/"
                                      parameters:params
                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                             
                                             NSDictionary *responseDictionary = responseObject;
                                             NSNumber *retCode = responseDictionary[@"meta"][@"code"];
                                             
                                             if (200 == retCode.integerValue) {
                                                 
                                                 self.userMediaCount = (NSNumber *)responseDictionary[@"data"][@"counts"][@"media"];
                                                 [self obtainPhotosDataInternal];
                                             }
                                             
                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                             
                                         }];
    
}

-(void)obtainPhotosDataInternal {

    [self obtainPhotosData:@"" ];
}

-(void)obtainPhotosData {
    
    self.imagesData = [[NSMutableArray alloc] init];
    [self obtainMediaCount];
}

-(void)obtainPhotosData:(NSString *)nextMaxID {
    
    NSDictionary *params = @{@"access_token":self.accessToken,
                             @"count":self.userMediaCount,
                             @"max_id":nextMaxID};
    
    [[AFHTTPRequestOperationManager manager] GET:@"https://api.instagram.com/v1/users/self/media/recent/"
                                      parameters:params
                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
         NSDictionary *responseDictionary = responseObject;
         
         NSNumber *retCode = responseDictionary[@"meta"][@"code"];
        
         if (200 == retCode.integerValue) {
             
             NSArray *mediaData = responseDictionary[@"data"];
             
             for (NSDictionary *mediaDictionary in mediaData) {
                 
                 if ([mediaDictionary[@"type"] isEqualToString:@"image"]) {
                     
                     NSString *imageURL = mediaDictionary[@"images"][@"standard_resolution"][@"url"];
                     NSNumber *commentsNumber = mediaDictionary[@"comments"][@"count"];
                     
                     [self.imagesData addObject:@{@"url":imageURL,
                                                  @"comments_number":commentsNumber}];
                 }
             }

             NSDictionary *paginationData = responseDictionary[@"pagination"];
             
             if (paginationData[@"next_max_id"]) {

                 [self obtainPhotosData:paginationData[@"next_max_id"]];
             }
                 
             if ([self.delegate respondsToSelector:@selector(instagramDataProvider:didLoadPhotosData:)]) {
                 
                 [self.delegate instagramDataProvider:self didLoadPhotosData:self.imagesData];
             }
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
     }];
    
}

-(id)initWithAccessToken:(NSString *)accessToken {

    self = [super init];

    if (! self) {
        
        return nil;
    }
    
    _accessToken = accessToken;
    
    return self;
}

@end
