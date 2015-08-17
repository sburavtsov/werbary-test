//
//  OA2BaseURLHandler.m
//  OAuthClient
//
//  Created by daemmon on 6/29/15.
//  Copyright (c) 2015 daemmon. All rights reserved.
//

#import "OA2AuthorizationViewController.h"

@interface OA2AuthorizationViewController () <UIWebViewDelegate>

@property(strong,nonatomic) UIWebView *webView;
@property(strong,nonatomic) id <OA2Provider> provider;
@property(copy,nonatomic) OA2AuthorizationSuccess successCallBack;
@property(copy,nonatomic) OA2AuthorizationError errorCallBack;
@end


@implementation OA2AuthorizationViewController

-(void)loadWebView{
    _webView = [[UIWebView alloc] init];
    [_webView setDelegate:self];
    [_webView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    UIView *parent = [self view];
    [parent addSubview:_webView];
    
    NSLayoutConstraint *leadingWebViewConstraitn = [NSLayoutConstraint constraintWithItem:_webView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0];
    NSLayoutConstraint *topWebViewConstraitn = [NSLayoutConstraint constraintWithItem:_webView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTop multiplier:1.0f constant:0];
    NSLayoutConstraint *trailingWebViewConstraitn = [NSLayoutConstraint constraintWithItem:_webView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0];
    NSLayoutConstraint *bottomWebViewConstraitn = [NSLayoutConstraint constraintWithItem:_webView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0];
    
    [parent addConstraints:@[leadingWebViewConstraitn,topWebViewConstraitn,trailingWebViewConstraitn,bottomWebViewConstraitn]];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    //[self loadWebView];
}


-(void)presentViewControllercompletion:(void(^)())completion{
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:self animated:YES completion:completion];
}

-(void)dismissViewControllerCompletion:(void (^)(void))completion{
   
}

-(void)stopWebView{
    
    [_webView stopLoading];
    [_webView setDelegate:nil];
}

#pragma mark - OA2AuthorizationURLHandler

-(void)setProvider:(id<OA2Provider>)provider success:(OA2AuthorizationSuccess)success error:(OA2AuthorizationError)error{
    [self setProvider:provider];
    [self setSuccessCallBack:success];
    [self setErrorCallBack:error];
}

-(void)startURLHandling{
    [_webView loadRequest:[NSURLRequest requestWithURL:[_provider authorizeURL]]];
}


#pragma mark - WebView Delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSURL *requestURL = [request URL];
    if([[requestURL absoluteString] hasPrefix:[[self provider] redirectURLString]]){
        [self stopWebView];
        [self successCallBack](requestURL);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    return YES;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self stopWebView];
    [self errorCallBack](error);
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
