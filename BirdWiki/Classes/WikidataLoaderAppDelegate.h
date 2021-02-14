//
//  WikidataLoaderAppDelegate.h
//  WikidataLoader
//
//  Created by Luke on 31/10/2010.
//  Copyright 2010 Luke Stringer Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WikidataLoaderViewController;

@interface WikidataLoaderAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController *navController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navController;

@end

