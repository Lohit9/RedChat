//
//  TermsView.m
//  MessengerApp
//
//  Created by Eric Schanet on 05.05.15.
//  Copyright (c) 2015 Eric Schanet. All rights reserved.
//

#import "bundle.h"

#import "TermsView.h"

 @interface TermsView()

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
 
@implementation TermsView

@synthesize webView;

 - (void)viewDidLoad
 {
	[super viewDidLoad];
	self.title = @"Terms of Service";
}

 - (void)viewWillAppear:(BOOL)animated
 {
	[super viewWillAppear:animated];
 	webView.frame = self.view.bounds;
 	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:Applications(@"terms.html")]]];
}

@end
