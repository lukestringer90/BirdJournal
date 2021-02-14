//
//  SummarisedWikiViewController.m
//  NewBirdWiki
//
//  Created by Luke on 25/02/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import "SummarisedWikiViewController.h"
#import "MyWebViewController.h"


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
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] 
									 initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  
									 target:self 
									 action:@selector(addTapped:)];
	self.navigationItem.rightBarButtonItem = addButton;
	[addButton release];
	
	// Set summary button
	self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Summary"
																			  style:UIBarButtonItemStylePlain target:nil 
																			 action:nil] autorelease];
	
	self.title = self.commonName;
	[super viewDidLoad];
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
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Favourite Bird"
													message:@"Not yet implemented" 
												   delegate:self 
										  cancelButtonTitle:@"Dismiss" 
										  otherButtonTitles:nil];
	[alert show]; 
	[alert release];
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

# pragma -
# pragma mark Action sheet delegate methods
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
	// Wikipedia option
	if(buttonIndex == 0){
		MyWebViewController *nextController = [[MyWebViewController alloc] init];
		nextController.suffix = self.suffix;
		nextController.isWiki = TRUE;
		nextController.title = @"Full Wikipedia";
		[self.navigationController pushViewController:nextController animated:YES];
	}
	
	// Flickr option
	else if(buttonIndex == 1){
		MyWebViewController *nextController = [[MyWebViewController alloc] init];
		nextController.suffix = self.suffix;
		nextController.latin = self.latin;
		nextController.isWiki = FALSE;
		nextController.title = @"Flickr Images";
		[self.navigationController pushViewController:nextController animated:YES];
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
}


- (void)dealloc {
    [super dealloc];
}


@end
