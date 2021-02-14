//
//  SecondLevelViewController.h
//  WikidataLoader
//
//  Created by Luke on 31/10/2010.
//  Copyright 2010 Luke Stringer Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BirdsInGroupViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>{
	NSArray *birdDictList;
	NSArray *controllers;
}

@property (nonatomic, retain) NSArray *birdDictList;
@property (nonatomic, retain) NSArray *controllers;

@end
