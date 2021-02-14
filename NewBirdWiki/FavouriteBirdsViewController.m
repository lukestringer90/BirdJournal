//
//  FavouriteBirdsViewController.m
//  NewBirdWiki
//
//  Created by Luke on 03/04/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import "FavouriteBirdsViewController.h"
#import "SummarisedWikiViewController.h"
#import "DataManager.h"


@implementation FavouriteBirdsViewController
@synthesize controllers;
@synthesize birdNames;


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
	[super viewDidLoad];
	
	// Load the favourited birds
	birdNames = [[NSMutableArray alloc] initWithArray:[[[DataManager sharedDataManager] favBirds] allObjects]];
	
	// Load the plist file
	NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"All" ofType:@"plist"];
	NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
	// Remove unecessary item
	[plistDict removeObjectForKey:@"--Alpha_Keys--"];
	
	NSMutableArray *tempControllers = [[NSMutableArray alloc] init];
	// Loop over the bird groups
	for (NSString *groupName in [plistDict allKeys]){
		NSArray *birdDictList =  [plistDict objectForKey:groupName];
		// Loop over the favourited birds
		for (NSString *name in birdNames){
			for (NSDictionary *currentBirdDict in birdDictList) {
			 	if ([[currentBirdDict objectForKey:@"Common_Name"] isEqualToString:name]) {
					SummarisedWikiViewController *nextController = [[SummarisedWikiViewController alloc] init];
					nextController.suffix = [currentBirdDict valueForKey:@"URL_Suffix"];
					nextController.latin = [currentBirdDict valueForKey:@"Latin_Name"];
					nextController.commonName = name;
					[tempControllers addObject:nextController];
					[nextController release];
				}
			}
		}
	}
	
	// Sort the favourited bird controllers into alphabetically order
	NSSortDescriptor *desc = [[NSSortDescriptor alloc] initWithKey:@"commonName" ascending:YES];
	[tempControllers sortUsingDescriptors:[NSArray arrayWithObject:desc]];
	self.controllers = tempControllers;
	[desc release];
	[tempControllers release];
	
	// Set the title
	self.title = @"Favourites";
	
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Edit"
																			   style:UIBarButtonItemStylePlain
																			  target:self 
																			  action:@selector(toggleEdit:)] autorelease];
	
	[plistDict release];
	
}	

- (void)viewWillDisappear:(BOOL)animated{
	// Update the data store with the sightings (some could have been removed)
	[[[DataManager sharedDataManager] favBirds] removeAllObjects];
	[[[DataManager sharedDataManager] favBirds] addObjectsFromArray:birdNames];
}

- (IBAction)toggleEdit:(id)sender {
	[self.tableView setEditing:!self.tableView.editing animated:YES];
	if (self.tableView.editing){
		self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Done"
																				   style:UIBarButtonItemStyleDone
																				  target:self 
																				  action:@selector(toggleEdit:)] autorelease];
	}
	else{
		self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Edit"
																				   style:UIBarButtonItemStylePlain
																				  target:self 
																				  action:@selector(toggleEdit:)] autorelease];
	}
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [controllers count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
	
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    SummarisedWikiViewController *nextController = [controllers objectAtIndex:row];
	cell.textLabel.text = nextController.commonName;
	cell.textLabel.font = [UIFont systemFontOfSize:20];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView 
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath{
	NSUInteger row = [indexPath row]; 
	[self.birdNames removeObjectAtIndex:row]; 
	[self.controllers removeObjectAtIndex:row];
	[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] 
						  withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger row = [indexPath row];
	
	SummarisedWikiViewController *nextController = [controllers objectAtIndex:row];
	nextController.hidesBottomBarWhenPushed = YES;
	[self.navigationController pushViewController:nextController animated:YES];
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
}


- (void)dealloc {
	[controllers release];
	[birdNames release];
    [super dealloc];
}


@end

