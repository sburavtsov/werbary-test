//
//  InstagramDataProvider.h
//  werbary-test
//
//  Created by Sergey Buravtsov on 8/17/15.
//  Copyright (c) 2015 Sergey Buravtsov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class InstagramDataProvider;

@protocol InstagramDataProviderDelegate <NSObject>

@optional
- (void)instagramDataProvider:(InstagramDataProvider *)instagramDataProvider didLoadPhotosData:(NSArray *)photosData;
@end


@interface InstagramDataProvider : NSObject

-(id)initWithAccessToken:(NSString *)accessToken;
-(void)obtainPhotosData;

@property (nonatomic, assign) id <InstagramDataProviderDelegate> delegate;

@end
