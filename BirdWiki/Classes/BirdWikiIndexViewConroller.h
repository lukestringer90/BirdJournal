//
//  FirstLevelViewController.h
//  WikidataLoader
//
//  Created by Luke on 31/10/2010.
//  Copyright 2010 Luke Stringer Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BirdWikiIndexViewConroller : UITableViewController 
<UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>{
	NSArray *controllers;
	NSArray *groupDictList;
}
@property (nonatomic, retain) NSArray *controllers;
@property (nonatomic, retain) NSArray *groupDictList;

- (IBAction)viewPressed:(id)sender;
- (void)addControllers:(NSString *)viewTitle;

@end
