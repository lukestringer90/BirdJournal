//
//  RootViewController.m
//  NewBirdWiki
//
//  Created by Luke on 25/02/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import "RootViewController.h"
#import "AllBirdsViewController.h"


@implementation RootViewController
@synthesize allBirdsCell;
@synthesize birdGroupsCell;
@synthesize favouritesCell;
@synthesize allBirdsController;

#pragma mark -
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
	// Set the view title
	self.title = @"Bird Index";
	// Set the table cell labels
	[self.allBirdsCell setText:@"All Birds"];
	[self.birdGroupsCell setText:@"All Bird Groups"];
	[self.favouritesCell setText:@"Favourited Birds"];
	
    [super viewDidLoad];
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
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
    return favouritesCell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// All birds selected	
	if (indexPath.section == 0) {
		self.allBirdsController = [[AllBirdsViewController alloc] init];
		[self.navigationController pushViewController:self.allBirdsController animated:YES];
	}
	
	// Groups selected
	if (indexPath.section == 1) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Groups"
														message:@"Not yet implemented" 
													   delegate:self 
											  cancelButtonTitle:@"Dismiss" 
											  otherButtonTitles:nil];
		[alert show]; 
		[alert release];
		[self.birdGroupsCell setSelected:NO];
	}
	
	// Favourites selected
	if (indexPath.section == 2) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Favourites"
														message:@"Not yet implemented" 
													   delegate:self 
											  cancelButtonTitle:@"Dismiss" 
											  otherButtonTitles:nil];
		[alert show]; 
		[alert release];
		[self.favouritesCell setSelected:NO];
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
	[allBirdsController release];//
    [super dealloc];
}


@end

