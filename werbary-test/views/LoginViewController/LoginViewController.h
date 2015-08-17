//
//  LoginViewController.h
//  werbary-test
//
//  Created by Sergey Buravtsov on 8/16/15.
//  Copyright (c) 2015 Sergey Buravtsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iOS-OAuth2Authorization/OA2AuthorizationViewController.h>

@interface LoginViewController : UIViewController <OA2AuthorizationURLHandler, UIWebViewDelegate>

+(NSString *) segueToIdentifier;
@end
