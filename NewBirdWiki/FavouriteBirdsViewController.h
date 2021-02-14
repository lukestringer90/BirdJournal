//
//  FavouriteBirdsViewController.h
//  NewBirdWiki
//
//  Created by Luke on 03/04/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FavouriteBirdsViewController : UITableViewController {
	NSMutableArray *controllers;
	NSMutableArray *birdNames;
}

@property (nonatomic, retain) NSMutableArray *controllers;
@property (nonatomic, retain) NSMutableArray *birdNames;

- (IBAction)toggleEdit:(id)sender;

@end
