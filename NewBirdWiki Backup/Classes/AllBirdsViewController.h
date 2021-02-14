//
//  AllBirdsViewController.h
//  NewBirdWiki
//
//  Created by Luke on 25/02/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AllBirdsViewController : UITableViewController 
<UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate> {
	
	NSDictionary *controllers;
	NSArray *keys;
	NSDictionary *currentSectionsDict;
	
}

@property (nonatomic, retain) NSDictionary *controllers;
@property (nonatomic, retain) NSArray *keys;
@property (nonatomic, retain) NSDictionary *currentSectionsDict;

- (IBAction)filterTapped:(id)sender;
- (void)setUpControllers:(NSString *)plistName;

@end
