//
//  JournalIndexViewController.h
//  NewBirdWiki
//
//  Created by Luke on 01/03/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SightingsViewController.h"


@interface JournalIndexViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>{
	IBOutlet UITableViewCell *todayCell;
    IBOutlet UITableViewCell *historyCell;
	
	SightingsViewController *todayView;
	SightingsViewController *historyView;
	
}

@property (nonatomic, retain) IBOutlet UITableViewCell *todayCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *historyCell;

@property (nonatomic, retain) SightingsViewController *todayView;
@property (nonatomic, retain) SightingsViewController *historyView;

@end
