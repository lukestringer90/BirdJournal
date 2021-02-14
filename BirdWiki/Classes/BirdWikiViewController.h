//
//  ThirdLevelViewController.h
//  WikiDataLoaderNav
//
//  Created by Luke on 05/11/2010.
//  Copyright 2010 Luke Stringer Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BirdWikiViewController : UIViewController <UIWebViewDelegate, UIAlertViewDelegate, UIActionSheetDelegate> {
	UIWebView *webView;
	NSString *suffix;
	NSString *latin;
	int loadCount;
}

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) NSString *suffix;
@property (nonatomic, retain) NSString *latin;
@property int loadCount;

- (IBAction)actionPressed:(id)sender;

@end
