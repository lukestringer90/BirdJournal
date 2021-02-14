//
//  AllBirdsViewController.m
//  NewBirdWiki
//
//  Created by Luke on 25/02/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import "AllBirdsViewController.h"
#import "SummarisedWikiViewController.h"


@implementation AllBirdsViewController
@synthesize controllers;
@synthesize keys;
@synthesize currentSectionsDict;

#pragma mark - 
#pragma mark View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"All Birds";

	[self setUpControllers:@"All"];
	
	// Add filter button
	UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithTitle:@"Filter" 
																	 style:UIBarButtonItemStylePlain 
																	target:self 
																	action:@selector(filterTapped:)];
								
	self.navigationItem.rightBarButtonItem = filterButton;
	[filterButton release];
	
	
}

#pragma mark -
#pragma mark Custom instance methods
- (void)setUpControllers:(NSString *)plistName {
	// Load the plist file
	NSString *plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
	NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
	
	// Set the section keys
	self.keys = [[plistDict objectForKey:@"--Alpha_Keys--"] sortedArrayUsingSelector:@selector(compare:)];
	// Remove the first item which is the keys
	[plistDict removeObjectForKey:@"--Alpha_Keys--"];
	// Store the sections
	self.currentSectionsDict = plistDict;
	
	NSMutableDictionary *tempControllers = [[NSMutableDictionary alloc] init];
	// Loop over the sections in alphabetical order
	for (NSString *sectionName in 
		 [[currentSectionsDict allKeys] sortedArrayUsingSelector:@selector(compare:)]) {
		// The list of bird dictionaries in the section
		NSArray *birdDictList =  [currentSectionsDict objectForKey:sectionName];
		
		// Get all the bird names
		NSMutableArray *birdNames = [[NSMutableArray alloc] init];
		for (NSDictionary *birdDict in birdDictList) {
			[birdNames addObject:[birdDict objectForKey:@"Common_Name"]];
		}
		[birdNames sortUsingSelector:@selector(compare:)];
		
		// Loop over the bird names in order
		for (NSString *name in birdNames) {
			// Loop over the bird dictionaries
			for (NSDictionary *currentBirdDict in birdDictList) {
				// If the current bird dictionary is the right one according to alphabetical ordering
				if ([[currentBirdDict objectForKey:@"Common_Name"] isEqualToString:name]) {
					SummarisedWikiViewController *nextController = [[SummarisedWikiViewController alloc] init];
					nextController.suffix = [currentBirdDict valueForKey:@"URL_Suffix"];
					nextController.latin = [currentBirdDict valueForKey:@"Latin_Name"];
					nextController.commonName = name;
					[tempControllers setObject:nextController forKey:name];
					[nextController release];
				}
			}
		}
		[birdNames release];
		
	}
	self.controllers = tempControllers;
	
	// Set back button
	self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back"
																			  style:UIBarButtonItemStylePlain target:nil 
																			 action:nil] autorelease];
	
	[tempControllers release];
	[plistDict release];
}


#pragma mark -
#pragma mark Action methods
- (IBAction)filterTapped:(id)sender {
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Filter the birds to show:" 
															 delegate:self 
													cancelButtonTitle:@"Cancel" 
											   destructiveButtonTitle:nil 
													otherButtonTitles: @"All Birds", @"All Excluding Rare", 
								  @"Resident Breeders", @"Summer Visitors", @"Winter Visitors", @"Passage Migrants", @"Introduced", nil];
	[actionSheet showInView:[UIApplication sharedApplication].keyWindow]; 
	[actionSheet release];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [keys count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSString *keySection = [self.keys objectAtIndex:section];
	NSArray *dictList = [currentSectionsDict objectForKey:keySection];
	return [dictList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	// Get the current section and row
	NSUInteger section = [indexPath section];
	NSString *sectionKey = [self.keys objectAtIndex:section];
	NSUInteger row = [indexPath row];
	
	// Set up the cell to be customised for the view
	static NSString *CellID = @"CellID";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
									   reuseIdentifier:CellID] autorelease];
	}	
	
	// Find the right bird name
	NSArray *birdDictList = [self.currentSectionsDict objectForKey:sectionKey];
	NSString *birdName = [[birdDictList objectAtIndex:row] objectForKey:@"Common_Name"];
	
	// Set the cell text
	cell.textLabel.text = birdName;
	cell.textLabel.font = [UIFont systemFontOfSize:20];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section { 
	NSString *keySection = [keys objectAtIndex:section]; 
	return keySection;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView { 
	return keys;
}



#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// Get the current section and row
	NSUInteger section = [indexPath section];
	NSString *sectionKey = [self.keys objectAtIndex:section];
	NSUInteger row = [indexPath row];		
	
	// Find the right bird name
	NSArray *birdDictList = [self.currentSectionsDict objectForKey:sectionKey];
	NSString *birdName = [[birdDictList objectAtIndex:row] objectForKey:@"Common_Name"];
	
	// Get the right controller
	SummarisedWikiViewController *nextController = [self.controllers objectForKey:birdName];
	nextController.hidesBottomBarWhenPushed = YES;
	[self.navigationController pushViewController:nextController animated:YES];
}

#pragma mark -
#pragma mark Action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
	// All selected
	if (buttonIndex == 0 && !([self.title isEqualToString:@"All Birds"])) {
		[self setUpControllers:@"All"];
		[self.tableView reloadData];
		self.title = @"All Birds";
	}
	
	// Not rare selected
	if (buttonIndex == 1 && !([self.title isEqualToString:@"Non-Rare Birds"])) {
		[self setUpControllers:@"NonRare"];
		[self.tableView reloadData];
		self.title = @"Rare Excluded";
	}
	
	// Resident breeders selected
	if (buttonIndex == 2 && !([self.title isEqualToString:@"Residents"])) {
		[self setUpControllers:@"ResidentBreeder"];
		[self.tableView reloadData];
		self.title = @"Residents";
	}
	
	// Summer visitors selected
	if (buttonIndex == 3 && !([self.title isEqualToString:@"Summer Visitors"])) {
		[self setUpControllers:@"SummerVisitor"];
		[self.tableView reloadData];
		self.title = @"Summer Visitors";
	}
	
	// Winter visitors selected
	if (buttonIndex == 4 && !([self.title isEqualToString:@"Winter Visitors"])) {
		[self setUpControllers:@"WinterVisitor"];
		[self.tableView reloadData];
		self.title = @"Winter Visitors";
	}
	
	// Passage Migrants selected
	if (buttonIndex == 5 && !([self.title isEqualToString:@"Passage Migrants"])) {
		[self setUpControllers:@"PassageMigrant"];
		[self.tableView reloadData];
		self.title = @"Migrants";
	}
	
	// Passage Migrants selected
	if (buttonIndex == 6 && !([self.title isEqualToString:@"Introduced"])) {
		[self setUpControllers:@"Introduced"];
		[self.tableView reloadData];
		self.title = @"Introduced";
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
}


- (void)dealloc {
	[controllers release];
	[keys release];
	[currentSectionsDict release];
	
    [super dealloc];
}


@end

