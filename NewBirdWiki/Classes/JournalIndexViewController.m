//
//  JournalIndexViewController.m
//  NewBirdWiki
//
//  Created by Luke on 01/03/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import "JournalIndexViewController.h"
#import "DataManager.h"
#import "SightingsViewController.h"

@implementation JournalIndexViewController
@synthesize todayCell;
@synthesize historyCell;
@synthesize todayView;
@synthesize historyView;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
	// Set the view title
	self.title = @"Journal Index";
	
	// Set the table cell labels
	[self.todayCell setText:@"Today's Bird Sightings"];
	[self.historyCell setText:@"Sighting History"];
    [super viewDidLoad];
	
	// Set the controllers;
	todayView = [[SightingsViewController alloc] init];
	todayView.hidesBottomBarWhenPushed = YES;
	todayView.title = @"Today";
	todayView.displayingToday = YES;
	
	historyView = [[SightingsViewController alloc] init];
	historyView.hidesBottomBarWhenPushed = YES;
	historyView.displayingToday = NO;
	historyView.title = @"History";
	
	// Set back button
	self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Journal"
																			  style:UIBarButtonItemStylePlain target:nil 
																			 action:nil] autorelease];
}



#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	if (indexPath.section == 0) {
        return todayCell;
    }

    return historyCell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
	if (section == 1) {
		return @"View the bird sightings you have created. Either view the sightings of today, or every sighting added.";
	}
	else {
		return nil;
	}
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// Today selected
	if (indexPath.section == 0) {
		[self.navigationController pushViewController:self.todayView animated:YES];		
	}
	
	// History selected
	if (indexPath.section == 1) {
		[self.navigationController pushViewController:self.historyView animated:YES];	
	}
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
	self.todayCell = nil;
	self.historyCell = nil;
}


- (void)dealloc {
	[todayCell release];
	[historyCell release];
	[todayView release];
	[historyView release];
    [super dealloc];
}


@end

