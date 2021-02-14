//
//  DataPersitanceSingleton.m
//  NewBirdWiki
//
//  Created by Luke on 11/04/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import "DataManager.h"

static DataManager *singletonDataManager = nil;

@implementation DataManager

@synthesize locationManager;
@synthesize favBirds;
@synthesize sightings;
@synthesize tempCountStore;

+ (DataManager *)sharedDataManager {
    @synchronized(self) {
        if (!singletonDataManager) {
            singletonDataManager = [[DataManager alloc] init];
        }
    }
    return singletonDataManager;
}

- (id)init {
    if (self = [super init]) {
		// Location manager for capturing location
		locationManager = [[CLLocationManager alloc] init];
		[locationManager startUpdatingLocation];
		
		// Data structures for the data
		favBirds = [[NSMutableSet alloc] init];
		sightings = [[NSMutableArray alloc] init];
		
		// Get the paths to the archives
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
		NSString *documentsDirectory = [paths objectAtIndex:0];
		NSString *favsPath = [documentsDirectory stringByAppendingPathComponent:@"favs.plist"];
		NSString *sightingsPath = [documentsDirectory stringByAppendingPathComponent:@"sightings.plist"];
		
		// Load the favourited birds datafile if present
		if ([[NSFileManager defaultManager] fileExistsAtPath:favsPath]) {
			NSArray *array = [[NSArray alloc] initWithContentsOfFile:favsPath];
			[favBirds addObjectsFromArray:array];
			[array release];
		}
		
		// Load the bird sightings datafile if present
		if ([[NSFileManager defaultManager] fileExistsAtPath:sightingsPath]){
			// Use an unarchive to reload the archived data
			NSData *data = [NSData dataWithContentsOfFile:sightingsPath];
			NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
			NSArray *array = [unarchiver decodeObjectForKey:@"Sightings"];
			[sightings addObjectsFromArray:array];
			[unarchiver finishDecoding];
			[unarchiver release];
		}
    }

	return self;
}

- (int)tempCountStore {
	if (tempCountStore > 0) {
		return tempCountStore;
	}
	else {
		tempCountStore = 1;
		return tempCountStore;
	}

	
}

- (void)saveData {	
	// Get the paths to the archives
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *favsPath = [documentsDirectory stringByAppendingPathComponent:@"favs.plist"];
	NSString *sightingsPath = [documentsDirectory stringByAppendingPathComponent:@"sightings.plist"];
	
	// Write favourited birds straight to file
	[[favBirds allObjects] writeToFile:favsPath atomically:YES];
	
	// Archive the sightings data using an archiver
	NSMutableData *data = [NSMutableData data];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
	[archiver encodeObject:sightings forKey:@"Sightings"];
	[archiver finishEncoding];
	[data writeToFile:sightingsPath atomically:YES];
	[archiver release];
}


# pragma -
# pragma mark Memory managment
- (id)retain {
    return self;
}

- (unsigned)retainCount {
    // Indicates the object cannot be relased from memory
	return UINT_MAX; 
}

- (void)release {
	[locationManager release];
    [favBirds release];
	[sightings release];
}

- (id)autorelease {
    return self;
}

@end
