//
//  FullWikiWebViewController.m
//  WikiDataLoaderNav
//
//  Created by Luke on 23/02/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import "MyWebViewController.h"


@implementation MyWebViewController
@synthesize webView;
@synthesize suffix;
@synthesize latin;
@synthesize isWiki;



- (void)viewDidLoad {
	if (self.isWiki) {
		NSString *fullURL = [NSString stringWithFormat:@"http://en.m.wikipedia.org/wiki/%@", self.suffix];
		NSLog(@"%@", fullURL);
		NSURLRequest *urlReq = [NSURLRequest requestWithURL:[NSURL URLWithString:fullURL]];
		[webView loadRequest:urlReq];
	}
	else {
		NSString *queryString = [latin stringByReplacingOccurrencesOfString:@" " withString:@"+"];
		NSString *fullURL = 
		[NSString stringWithFormat:@"http://m.flickr.com/search/?w=all&q=%@&m=text", queryString];
		NSLog(@"%@", fullURL);
		NSURLRequest *urlReq = [NSURLRequest requestWithURL:[NSURL URLWithString:fullURL]];
		[webView loadRequest:urlReq];
	}

	
    [super viewDidLoad];
}


- (IBAction)backButtonTapped:(id)sender {
	[self.webView goBack];
}

- (IBAction)forwardButtonTapped:(id)sender {
	[self.webView goForward];
}

- (IBAction)reloadButtonTapped:(id)sender {
	[self.webView reload];
}



- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
	self.webView = nil;
	self.suffix = nil;
    [super viewDidUnload];
}


- (void)dealloc {
    [super dealloc];
}


@end
