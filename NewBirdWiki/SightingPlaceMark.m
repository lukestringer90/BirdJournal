//
//  SightingPlaceMark.m
//  NewBirdWiki
//
//  Created by Luke on 18/04/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import "SightingPlaceMark.h"


@implementation SightingPlaceMark
@synthesize coordinate;
@synthesize name;
@synthesize numberSeen;

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
	coordinate=c;
	NSLog(@"%f,%f",c.latitude,c.longitude);
	return self;
}

- (NSString *)title{
	return name;
}

- (NSString *)subtitle{
	return [NSString stringWithFormat:@"Sighted: %d", numberSeen];
}

- (void)dealloc {
	[name release];
	[super dealloc];
}


@end
