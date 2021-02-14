//
//  BirdsInGroupViewController.m
//  NewBirdWiki
//
//  Created by Luke on 28/02/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import "BirdsInGroupViewController.h"
#import "SummarisedWikiViewController.h"


@implementation BirdsInGroupViewController
@synthesize controllers;
@synthesize birdNames;
@synthesize groupDict;


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

	NSMutableArray *sortedNames = [groupDict objectForKey:@"Name_List"];
	self.birdNames = [sortedNames sortedArrayUsingSelector:@selector(compare:)];
	NSArray *birdDictList = [groupDict objectForKey:@"Bird_Dict_List"];
	
	NSMutableArray *tempControllers = [[NSMutableArray alloc] init];
	for (NSString *name in self.birdNames) {
		for (NSDictionary *birdDict in birdDictList) {
			if ([[birdDict objectForKey:@"Common_Name"] isEqualToString:name]) {
				SummarisedWikiViewController *nextController = [[SummarisedWikiViewController alloc] init];
				nextController.suffix = [birdDict valueForKey:@"URL_Suffix"];
				nextController.latin = [birdDict valueForKey:@"Latin_Name"];
				nextController.commonName = name;
				[tempControllers addObject:nextController];
				[nextController release];
			}
		}
	}
	self.controllers = tempControllers;
	
	// Set back button
	self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back"
																			  style:UIBarButtonItemStylePlain target:nil 
																			 action:nil] autorelease];
	
	[tempControllers release];
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
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.textLabel.font = [UIFont systemFontOfSize:20];
    
    return cell;
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
	[groupDict release];
    [super dealloc];
}


@end

