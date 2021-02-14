//
//  SightingPlaceMark.h
//  NewBirdWiki
//
//  Created by Luke on 18/04/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface SightingPlaceMark : NSObject <MKAnnotation>{
	NSString *name;
	int numberSeen;
	CLLocationCoordinate2D coordinate;
}

@property (nonatomic, retain) NSString *name;
@property int numberSeen;

- (NSString *)subtitle;
- (NSString *)title;

@end
