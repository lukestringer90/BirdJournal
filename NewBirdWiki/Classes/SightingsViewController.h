//
//  SightingsTableViewController.h
//  NewBirdWiki
//
//  Created by Luke on 14/04/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface SightingsViewController : UIViewController 
<UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate> {
	IBOutlet UITableView *tableView;
	IBOutlet MKMapView *mapView;
	IBOutlet UITableViewCell *tvCell;
	NSMutableArray *sightingsToDisplay;
	NSMutableArray *placemarks;
	BOOL displayingToday;  
	BOOL showingTableView;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) IBOutlet UITableViewCell *tvCell;
@property (nonatomic, retain) NSMutableArray *sightingsToDisplay;
@property (nonatomic, retain) NSMutableArray *placemarks;
@property BOOL displayingToday; 

- (IBAction)segmentedSwitchTapped:(id)sender;
- (IBAction)exportTapped:(id)sender;
- (IBAction)toggleEdit:(id)sender;

- (void)setupTableView;
- (void)setupMapView;
@end
