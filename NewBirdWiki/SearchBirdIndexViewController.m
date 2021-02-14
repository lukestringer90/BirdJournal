//
//  SearchBirdIndexViewController.m
//  NewBirdWiki
//
//  Created by Luke on 01/04/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import "SearchBirdIndexViewController.h"
#import "SummarisedWikiViewController.h"


@implementation SearchBirdIndexViewController
@synthesize listOfItems;
@synthesize copyListOfItems;
@synthesize birdsDict;
@synthesize searchBar;
@synthesize birdsTableView;
@synthesize ovController;
@synthesize nextController;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Load the plist file
	NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"All" ofType:@"plist"];
	NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
	[plistDict removeObjectForKey:@"--Alpha_Keys--"];
	self.birdsDict = plistDict;
	
	// Loop over the sections in alphabetical order
	NSMutableArray *birdNames = [[NSMutableArray alloc] init];
	for (NSString *sectionName in 
		 [[plistDict allKeys] sortedArrayUsingSelector:@selector(compare:)]){
		// The list of bird dictionaries in the section
		NSArray *birdDictList =  [plistDict objectForKey:sectionName];
		for (NSDictionary *birdDict in birdDictList) {
			[birdNames addObject:[birdDict objectForKey:@"Common_Name"]];
		}
	}
	[birdNames sortUsingSelector:@selector(compare:)];
	self.listOfItems = birdNames;
	[plistDict release];
	
	self.copyListOfItems = [[NSMutableArray alloc] init];

	searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	searching = NO;
	letUserSelectRow = YES;

    self.navigationItem.title = @"Search Birds";
	
	// Set back button
	self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back"
																			  style:UIBarButtonItemStylePlain target:nil 
																			 action:nil] autorelease];

	
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[birdsTableView deselectRowAtIndexPath:[birdsTableView indexPathForSelectedRow] animated:NO];
}


- (void)viewDidAppear:(BOOL)animated {
	if (!navigatedToBird) {
		[self.searchBar becomeFirstResponder];
	}
    [super viewDidAppear:animated];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (searching){
		return [copyListOfItems count];
	}
	return [listOfItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	if (searching) {
		NSString *item = [copyListOfItems objectAtIndex:indexPath.row];
		cell.textLabel.text = item;
	}
	else {
		NSString *item = [listOfItems objectAtIndex:indexPath.row];
		cell.textLabel.text = item;

	}
	cell.textLabel.font = [UIFont systemFontOfSize:20];
	
	return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    navigatedToBird = YES;
	
	NSString *selectedBird = nil;
	if (searching) {
		selectedBird = [copyListOfItems objectAtIndex:indexPath.row];
	}
	else {
		selectedBird = [listOfItems objectAtIndex:indexPath.row];
	}
	
	SummarisedWikiViewController *foundBirdController = [[SummarisedWikiViewController alloc] init];

	for (NSString *sectionName in 
		[[birdsDict allKeys] sortedArrayUsingSelector:@selector(compare:)]){
		// The list of bird dictionaries in the section
		NSArray *birdDictList =  [birdsDict objectForKey:sectionName];
		for (NSDictionary *birdDict in birdDictList) {
			if ([[birdDict objectForKey:@"Common_Name"] isEqualToString:selectedBird]) {
				foundBirdController.suffix = [birdDict valueForKey:@"URL_Suffix"];
				foundBirdController.latin = [birdDict valueForKey:@"Latin_Name"];
				foundBirdController.commonName = [birdDict objectForKey:@"Common_Name"];
			}
		}
	}
	
	foundBirdController.title = selectedBird;
	foundBirdController.hidesBottomBarWhenPushed = YES;
	self.nextController = foundBirdController;
	[self.navigationController pushViewController:self.nextController animated:YES];
	[foundBirdController release];

    
}

- (NSIndexPath *)tableView :(UITableView *)theTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if(letUserSelectRow)
		return indexPath;
	else
		return nil;
}

#pragma mark -
#pragma mark Scroll View delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	[searchBar resignFirstResponder];
	ovController.view.alpha = 0;
}

#pragma mark -
#pragma mark Search bar delegate
- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
	//Remove all objects first.
	[copyListOfItems removeAllObjects];
	
	if([searchText length] > 0) {
		
		[ovController.view removeFromSuperview];
		searching = YES;
		letUserSelectRow = YES;
		self.birdsTableView.scrollEnabled = YES;
		[self searchTableView];
	}
	else {
		
		[self.birdsTableView insertSubview:ovController.view aboveSubview:self.parentViewController.view];
		
		searching = NO;
		letUserSelectRow = NO;
		self.birdsTableView.scrollEnabled = NO;
	}
	
	[self.birdsTableView reloadData];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
	[self searchTableView];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
	
	navigatedToBird = NO;
	
	//Add the overlay view.
	if(ovController == nil){
		ovController = [[OverlayViewController alloc] init];
	}
	CGFloat yaxis = self.navigationController.navigationBar.frame.size.height - self.searchBar.frame.size.height;
	
	// Hardcoded
	CGRect frame =  CGRectMake(0, yaxis, 320, 24112);
	ovController.view.frame = frame;
	ovController.view.backgroundColor = [UIColor grayColor];
	ovController.view.alpha = 0.5;
	
	ovController.rvController = self;
	
	[self.birdsTableView addSubview:ovController.view];
	
	//Add the reset button.
	UIBarButtonItem *resetButton = [[[UIBarButtonItem alloc] initWithTitle:@"Reset" 
																	  style:UIBarButtonItemStyleDone 
																	 target:self 
																	 action:@selector(resetTapped:)] autorelease];
	
	self.navigationItem.rightBarButtonItem = resetButton;	
}


#pragma mark -
#pragma mark Custom search methods
- (void) searchTableView {
	NSString *searchText = searchBar.text;
	
	for (NSString *sTemp in listOfItems) {
		NSRange titleResultsRange = [sTemp rangeOfString:searchText options:NSCaseInsensitiveSearch];
		
		if (titleResultsRange.length > 0){
			[copyListOfItems addObject:sTemp];
		}
	}	
}

- (void) resetTapped:(id)sender {
	searchBar.text = @"";
	[searchBar resignFirstResponder];
	
	letUserSelectRow = YES;
	searching = NO;
	self.navigationItem.rightBarButtonItem = nil;
	self.birdsTableView.scrollEnabled = YES;
	
	[ovController.view removeFromSuperview];
	[ovController release];
	ovController = nil;
	
	[self.birdsTableView reloadData];
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
	self.birdsTableView = nil;
	self.searchBar = nil;
}


- (void)dealloc {
	[listOfItems release];
	[copyListOfItems release];
	[birdsDict release];
	[ovController release];
	[nextController release];
	[searchBar release];
	[birdsTableView release];
    [super dealloc];
}


@end

