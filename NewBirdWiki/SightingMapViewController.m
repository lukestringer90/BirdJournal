//
//  NewSightingMapController.m
//  NewBirdWiki
//
//  Created by Luke on 18/04/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import "SightingMapViewController.h"
#import "SightingPlaceMark.h"
#import "DataManager.h"


@implementation SightingMapViewController
@synthesize theMpView;
@synthesize sighting;
@synthesize usedForExisting;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Sighting location";
	theMpView = [[MKMapView alloc] initWithFrame:self.view.bounds];
	theMpView.mapType = MKMapTypeStandard;
	theMpView.delegate = self;
	
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	span.latitudeDelta = 0.04;
	span.longitudeDelta = 0.04;
	
	CLLocationCoordinate2D location = sighting.location.coordinate;
	region.span = span;
	region.center = location;
	
	thePlacemark = [[SightingPlaceMark alloc] initWithCoordinate:location];
	thePlacemark.name = sighting.birdName;
	if (usedForExisting) {
		thePlacemark.numberSeen = sighting.numberSeen;
	}
	else {
		thePlacemark.numberSeen = [DataManager sharedDataManager].tempCountStore;
	}

	[theMpView addAnnotation:thePlacemark];
	[theMpView selectAnnotation:thePlacemark animated:YES];
	[theMpView setRegion:region animated:TRUE];
	[theMpView regionThatFits:region];
	[self.view insertSubview:theMpView atIndex:0];
	
}

#pragma mark -
#pragma mark MKMapViewDelegate methods

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation{
	MKPinAnnotationView *pin = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation 
										  reuseIdentifier:@"CurrentLocation"] autorelease];
	pin.animatesDrop = YES;
	pin.canShowCallout = YES;
    pin.calloutOffset = CGPointMake(-5, 5);
//	pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	return pin;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view 
calloutAccessoryControlTapped:(UIControl *)control{
    NSLog(@"callout annotation.title = %@", view.annotation.title);
	
    //do your show details thing here...
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	self.theMpView = nil;
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [theMpView release];
	[super dealloc];
}


@end
