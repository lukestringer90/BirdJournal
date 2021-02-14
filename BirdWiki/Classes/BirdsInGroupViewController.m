//
//  SecondLevelViewController.m
//  WikidataLoader
//
//  Created by Luke on 31/10/2010.
//  Copyright 2010 Luke Stringer Inc. All rights reserved.
//

#import "BirdsInGroupViewController.h"
#import "BirdWikiViewController.h"


@implementation BirdsInGroupViewController
@synthesize birdDictList;
@synthesize controllers;

- (void)viewDidLoad {
	
	// Set the back button text
	self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back"
																			  style:UIBarButtonItemStylePlain target:nil 
																			 action:nil] autorelease];

	
	[super viewDidLoad];
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	return [birdDictList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSUInteger row = [indexPath row];
	NSDictionary *selectedBirdDict = [birdDictList objectAtIndex:row];
	NSString *birdName = [selectedBirdDict valueForKey:@"Common_Name"];
	
	static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
									   reuseIdentifier:SimpleTableIdentifier] autorelease];
	}
	cell.textLabel.text = birdName;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger row = [indexPath row];
	NSDictionary *currentBirdDict = [birdDictList objectAtIndex:row];
	BirdWikiViewController *nextController = [[BirdWikiViewController alloc] init];
	nextController.suffix = [currentBirdDict valueForKey:@"URL_Suffix"];
	nextController.latin = [currentBirdDict valueForKey:@"Latin_Name"];
	nextController.title = [currentBirdDict valueForKey:@"Common_Name"];
	[self.navigationController pushViewController:nextController animated:YES];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	self.birdDictList = nil;
	[super viewDidUnload];
}

- (void)dealloc {
	[birdDictList release];
    [super dealloc];
}

@end
