//
//  NewSightingMapController.h
//  NewBirdWiki
//
//  Created by Luke on 18/04/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "BirdSighting.h"
#import "SightingPlaceMark.h"

@interface SightingMapViewController : UIViewController <MKMapViewDelegate>{
	IBOutlet MKMapView *theMpView;
	BirdSighting *sighting;
	SightingPlaceMark *thePlacemark;
	BOOL usedForExisting;
}

@property (nonatomic, retain) IBOutlet MKMapView *theMpView;
@property (nonatomic, retain) BirdSighting *sighting;
@property BOOL usedForExisting;

@end
