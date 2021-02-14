//
//  WikidataLoaderViewController.h
//  WikidataLoader
//
//  Created by Luke on 31/10/2010.
//  Copyright 2010 Luke Stringer Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WikidataLoaderViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	NSArray *listData;
	NSArray *sectionList;
}

@property (nonatomic, retain) NSArray *listData;
@property (nonatomic, retain) NSArray *sectionsList;

@end

