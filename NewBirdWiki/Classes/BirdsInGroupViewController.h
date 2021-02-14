//
//  BirdsInGroupViewController.h
//  NewBirdWiki
//
//  Created by Luke on 28/02/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BirdsInGroupViewController : UITableViewController {
	
	NSArray *controllers;
	NSArray *birdNames;
	NSDictionary *groupDict;

}

@property (nonatomic, retain) NSArray *controllers;
@property (nonatomic, retain) NSArray *birdNames;
@property (nonatomic, retain) NSDictionary *groupDict;

@end
