//
//  BirdSighting.h
//  NewBirdWiki
//
//  Created by Luke on 12/04/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface BirdSighting : NSObject <NSCoding> {
	CLLocation *location;
	NSString *birdName;
	NSString *notes;
	int numberSeen;
	NSDate *seenDate;

}

@property (retain, nonatomic) CLLocation *location;
@property (retain, nonatomic) NSString *birdName;
@property (retain, nonatomic) NSString *notes;
@property int numberSeen;
@property (retain, nonatomic) NSDate *seenDate;

- (id)initWithBirdName:(NSString *)name timesSeen:(int)seenCount;
- (NSString *)timeString;

@end
