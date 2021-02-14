//
//  SearchBirdIndexViewController.h
//  NewBirdWiki
//
//  Created by Luke on 01/04/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OverlayViewController.h"
#import "SummarisedWikiViewController.h"

@class OverlayViewController;

@interface SearchBirdIndexViewController : UIViewController 
<UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate> {
	NSMutableArray *listOfItems;
	NSMutableArray *copyListOfItems;
	NSDictionary *birdsDict;
	BOOL searching;
	BOOL letUserSelectRow;
	BOOL navigatedToBird;
	
	OverlayViewController *ovController;
	SummarisedWikiViewController *nextController;
	
	IBOutlet UISearchBar *searchBar;
	IBOutlet UITableView *birdsTableView;
}
@property (nonatomic, retain) NSMutableArray *listOfItems;
@property (nonatomic, retain) NSMutableArray *copyListOfItems;
@property (nonatomic, retain) NSDictionary *birdsDict;
@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;
@property (nonatomic, retain) IBOutlet UITableView *birdsTableView;;

@property (nonatomic, retain) OverlayViewController *ovController;
@property (nonatomic, retain) SummarisedWikiViewController *nextController;

- (void) searchTableView;
- (void) resetTapped:(id)sender;

@end
