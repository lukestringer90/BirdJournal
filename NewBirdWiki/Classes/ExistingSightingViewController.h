//
//  ExistingSightingViewController.h
//  NewBirdWiki
//
//  Created by Luke on 19/04/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BirdSighting.h"


@interface ExistingSightingViewController : UIViewController {
	IBOutlet UITableViewCell *nameCell;
	IBOutlet UITableViewCell *countCell;
	IBOutlet UITableViewCell *dateCell;
	IBOutlet UITableViewCell *locationCell;
	IBOutlet UITableViewCell *notesCell;
	IBOutlet UITextView *notesField;
	BOOL hasNotes;
	
	BirdSighting *sighting;
}

@property (nonatomic, retain) IBOutlet UITableViewCell *nameCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *countCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *dateCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *locationCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *notesCell;
@property (nonatomic, retain) IBOutlet UITextView *notesField;

@property (nonatomic, retain) BirdSighting *sighting;

@end
