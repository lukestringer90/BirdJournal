//
//  FirstLevelViewController.m
//  WikidataLoader
//
//  Created by Luke on 31/10/2010.
//  Copyright 2010 Luke Stringer Inc. All rights reserved.
//

#import "BirdWikiIndexViewConroller.h"
#import "BirdsInGroupViewController.h"
#import "BirdWikiViewController.h"


@implementation BirdWikiIndexViewConroller
@synthesize controllers;
@synthesize groupDictList;

- (void)viewDidLoad {
	NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"BirdGroupList" ofType:@"plist"];
	NSArray *groupArray = [[NSArray alloc] initWithContentsOfFile:plistPath];
	self.groupDictList = groupArray;
	[groupArray release];
	
	self.title = @"Bird Groups";
	
	[self addControllers:@"Bird Groups"];
	
	
	// Set the back button text
	self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back"
																			  style:UIBarButtonItemStylePlain target:nil 
																			 action:nil] autorelease];
	
	// Set the left button
	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"View" style:UIBarButtonItemStylePlain target:self action:@selector(viewPressed:)] autorelease];
	
	[super viewDidLoad];
}

// Method works out which controllers to add
- (void)addControllers:(NSString *)viewTitle {
	NSMutableArray *controllersArray = [[NSMutableArray alloc] init];
	// If the view needs to show Bird groups
	if ([viewTitle isEqualToString:@"Bird Groups"]) {
		for (NSDictionary *groupDict in self.groupDictList) {
			BirdsInGroupViewController *controller = [[BirdsInGroupViewController alloc] init];
			controller.birdDictList = [groupDict valueForKey:@"Bird_List"];
			controller.title = [groupDict valueForKey:@"Group_Name"];
			[controllersArray addObject:controller];
			[controller release];
		}
	}
	// If the view needs to show all the birds individually
	else if ([viewTitle isEqualToString:@"All Birds"]) {
		// Iterate over each bird group
		for (NSDictionary *groupDict in self.groupDictList) {
			// Iterate over each bird in the group
			for (NSDictionary *birdDict in [groupDict valueForKey:@"Bird_List"]) {
				BirdWikiViewController *controller = [[BirdWikiViewController alloc] init];
				controller.suffix = [birdDict valueForKey:@"URL_Suffix"];
				controller.suffix = [birdDict valueForKey:@"Latin_Name"];
				controller.title = [birdDict valueForKey:@"Common_Name"];
				[controllersArray addObject:controller];
				[controller release];
			}
		}
	}
	
	self.controllers = controllersArray;
	[controllersArray release];
}


- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	// If the view is for bird groups
	if ([self.title isEqualToString:@"Bird Groups"]) {
		return [groupDictList count];
	}
	
	// Else the view is for just birds
	// Count the total number of birds
//	int birdCount = 0;
//	for (NSDictionary *groupDict in self.groupDictList) {
//		for (NSDictionary *birdDict in [groupDict valueForKey:@"Bird_List"]) {
//			birdCount += [[birdDict allKeys] count];
//		}
//	}
	return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	// Set up the cell to be customised for the view
	static NSString *FirstLevelCellID = @"FirstLevelCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FirstLevelCellID];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
									   reuseIdentifier:FirstLevelCellID] autorelease];
	}	
	// If the view is for bird groups
	if ([self.title isEqualToString:@"Bird Groups"]) {
		NSUInteger row = [indexPath row];
		BirdsInGroupViewController *controller = [controllers objectAtIndex:row];
		cell.textLabel.text = controller.title;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;		
		return cell;
	}
	// If the view is for all the birds individually
	NSUInteger row = [indexPath row];
	BirdWikiViewController *controller = [controllers objectAtIndex:row];
	cell.textLabel.text = controller.title;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;		
	return cell; 
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// If the view is for bird groups
	if ([self.title isEqualToString:@"Bird Groups"]) {
		NSUInteger row = [indexPath row];		
		// Configure the new controller
		BirdsInGroupViewController *nextController = [self.controllers objectAtIndex:row];
		[self.navigationController pushViewController:nextController animated:YES];
	}
	
	// If the view is for all the birds individually
	else {
		NSUInteger row = [indexPath row];		
		// Configure the new controller
		BirdWikiViewController *nextController = [self.controllers objectAtIndex:row];
		[self.navigationController pushViewController:nextController animated:YES];
	}


}


- (IBAction)viewPressed:(id)sender {
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose how to view the bird index data" 
															 delegate:self 
													cancelButtonTitle:@"Cancel" 
											   destructiveButtonTitle:nil 
													otherButtonTitles:@"List All Birds", @"List Bird Groups",  nil];
	[actionSheet showInView:self.view]; 
	[actionSheet release];
}

// ActionSheet Delegate Methods
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if ((buttonIndex == 0) & (![self.title isEqualToString:@"All Birds" ])) {
		self.title = @"All Birds";
		[self addControllers:@"All Birds"];
		[self.tableView reloadData];
	}
	else if ((buttonIndex == 1) & (![self.title isEqualToString:@"Bird Groups" ])) {
		self.title = @"Bird Groups";
		[self addControllers:@"Bird Groups"];
		[self.tableView reloadData];
	}
	
	
}



- (void)viewDidUnload {
	self.controllers = nil;
	[super viewDidUnload];
}

- (void)dealloc {
	[controllers release];
	[super dealloc];
}

@end
