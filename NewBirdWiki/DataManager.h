//
//  DataPersitanceSingleton.h
//  NewBirdWiki
//
//  Created by Luke on 11/04/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface DataManager : NSObject {
	CLLocationManager *locationManager;
	NSMutableSet *favBirds;
	NSMutableArray *sightings;
	int tempCountStore;
}

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) NSMutableSet *favBirds;
@property (nonatomic, retain) NSMutableArray *sightings;
@property int tempCountStore;

+ (DataManager* )sharedDataManager;
- (void)saveData;

@end
