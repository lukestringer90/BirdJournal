//
//  OverlayViewController.h
//  NewBirdWiki
//
//  Created by Luke on 01/04/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchBirdIndexViewController.h"

@class SearchBirdIndexViewController;

@interface OverlayViewController : UIViewController {
	
	SearchBirdIndexViewController *rvController;
}

@property (nonatomic, retain) SearchBirdIndexViewController *rvController;
@property BOOL wasTouched;

@end

