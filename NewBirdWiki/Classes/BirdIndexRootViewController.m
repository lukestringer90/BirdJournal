//
//  RootViewController.m
//  NewBirdWiki
//
//  Created by Luke on 25/02/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import "BirdIndexRootViewController.h"
#import "AllBirdsViewController.h"
#import "AllGroupsViewController.h"


@implementation BirdIndexRootViewController
@synthesize allBirdsCell;
@synthesize birdGroupsCell;
@synthesize favouritesCell;
@synthesize searchBirdsCell;
@synthesize allBirdsViewController;
@synthesize allGroupsViewController;
@synthesize searchBirdIndexViewController;
@synthesize favouriteBirdsViewController;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
	// Set the view title
	self.title = @"Bird Index";
	// Set the table cell labels
    self.allBirdsCell.textLabel.text = @"All Birds";
    self.birdGroupsCell.textLabel.text = @"Bird Groups";
    self.favouritesCell.textLabel.text = @"Favourite Birds";
    self.searchBirdsCell.textLabel.text = @"Search For A Bird";
    
	[super viewDidLoad];
	
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	if (indexPath.section == 0) {
        return allBirdsCell;
    }
    if (indexPath.section == 1) {
        return birdGroupsCell;
    }
	if (indexPath.section == 2) {
        return searchBirdsCell;
    }
    return favouritesCell;
}
	
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
	if (section == 3) {
		return @"Find a bird from within Bird Index. Then tap the add button in the top right corner to add a sighting of that bird to the Journal.";
	}
	else {
		return nil;
	}
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// All birds selected	
	if (indexPath.section == 0) {
		self.allBirdsViewController = [[AllBirdsViewController alloc] init];
		[self.navigationController pushViewController:self.allBirdsViewController animated:YES];
	}
	
	// Groups selected
	if (indexPath.section == 1) {
		self.allGroupsViewController = [[AllGroupsViewController alloc] init];
		[self.navigationController pushViewController:self.allGroupsViewController animated:YES];
	}
	// Search selected
	if (indexPath.section == 2) {
		SearchBirdIndexViewController *nextController = [[SearchBirdIndexViewController alloc] initWithNibName:@"SearchBirdIndexViewController" bundle:nil];
		self.searchBirdIndexViewController = nextController;
		[self.navigationController pushViewController:nextController animated:YES];
		[nextController release];
	}	
	// Favourites selected
	if (indexPath.section == 3) {
		self.favouriteBirdsViewController = [[FavouriteBirdsViewController alloc] init];;
		[self.navigationController pushViewController:self.favouriteBirdsViewController animated:YES];
		
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
	self.allBirdsCell = nil;
	self.birdGroupsCell = nil;
	self.favouritesCell = nil;
}


- (void)dealloc {
	[allBirdsCell release];
	[birdGroupsCell release];
	[favouritesCell release];
	[allBirdsViewController release];
	[allGroupsViewController release];
	[searchBirdIndexViewController release];
	[favouriteBirdsViewController release];
    [super dealloc];
}


@end

