    //
//  ExistingSightingViewController.m
//  NewBirdWiki
//
//  Created by Luke on 19/04/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import "ExistingSightingViewController.h"
#import "BirdSighting.h"
#import "SightingMapViewController.h"


@implementation ExistingSightingViewController
@synthesize nameCell;
@synthesize countCell;
@synthesize dateCell;
@synthesize locationCell;
@synthesize notesCell;
@synthesize sighting;
@synthesize notesField;

#pragma mark -
#pragma mark View lifecycle
- (void)viewDidLoad {	
	// Set up the cells
	nameCell.textLabel.text = sighting.birdName;
	nameCell.font = [UIFont boldSystemFontOfSize:20];
	dateCell.textLabel.text = [NSString stringWithFormat:@"Date: %@", [sighting timeString]]; 
	locationCell.textLabel.text = @"View map location";
	countCell.textLabel.text = [NSString stringWithFormat:@"Seen count: %d", sighting.numberSeen];
	
	if (!([sighting.notes length] == 0)) {
		hasNotes = YES;
		notesField.text = sighting.notes;
		[notesField setUserInteractionEnabled:NO];
	}
	else {
		hasNotes = NO;
	}
	
	self.title = @"Sighting";
	
	// Set back button
	self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back"
																			  style:UIBarButtonItemStylePlain target:nil 
																			 action:nil] autorelease];
	
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	for (NSIndexPath *indexPath in [(UITableView *)self.view indexPathsForVisibleRows]) {
		[(UITableView *)self.view cellForRowAtIndexPath:indexPath].selected = NO;
	}
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (hasNotes) {
		return 5;	
	}
	else {
		return 4;
	}


}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
		case 0:
			return nameCell;
			break;
		case 1:
			return dateCell;
			break;
		case 2:
			return countCell;
			break;
		case 3:
			return locationCell;
			break;
		case 4:
			return notesCell;
			break;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	if (indexPath.row == 4) {
		return 150;
	}
	
	return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == 3) {
		SightingMapViewController *mapController = [[SightingMapViewController alloc] init];
		mapController.sighting = sighting;
		mapController.usedForExisting = YES;
		[self.navigationController pushViewController:mapController animated:YES];
		[mapController release];
		
	}
	else {
		[tableView cellForRowAtIndexPath:indexPath].selected = NO;
	}

}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
