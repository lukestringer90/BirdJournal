//
//  SummarisedWikiViewController.h
//  NewBirdWiki
//
//  Created by Luke on 25/02/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SummarisedWikiViewController : UIViewController 
<UIWebViewDelegate, UIActionSheetDelegate> {
	
	UIWebView *webView;
	NSString *suffix;
	NSString *latin;
	NSString *commonName;
	
}

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) NSString *suffix;
@property (nonatomic, retain) NSString *latin;
@property (nonatomic, retain) NSString *commonName;

- (IBAction)actionTapped:(id)sender;
- (IBAction)favouriteTapped:(id)sender;
- (IBAction)addTapped:(id)sender;

@end
