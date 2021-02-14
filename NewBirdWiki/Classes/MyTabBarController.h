//
//  MyTabBarController.h
//  NewBirdWiki
//
//  Created by Luke on 01/03/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BirdIndexRootViewController.h"
#import	"JournalIndexViewController.h"


@interface MyTabBarController : UITabBarController {
	
	BirdIndexRootViewController *birdIndexViewController;
	JournalIndexViewController *journalViewController;

}

@property (nonatomic, retain) IBOutlet BirdIndexRootViewController *birdIndexViewController;
@property (nonatomic, retain) IBOutlet JournalIndexViewController *journalViewController;

@end
