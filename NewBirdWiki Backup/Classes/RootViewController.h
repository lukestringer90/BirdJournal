//
//  RootViewController.h
//  NewBirdWiki
//
//  Created by Luke on 25/02/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllBirdsViewController.h"


@interface RootViewController : UITableViewController <UITableViewDelegate> {

	UITableViewCell *allBirdsCell;
    UITableViewCell *birdGroupsCell;
    UITableViewCell *favouritesCell;
	AllBirdsViewController *allBirdsController;
	
}

@property (nonatomic, retain) AllBirdsViewController *allBirdsController;

@property (nonatomic, retain) IBOutlet UITableViewCell *allBirdsCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *birdGroupsCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *favouritesCell;

@end
