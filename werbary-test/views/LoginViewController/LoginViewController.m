//
//  LoginViewController.m
//  werbary-test
//
//  Created by Sergey Buravtsov on 8/16/15.
//  Copyright (c) 2015 Sergey Buravtsov. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) id <OA2Provider> provider;
@property (copy, nonatomic) OA2AuthorizationSuccess successCallBack;
@property (copy, nonatomic) OA2AuthorizationError errorCallBack;

@end

@implementation LoginViewController

+(NSString *)segueToIdentifier {
    
    return @"segueToLoginViewController";
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.webView setDelegate:self];
    
}

- (IBAction)cancelDidTap:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) setProvider:(id<OA2Provider>)provider success:(OA2AuthorizationSuccess)success error:(OA2AuthorizationError)error {
    
    [self setProvider:provider];
    [self setSuccessCallBack:success];
    [self setErrorCallBack:error];
}

-(void)startURLHandling {
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[_provider authorizeURL]]];
}


#pragma mark - WebView Delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSURL *requestURL = [request URL];
    
    if ([requestURL.absoluteString hasPrefix:self.provider.redirectURLString]) {

        [self stopWebView];
        [self successCallBack](requestURL);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    return YES;
}

-(void) stopWebView {
    
    [self.webView stopLoading];
    [self.webView setDelegate:nil];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [self stopWebView];
    [self errorCallBack](error);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
