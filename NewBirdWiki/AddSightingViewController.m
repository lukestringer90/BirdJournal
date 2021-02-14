//
//  NewSightingViewController.m
//  NewBirdWiki
//
//  Created by Luke on 18/04/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import "AddSightingViewController.h"
#import "DataManager.h"
#import "ChangeNumberSeenViewController.h"
#import "SightingMapViewController.h"

#define kPlaceholderText @"Tap here to add any sighting notes (optional)..."


@implementation AddSightingViewController
@synthesize nameCell;
@synthesize countCell;
@synthesize dateCell;
@synthesize locationCell;
@synthesize notesCell;
@synthesize sighting;
@synthesize notesField;
@synthesize birdName;

#pragma mark -
#pragma mark View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

	// Create the sighting 
    sighting = [[BirdSighting alloc] initWithBirdName:self.birdName 
											timesSeen:1];
	
	// Use this ivar to temp store the number seen while finalising the sighting
	[DataManager sharedDataManager].tempCountStore = 1;
	
	// Set up the cells
	nameCell.textLabel.text = sighting.birdName;
	nameCell.font = [UIFont boldSystemFontOfSize:20];
	dateCell.textLabel.text = [NSString stringWithFormat:@"Date: %@", [sighting timeString]]; 
	locationCell.textLabel.text = @"View map location";
	
	countCell.textLabel.text = [NSString stringWithFormat:@"Seen count: %d", sighting.numberSeen];
	
	self.title = @"Add Sighting";
	
	// Set the bar buttons button
	UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc] initWithTitle:@"Add" 
																   style:UIBarButtonItemStyleDone 
																  target:self 
																  action:@selector(doneTapped:)] autorelease];
	UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc] initWithTitle:@"Cancel" 
																	  style:UIBarButtonItemStylePlain 
																	 target:self 
																	 action:@selector(cancelTapped:)] autorelease];
	self.navigationItem.rightBarButtonItem = doneButton;
	self.navigationItem.leftBarButtonItem = cancelButton;
	
	// Set back button
	self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back"
																			  style:UIBarButtonItemStylePlain target:nil 
																			 action:nil] autorelease];
	
}

- (void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	countCell.textLabel.text = 
	[NSString stringWithFormat:@"Seen count: %d", [DataManager sharedDataManager].tempCountStore];
}

- (IBAction)doneTapped:(id)sender {
	sighting.numberSeen = [DataManager sharedDataManager].tempCountStore;
	if ([notesField.text isEqualToString:kPlaceholderText]) {
		sighting.notes = nil;
	}
	else {
		sighting.notes = notesField.text;
	}

	[[[DataManager sharedDataManager] sightings] addObject:sighting];
	[DataManager sharedDataManager].tempCountStore = 1;
	[self dismissModalViewControllerAnimated:YES]; 
}

- (IBAction)cancelTapped:(id)sender {
	[DataManager sharedDataManager].tempCountStore = 1;
	[self dismissModalViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark Scrollview delegate method
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	[notesField resignFirstResponder];
}

#pragma mark -
#pragma mark Text view delegate methods
- (void)textViewDidEndEditing:(UITextView *)textView {
	if ([notesField.text isEqualToString:@""]) {
		notesField.text = kPlaceholderText;
	}
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
	if ([textView.text isEqualToString:kPlaceholderText]) {
		textView.text = @"";
	}	
	return YES;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
		case 0:
			return 3;
			break;
		case 1:
			return 2;
			break;

	}
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
			return nameCell;
		}
		if (indexPath.row == 1) {
			return dateCell;
		}
		return locationCell;
    }
    if (indexPath.section == 1) {		
		if (indexPath.row == 0) {
			return countCell;
		}
		return notesCell;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (section == 1) {
		return @"Editable data";
	}
	else {
		return nil;
	}

}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
	if (section == 1) {
		return @"Tap Add to add the sighting to the journal";
	}
	else {
		return nil;
	}
	
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Cells that should just be deselected
	if (indexPath.section == 0) {
		if (indexPath.row == 0) {
			nameCell.selected = NO;
		}
		if (indexPath.row == 1) {
			dateCell.selected = NO;
		}
		
		// Map cell
		if (indexPath.row == 2) {
			SightingMapViewController *mapController = [[SightingMapViewController alloc] init];
			mapController.sighting = sighting;
			mapController.usedForExisting = NO;
			[self.navigationController pushViewController:mapController animated:YES];
			[mapController release];
		}
	}
	
	// Selected count cell
	if (indexPath.section == 1 && indexPath.row == 0) {
		ChangeNumberSeenViewController *nextController = [[ChangeNumberSeenViewController alloc] initWithNibName:@"ChangeNumberSeenViewController" bundle:nil];
		[self.navigationController pushViewController:nextController animated:YES];
		[nextController release];
	}

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	if (indexPath.section == 1) {
		if (indexPath.row == 1) {
			return 122;
		}
	}
	
	return 44;
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    nameCell = nil;
	countCell = nil;
	dateCell = nil;
	locationCell = nil;
	notesCell = nil;
}


- (void)dealloc {
	[nameCell release];
	[countCell release];
	[dateCell release];
	[locationCell release];
	[notesCell release];
	[notesField release];
	[sighting release];
	[birdName release];
    [super dealloc];
}


@end

