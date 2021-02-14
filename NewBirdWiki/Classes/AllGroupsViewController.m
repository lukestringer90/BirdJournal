//
//  AllGroupsViewController.m
//  NewBirdWiki
//
//  Created by Luke on 28/02/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import "AllGroupsViewController.h"
#import "BirdsInGroupViewController.h"


@implementation AllGroupsViewController
@synthesize controllers;
@synthesize keys;
@synthesize groupNames;
@synthesize currentSectionsDict;


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = @"Bird Groups";
	
	// Load the plist file
	NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"AllGroups" ofType:@"plist"];
	NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
	
	// Set the section keys
	self.keys = [[plistDict objectForKey:@"--Alpha_Keys--"] sortedArrayUsingSelector:@selector(compare:)];
	// Get the group names
	self.groupNames = [[plistDict objectForKey:@"--Groups--"] sortedArrayUsingSelector:@selector(compare:)];
	// Remove the first 2 items; the keys and the group names
	[plistDict removeObjectForKey:@"--Alpha_Keys--"];
	[plistDict removeObjectForKey:@"--Groups--"];
	// Store the sections
	self.currentSectionsDict = plistDict;
	
	// Add the controllers
	NSMutableDictionary *tempControllers = [[NSMutableDictionary alloc] init];
	for (NSString *name in self.groupNames) {
		BirdsInGroupViewController *nextController = [[BirdsInGroupViewController alloc] init];
		nextController.title = name;
		nextController.groupDict = [self.currentSectionsDict objectForKey:name];
		[tempControllers setObject:nextController forKey:name];
		[nextController release];
	}
	
	self.controllers = tempControllers;
	
	[tempControllers release];
	[plistDict release];	
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [keys count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *sectionName = [keys objectAtIndex:section];
	
	NSMutableArray *sectionGroupNames = [[NSMutableArray alloc] init];
	for (NSString *groupName in self.groupNames) {
		if([[groupName substringToIndex:1] isEqualToString:sectionName])
			[sectionGroupNames addObject:groupName];
	}
	
	NSUInteger theCount = [sectionGroupNames count];
	[sectionGroupNames release];
	return theCount;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger sectionKey = [indexPath section];
	NSString *sectionName = [keys objectAtIndex:sectionKey];
	NSUInteger row = [indexPath row];
	
	
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	NSMutableArray *sectionGroupNames = [[NSMutableArray alloc] init];
	for (NSString *groupName in self.groupNames) {
		if([[groupName substringToIndex:1] isEqualToString:sectionName])
			[sectionGroupNames addObject:groupName];
	}
	[sectionGroupNames sortUsingSelector:@selector(compare:)];
	
    
	NSString *groupName = [sectionGroupNames objectAtIndex:row];
	[sectionGroupNames release];
    cell.textLabel.text = groupName;
	cell.textLabel.font = [UIFont systemFontOfSize:20];
	
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView { 
	return keys;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section { 
	NSString *keySection = [keys objectAtIndex:section]; 
	return keySection;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger sectionKey = [indexPath section];
	NSString *sectionName = [keys objectAtIndex:sectionKey];
	NSUInteger row = [indexPath row];
	
	NSMutableArray *sectionGroupNames = [[NSMutableArray alloc] init];
	for (NSString *groupName in self.groupNames) {
		if([[groupName substringToIndex:1] isEqualToString:sectionName])
			[sectionGroupNames addObject:groupName];
	}
	[sectionGroupNames sortUsingSelector:@selector(compare:)];
	
    
	NSString *groupName = [sectionGroupNames objectAtIndex:row];
	BirdsInGroupViewController *nextController = [self.controllers objectForKey:groupName];
	[self.navigationController pushViewController:nextController animated:YES];	
	[sectionGroupNames release];
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
    [super dealloc];
}


@end

