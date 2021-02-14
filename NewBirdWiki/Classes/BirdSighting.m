//
//  BirdSighting.m
//  NewBirdWiki
//
//  Created by Luke on 12/04/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import "BirdSighting.h"
#import "DataManager.h"

// Constants used when archiving the data
#define kLocationKey @"Location"
#define kNameKey @"Name"
#define kDateKey @"Date"
#define kNumberKey @"Number"
#define kNotesKey @"Notes"

@implementation BirdSighting
@synthesize location;
@synthesize numberSeen;
@synthesize birdName;
@synthesize notes;
@synthesize seenDate;

- (id)initWithBirdName:(NSString *)name timesSeen:(int)seenCount {
	if (self = [super init]) {
		location = [[[DataManager sharedDataManager] locationManager].location retain];
		seenDate = [[NSDate date] retain];
		birdName = [name retain];
		numberSeen = seenCount;
		notes = nil;
		
	}
	return self;
}

- (id)initWithBirdName:(NSString *)name timesSeen:(int)seenCount withNotes:(NSString *)sightingNotes{
	if (self = [super init]) {
		location = [[[DataManager sharedDataManager] locationManager].location retain];
		seenDate = [[NSDate date] retain];
		birdName = [name retain];
		numberSeen = seenCount;
		notes = [sightingNotes retain];
		
	}
	return self;
}

- (NSString *)description {
	NSString *lines = @"-----\n";
	NSMutableString *descString = [NSMutableString stringWithFormat:@"Seen count: %d\n", numberSeen];
	[descString appendString:lines];
	[descString appendFormat:@"At location: %@\n", [location description]];
	[descString appendString:lines];
	NSString *timeString = [NSDateFormatter localizedStringFromDate:seenDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
	[descString appendFormat:@"At time: %@\n", timeString];
	[descString appendString:lines];
	return descString;
}

- (NSString *)timeString {
	NSString *time = [NSDateFormatter localizedStringFromDate:seenDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
	return time;
}

#pragma mark -
#pragma mark NSCoding protocol methods
- (id)initWithCoder:(NSCoder *)aDecoder {
	location = [[aDecoder decodeObjectForKey:kLocationKey] retain];
	birdName = [[aDecoder decodeObjectForKey:kNameKey] retain];
	seenDate = [[aDecoder decodeObjectForKey:kDateKey] retain];
	numberSeen = (int)[aDecoder decodeIntForKey:kNumberKey];
	notes = [[aDecoder decodeObjectForKey:kNotesKey] retain];
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:location forKey:kLocationKey];
	[aCoder encodeObject:birdName forKey:kNameKey];
	[aCoder encodeObject:seenDate forKey:kDateKey];
	[aCoder encodeInt:numberSeen forKey:kNumberKey];
	[aCoder encodeObject:notes forKey:kNotesKey];
}


#pragma mark -

- (void)dealloc {
	[location release];
	[birdName release];
	[seenDate release];
	[notes release];
	[super dealloc];
}

@end
