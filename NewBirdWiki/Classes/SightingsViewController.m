//
//  SightingsTableViewController.m
//  NewBirdWiki
//
//  Created by Luke on 14/04/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import "SightingsViewController.h"
#import "DataManager.h"
#import "BirdSighting.h"
#import "SightingPlaceMark.h"
#import "ExistingSightingViewController.h"


@implementation SightingsViewController
@synthesize tableView;
@synthesize mapView;
@synthesize tvCell;
@synthesize displayingToday;
@synthesize sightingsToDisplay;
@synthesize placemarks;


#pragma mark -
#pragma mark View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
	showingTableView = YES;
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Edit"
																			   style:UIBarButtonItemStylePlain
																			  target:self 
																			  action:@selector(toggleEdit:)] autorelease];
	// Set back button
	self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back"
																			  style:UIBarButtonItemStylePlain target:nil 
																			 action:nil] autorelease];
	
}

- (void)viewWillAppear:(BOOL)animated{
	/*
	/ 1. Collate the sightings to display depending on whether 
	/	 the view is for disaplying today's sightings or 
	/	 all time.
	*/
	
	NSMutableArray *tempSightings = [[NSMutableArray alloc] init];
	NSArray *allSavedSightings = [[DataManager sharedDataManager] sightings];
	
	// If the view controller is to only display sightings for today
	if (displayingToday) {
		// Get the current date
		NSDateComponents *thisComponents = 
		[[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit
										fromDate:[NSDate date]];
		NSInteger thisDay = [thisComponents day];    
		NSInteger thisMonth = [thisComponents month];
		NSInteger thisYear = [thisComponents year];
		
		for (BirdSighting *sighting in allSavedSightings) {
			// Get the date of the sighting
			NSDate *seenDate = sighting.seenDate;
			NSDateComponents *sightingComponents = 
			[[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit
											fromDate:seenDate];
			NSInteger seenDay = [sightingComponents day];    
			NSInteger seenMonth = [sightingComponents month];
			NSInteger seenYear = [sightingComponents year];
			
			// If it was seen today, add it to the array
			if (thisDay == seenDay && thisMonth == seenMonth && thisYear == seenYear) {
				[tempSightings addObject:sighting];
			}
		}
	}
	
	// Otherwise is displaying all sightings
	else {
		[tempSightings addObjectsFromArray:allSavedSightings];
	}
	// Sort the sightings into chrononlogical order
	NSSortDescriptor *desc = [[NSSortDescriptor alloc] initWithKey:@"seenDate" ascending:NO];
	[tempSightings sortUsingDescriptors:[NSArray arrayWithObject:desc]];
	[desc release];	
	sightingsToDisplay = [[NSMutableArray alloc] initWithArray:tempSightings];
	[tempSightings release];
	
	
	
	/*
	 / 2. Now setup correct view of the data
	 */
	if (showingTableView) {
		[self setupTableView];
	}
	else {
		[self setupMapView];
	}

	[super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
	[mapView removeFromSuperview];
	[super viewWillDisappear:animated];
}

#pragma mark -
#pragma mark Methods to setup the correct view
- (void)setupTableView{	
	[self.view insertSubview:tableView atIndex:0];
	[self.tableView reloadData];
}

- (void)setupMapView {
	mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
	mapView.mapType = MKMapTypeStandard;
	mapView.delegate = self;
	
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	span.latitudeDelta = 0.04;
	span.longitudeDelta = 0.04;
	
	CLLocationCoordinate2D location = [[DataManager sharedDataManager].locationManager location].coordinate;

	region.span = span;
	region.center = location;
	
	for (BirdSighting *sighting in sightingsToDisplay) {
		SightingPlaceMark *thePlacemark = [[SightingPlaceMark alloc] initWithCoordinate:sighting.location.coordinate];
		thePlacemark.name = sighting.birdName;
		thePlacemark.numberSeen = sighting.numberSeen;
		[mapView addAnnotation:thePlacemark];
		[thePlacemark release];
	}
	
	
	[mapView setRegion:region animated:YES];
	[mapView regionThatFits:region];
	[self.view insertSubview:mapView atIndex:0];
}

#pragma mark -
#pragma mark IBActions
- (IBAction)segmentedSwitchTapped:(id)sender {
	UISegmentedControl *segControler = (UISegmentedControl *)sender;
	
	if (segControler.selectedSegmentIndex == 0 && !showingTableView) {
		[mapView removeFromSuperview];
		[self setupTableView];
		if (self.tableView.editing){
			self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Done"
																					   style:UIBarButtonItemStyleDone
																					  target:self 
																					  action:@selector(toggleEdit:)] autorelease];
		}
		else {
			self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Edit"
																					   style:UIBarButtonItemStylePlain
																					  target:self 
																					  action:@selector(toggleEdit:)] autorelease];
		}
		showingTableView = YES;
	}
	if (segControler.selectedSegmentIndex == 1 && showingTableView) {
		[tableView removeFromSuperview];
		self.navigationItem.rightBarButtonItem = nil;
		[self setupMapView];
		showingTableView = NO;
	}
	
}
- (IBAction)exportTapped:(id)sender{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Export sightings"
													message:@"Exporting not yet implemented" 
													   delegate:self 
										  cancelButtonTitle:@"Dismiss" 
										  otherButtonTitles:nil];
	[alert show]; 
	[alert release];
}
- (IBAction)toggleEdit:(id)sender {
	[self.tableView setEditing:!self.tableView.editing animated:YES];
	if (self.tableView.editing){
		self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Done"
																				   style:UIBarButtonItemStyleDone
																				  target:self 
																				  action:@selector(toggleEdit:)] autorelease];
	}
	else {
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
    return [sightingsToDisplay count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *MyIdentifier = @"MyIdentifier";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"CustomSightingTableViewCell" owner:self options:nil];
        cell = tvCell;
        self.tvCell = nil;
    }
    UILabel *label;
    BirdSighting *sighting = [sightingsToDisplay objectAtIndex:[indexPath row]];
	
	label = (UILabel *)[cell viewWithTag:1];
    label.text = [NSString stringWithFormat:@"%@", sighting.birdName];
	
    label = (UILabel *)[cell viewWithTag:3];
    label.text = [NSString stringWithFormat:@"Date: %@", [sighting timeString]];
	
	label = (UILabel *)[cell viewWithTag:2];
    label.text = [NSString stringWithFormat:@"Sighted: %d", sighting.numberSeen];
	
    return cell;
}

