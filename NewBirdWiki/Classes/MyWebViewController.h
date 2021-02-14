//
//  MyWebViewController.h
//  NewBirdWiki
//
//  Created by Luke on 25/02/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyWebViewController : UIViewController <UIWebViewDelegate> {
	UIWebView *webView;
	NSString *suffix;
	NSString *birdName;
	NSString *latin;
	BOOL isWiki;
	IBOutlet UIActivityIndicatorView *activityIndicator; 
}

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) NSString *suffix;
@property (nonatomic, retain) NSString *birdName;
@property (nonatomic, retain) NSString *latin;
@property BOOL isWiki;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;

- (IBAction)addTapped:(id)sender;
- (IBAction)backTapped:(id)sender;
- (IBAction)forwardTapped:(id)sender;
- (IBAction)reloadTapped:(id)sender;

@end
