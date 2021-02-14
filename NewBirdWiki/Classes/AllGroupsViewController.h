//
//  AllGroupsViewController.h
//  NewBirdWiki
//
//  Created by Luke on 28/02/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AllGroupsViewController : UITableViewController
<UITableViewDelegate, UITableViewDataSource> {
	
	NSDictionary *controllers;
	NSArray *keys;
	NSArray *groupNames;
	NSDictionary *currentSectionsDict;

}

@property (nonatomic, retain) NSDictionary *controllers;
@property (nonatomic, retain) NSArray *keys;
@property (nonatomic, retain) NSArray *groupNames;
@property (nonatomic, retain) NSDictionary *currentSectionsDict;

@end