- (void)tableView:(UITableView *)tableView 
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath{
	NSUInteger row = [indexPath row];	
	
	// Remove from the datamanager
	BirdSighting *removeSighting = [self.sightingsToDisplay objectAtIndex:row];
	// Loop backwards as birds as sorted in reverse chronological order
	for (int i = [[DataManager sharedDataManager].sightings count] - 1; i >= 0; i--) {
		BirdSighting *storedSighting = [[DataManager sharedDataManager].sightings objectAtIndex:i];
		// If the bird has been found then remove it
		// Use pointers as the object itself should be removed
		if (storedSighting == removeSighting) {
			[[DataManager sharedDataManager].sightings removeObjectAtIndex:i];
		}
	}
	
	// Update the datasource for the voews
	[self.sightingsToDisplay removeObjectAtIndex:row]; 
	[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] 
						  withRowAnimation:UITableViewRowAnimationFade];
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BirdSighting *theSighting = [sightingsToDisplay objectAtIndex:[indexPath row]];
	ExistingSightingViewController *nextController = [[ExistingSightingViewController alloc] init];
	nextController.sighting = theSighting;
	[self.navigationController pushViewController:nextController animated:YES];
	[nextController release];
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

#pragma mark -
#pragma mark Mapkit delegate methods
- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation{
	MKPinAnnotationView *pin = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation 
															   reuseIdentifier:@"CurrentLocation"] autorelease];
	pin.animatesDrop = YES;
	pin.canShowCallout = YES;
    pin.calloutOffset = CGPointMake(-5, 5);
	pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	return pin;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
	NSString *selectedName = ((SightingPlaceMark *)view.annotation).name;
	for (BirdSighting *sighting in sightingsToDisplay) {
		if ([sighting.birdName isEqualToString:selectedName]) {
			ExistingSightingViewController *nextController = [[ExistingSightingViewController alloc] init];
			nextController.sighting = sighting;
			[self.navigationController pushViewController:nextController animated:YES];
			[nextController release];
		}
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
	self.tableView = nil;
	self.mapView = nil;
	self.tvCell = nil;
	self.sightingsToDisplay = nil;
	self.placemarks = nil;
}


- (void)dealloc {
	[tableView release];
	[mapView release];
	[tvCell release];
	[sightingsToDisplay release];
	[placemarks release];
    [super dealloc];
}


@end

