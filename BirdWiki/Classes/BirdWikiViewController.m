//
//  ThirdLevelViewController.m
//  WikiDataLoaderNav
//
//  Created by Luke on 05/11/2010.
//  Copyright 2010 Luke Stringer Inc. All rights reserved.
//

#import "BirdWikiViewController.h"
#import "MyWebViewController.h"


@implementation BirdWikiViewController
@synthesize webView;
@synthesize suffix;
@synthesize latin;
@synthesize loadCount;

- (void)viewDidLoad {
	
	loadCount = 0;
//	-- Uncomment for actual page loading 
	NSMutableString *pathString = [NSMutableString stringWithFormat:@"%@.html", self.suffix];
	NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:pathString];
	NSString *htmlContent = [NSString stringWithContentsOfFile:path];
	NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
	[webView loadHTMLString:htmlContent baseURL:url];
	

//	-- Uncomment to diable webpage loading
//	NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
//	[webView loadHTMLString:self.suffix baseURL:url];

	
	// Add action button
	UIBarButtonItem *actionButton = [[UIBarButtonItem alloc] 
									 initWithBarButtonSystemItem:UIBarButtonSystemItemAction  
									 target:self 
									 action:@selector(actionPressed:)];
	self.navigationItem.rightBarButtonItem = actionButton;
	[actionButton release];
	
	// Set the summary button text
	self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Summary"
																			  style:UIBarButtonItemStylePlain target:nil 
																			 action:nil] autorelease];
	
	
	
	[super viewDidLoad];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	if (loadCount == 0) {
		loadCount++;
		return YES;
	}
	return NO;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)actionPressed:(id)sender {
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil 
															 delegate:self 
													cancelButtonTitle:@"Cancel" 
											   destructiveButtonTitle:nil 
													otherButtonTitles:@"Add Sighting", @"Full Wikipedia Page", @"Browse Flickr Photos",  nil];
	[actionSheet showInView:self.view]; 
	[actionSheet release];
}

// ActionSheet Delegate Methods
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {

	// Wikipedia option
	if(buttonIndex == 1){
		MyWebViewController *nextController = [[MyWebViewController alloc] init];
		nextController.suffix = self.suffix;
		nextController.isWiki = TRUE;
		nextController.title = @"Full Wikipedia";
		[self.navigationController pushViewController:nextController animated:YES];
	}
	
	// Flickr option
	else if(buttonIndex == 2){
		MyWebViewController *nextController = [[MyWebViewController alloc] init];
		nextController.suffix = self.suffix;
		nextController.latin = self.latin;
		nextController.isWiki = FALSE;
		nextController.title = @"Flickr Images";
		[self.navigationController pushViewController:nextController animated:YES];
	}
	
}

- (void)dealloc {
    [super dealloc];
}


@end
