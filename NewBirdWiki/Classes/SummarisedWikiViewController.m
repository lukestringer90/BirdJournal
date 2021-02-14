//
//  SummarisedWikiViewController.m
//  NewBirdWiki
//
//  Created by Luke on 25/02/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import "SummarisedWikiViewController.h"
#import "MyWebViewController.h"
#import "BirdIndexRootViewController.h"
#import "DataManager.h"
#import "BirdSighting.h"
#import "AddSightingViewController.h"


@implementation SummarisedWikiViewController
@synthesize webView;
@synthesize suffix;
@synthesize latin;
@synthesize commonName;


- (void)viewDidLoad {
	NSMutableString *pathString = [NSMutableString stringWithFormat:@"%@.html", self.suffix];
	NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:pathString];
	NSString *htmlContent = [NSString stringWithContentsOfFile:path];
	NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
	[webView loadHTMLString:htmlContent baseURL:url];
	
	// Set add button
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  
																			   target:self 
																			   action:@selector(addTapped:)];
	self.navigationItem.rightBarButtonItem = addButton;
	[addButton release];
	
	// Set summary back button for child controllers
	self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Summary"
																			  style:UIBarButtonItemStylePlain target:nil 
																			 action:nil] autorelease];
	
	self.title = self.commonName;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	return YES;
}


# pragma -
# pragma mark Action methods
- (IBAction)actionTapped:(id)sender {
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Find more information from the web." 
															 delegate:self 
													cancelButtonTitle:@"Cancel" 
											   destructiveButtonTitle:nil 
													otherButtonTitles:@"Full Wikipedia Page", @"Browse Flickr Photos",  nil];
	[actionSheet showInView:self.view]; 
	[actionSheet release];
}

- (IBAction)favouriteTapped:(id)sender {
	// Add bird to favourite list
	[[[DataManager sharedDataManager] favBirds] addObject:self.commonName];
	
	// Show verification alert
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Bird Favourited"
													message:@"The bird has been added to the Favourites list" 
												   delegate:self 
										  cancelButtonTitle:@"OK" 
										  otherButtonTitles:nil];
	[alert show]; 
	[alert release];
}

- (IBAction)addTapped:(id)sender {
	AddSightingViewController *addController = [[AddSightingViewController alloc] initWithNibName:@"AddSightingViewController" bundle:nil];
	
	addController.birdName = self.commonName;
	
	UINavigationController *navigationController = 
	[[UINavigationController alloc]	initWithRootViewController:addController]; 
	[self presentModalViewController:navigationController animated:YES];
	
	[navigationController release];
	[addController release];
	
}

# pragma -
# pragma mark Action sheet delegate methods
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
	// Wikipedia option
	if(buttonIndex == 0){
		MyWebViewController *nextController = [[MyWebViewController alloc] init];
		nextController.suffix = self.suffix;
		nextController.birdName = self.commonName;
		nextController.isWiki = TRUE;
		nextController.title = @"Full Wikipedia";
		[self.navigationController pushViewController:nextController animated:YES];
		[nextController release];
	}
	
	// Flickr option
	else if(buttonIndex == 1){
		MyWebViewController *nextController = [[MyWebViewController alloc] init];
		nextController.suffix = self.suffix;
		nextController.latin = self.latin;
		nextController.birdName = self.commonName;
		nextController.isWiki = FALSE;
		nextController.title = @"Flickr Images";
		[self.navigationController pushViewController:nextController animated:YES];
		[nextController release];
	}
	
}	


# pragma -
# pragma mark Memory methods
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	self.webView = nil;
}


- (void)dealloc {
	[suffix release];
	[latin release];
	[commonName release];
    [super dealloc];
}


@end
