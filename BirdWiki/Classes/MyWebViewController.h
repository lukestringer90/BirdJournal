//
//  FullWikiWebViewController.h
//  WikiDataLoaderNav
//
//  Created by Luke on 23/02/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyWebViewController : UIViewController <UIWebViewDelegate> {
	UIWebView *webView;
	NSString *suffix;
	NSString *latin;
	BOOL isWiki;
}

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) NSString *suffix;
@property (nonatomic, retain) NSString *latin;
@property BOOL isWiki;

- (IBAction)backButtonTapped:(id)sender;
- (IBAction)forwardButtonTapped:(id)sender;
- (IBAction)reloadButtonTapped:(id)sender;

@end
