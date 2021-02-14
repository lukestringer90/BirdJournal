//
//  WikidataLoaderViewController.m
//  WikidataLoader
//
//  Created by Luke on 31/10/2010.
//  Copyright 2010 Luke Stringer Inc. All rights reserved.
//

#import "WikidataLoaderViewController.h"

@implementation WikidataLoaderViewController
@synthesize listData;
@synthesize sectionsList;


- (void)viewDidLoad {
	// Load the plist file
	NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"BirdGroupList" ofType:@"plist"];
	NSArray *birdArray = [[NSArray alloc] initWithContentsOfFile:plistPath];
	self.listData = birdArray;
	[birdArray release];

	//Get the Bird Group names that will be used for the sections
	NSMutableArray *sectionsNames = [[NSMutableArray alloc] init];
	for (NSDictionary *birdDict in birdArray) {
		[sectionsNames addObject:[birdDict valueForKey:@"Group_Name"]];
	}	
	self.sectionsList = sectionsNames;
	[sectionsNames release];
	
	[super viewDidLoad];

}


- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	NSDictionary *groupDict = [listData objectAtIndex:section];
	NSArray *birdList = [groupDict valueForKey:@"Bird_List"];
	return [birdList count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [sectionsList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSUInteger section = [indexPath section];
	NSUInteger row = [indexPath row];
	
	NSDictionary *groupDict = [listData objectAtIndex:section];
	NSArray *birdDictList = [groupDict valueForKey:@"Bird_List"];
	
	static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
									   reuseIdentifier:SimpleTableIdentifier] autorelease];
	}
	
	NSMutableArray *birdNameList = [[NSMutableArray alloc] init];
	for (NSDictionary *birdDict in birdDictList) {
		[birdNameList addObject:[birdDict valueForKey:@"Common_Name"]];
	}
	cell.textLabel.text = [birdNameList objectAtIndex:row];
	
	[birdNameList release];

	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	NSString *groupDict = [listData objectAtIndex:section];
	NSString *groupName = [groupDict valueForKey:@"Group_Name"];
	return groupName;
}



- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	self.listData = nil;
	self.sectionsList = nil;
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[listData release];
	[sectionsList release];
    [super dealloc];
}

@end
