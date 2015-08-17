//
//  ViewController.m
//  werbary-test
//
//  Created by Sergey Buravtsov on 8/14/15.
//  Copyright (c) 2015 Sergey Buravtsov. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>
#import "OAuth2Provider.h"
#import "OAuth2Credentials.h"
#import "LoginViewController.h"
#import "ViewController.h"
#import "InstagramDataProvider.h"

@interface ViewController () <InstagramDataProviderDelegate>

@property (strong, nonatomic) InstagramDataProvider *instagramDataProvider;
@property (strong, nonatomic) NSArray *photosData;
@property (assign) NSInteger currentMediaIndex;
@property (weak, nonatomic) IBOutlet UIImageView *userMedia;
@property (weak, nonatomic) IBOutlet UILabel *commentsNumber;
@property (weak, nonatomic) IBOutlet UIButton *prevButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//
//    NSArray *cookies = [cookieStorage cookies];
//    for (NSHTTPCookie *cookie in cookies) {
// 
//        [cookieStorage deleteCookie:cookie];
//    }
}


-(void)obtainAuthorizationToken {
    
    OAuth2Provider * instagramProvider = [[OAuth2Provider alloc] init];
    instagramProvider.clientId = @"7ae4a22df8874c6a82499ce706750d2b";
    instagramProvider.redirectURLString = @"mycustomscheme://oauth/callback/instagram.html";
    instagramProvider.authorizeURLString = @"https://api.instagram.com/oauth/authorize";
    instagramProvider.scope = @"basic";
    instagramProvider.name = @"InstagramOAuthProvider";
    instagramProvider.urlHandlerClass = [LoginViewController class];
    instagramProvider.credentialsClass = [OAuth2Credentials class];
    
    OA2Authorization *authorization = [[OA2Authorization alloc] initWithProvider:instagramProvider];
    
    UIViewController <OA2AuthorizationURLHandler> *urlHandler = (UIViewController <OA2AuthorizationURLHandler> *) [authorization authorizeProvider:@"InstagramOAuthProvider" success:^(id <OA2Credentials> credentials) {
        
        NSLog(@"access token %@",[credentials accessToken]);

        self.instagramDataProvider = [[InstagramDataProvider alloc] initWithAccessToken:[credentials accessToken]];

        [urlHandler dismissViewControllerAnimated:YES completion:nil];
        
    } error:^(NSError *error) {
        
        [urlHandler dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [self presentViewController:urlHandler animated:YES completion:^{
        
        [urlHandler startURLHandling];
    }];
}


-(void)obtainPhotosData {
    
    self.currentMediaIndex = NSNotFound;
    
    [self.instagramDataProvider setDelegate:self];
    
    [self.instagramDataProvider obtainPhotosData];
}

-(void)instagramDataProvider:(InstagramDataProvider *)instagramDataProvider didLoadPhotosData:(NSArray *)photosData {
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"comments_number" ascending:NO];

    self.photosData = [photosData sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]];
    
    [self reloadViewData];
}

-(void)reloadViewData {
 
    if (self.photosData.count) {
        
        self.currentMediaIndex = 0;
        
        [self updateView];

    }
}

-(void)updateView {
    
    NSURL *imageURL = [NSURL URLWithString:self.photosData[self.currentMediaIndex][@"url"]];
    [self.userMedia setImageWithURL:imageURL usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];

    NSNumber *commentsNumber = self.photosData[self.currentMediaIndex][@"comments_number"];
    self.commentsNumber.text = commentsNumber.stringValue;
    
    self.prevButton.enabled = self.currentMediaIndex > 0;
    self.nextButton.enabled = self.currentMediaIndex < self.photosData.count - 1;
}

- (IBAction)prevDidTap:(UIButton *)sender {

    if (self.photosData.count) {
        
        self.currentMediaIndex -= 1;
        
        if (self.currentMediaIndex < 0) {
            
            self.currentMediaIndex = 0;
            sender.enabled = false;
        }
        
        [self updateView];
    }
}

- (IBAction)nextDidTap:(UIButton *)sender {

    if (self.photosData.count) {
        
        self.currentMediaIndex += 1;
        
        if (self.currentMediaIndex >= self.photosData.count) {
            
            self.currentMediaIndex = self.photosData.count - 1;
            sender.enabled = false;
        }
        
        [self updateView];
    }
}

-(void)viewDidAppear:(BOOL)animated {
    
    if (! self.instagramDataProvider) {
        
        [self obtainAuthorizationToken];

    } else {
        
        [self obtainPhotosData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
