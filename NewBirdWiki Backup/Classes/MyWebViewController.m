//
//  MyWebViewController.m
//  NewBirdWiki
//
//  Created by Luke on 25/02/2011.
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
		self.title = @"Wikipedia";
		NSString *fullURL = [NSString stringWithFormat:@"http://en.m.wikipedia.org/wiki/%@", self.suffix];
		NSLog(@"%@", fullURL);
		NSURLRequest *urlReq = [NSURLRequest requestWithURL:[NSURL URLWithString:fullURL]];
		[webView loadRequest:urlReq];
	}
	else {
		self.title = @"Flickr";
		NSString *queryString = [latin stringByReplacingOccurrencesOfString:@" " withString:@"+"];
		NSString *fullURL = 
		[NSString stringWithFormat:@"http://m.flickr.com/search/?w=all&q=%@&m=text", queryString];
		NSLog(@"%@", fullURL);
		NSURLRequest *urlReq = [NSURLRequest requestWithURL:[NSURL URLWithString:fullURL]];
		[webView loadRequest:urlReq];
	}
	
	// Set add button
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] 
								  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  
								  target:self 
								  action:@selector(addTapped:)];
	self.navigationItem.rightBarButtonItem = addButton;
	[addButton release];
	
	
    [super viewDidLoad];
}

- (IBAction)addTapped:(id)sender {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add Sighting"
													message:@"Not yet implemented" 
												   delegate:self 
										  cancelButtonTitle:@"Dismiss" 
										  otherButtonTitles:nil];
	[alert show]; 
	[alert release];
}


- (IBAction)backTapped:(id)sender {
	[self.webView goBack];
}

- (IBAction)forwardTapped:(id)sender {
	[self.webView goForward];
}

- (IBAction)reloadTapped:(id)sender {
	[self.webView reload];
}
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
