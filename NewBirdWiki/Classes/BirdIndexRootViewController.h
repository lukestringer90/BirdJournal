//
//  RootViewController.h
//  NewBirdWiki
//
//  Created by Luke on 25/02/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllBirdsViewController.h"
#import "AllGroupsViewController.h"
#import "SearchBirdIndexViewController.h"
#import "FavouriteBirdsViewController.h"


@interface BirdIndexRootViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate> {

	UITableViewCell *allBirdsCell;
    UITableViewCell *birdGroupsCell;
    UITableViewCell *favouritesCell;
	UITableViewCell *searchBirdsCell;
	
	AllBirdsViewController *allBirdsViewController;
	AllGroupsViewController *allGroupsViewController;
	SearchBirdIndexViewController *searchBirdIndexViewController;
	FavouriteBirdsViewController *favouriteBirdsViewController;

	
}

@property (nonatomic, retain) AllBirdsViewController *allBirdsViewController;
@property (nonatomic, retain) AllGroupsViewController *allGroupsViewController;
@property (nonatomic, retain) SearchBirdIndexViewController *searchBirdIndexViewController;
@property (nonatomic, retain) FavouriteBirdsViewController *favouriteBirdsViewController;

@property (nonatomic, retain) IBOutlet UITableViewCell *allBirdsCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *birdGroupsCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *favouritesCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *searchBirdsCell;

@end
