//
//  NewBirdWikiAppDelegate.h
//  NewBirdWiki
//
//  Created by Luke on 25/02/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewBirdWikiAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

