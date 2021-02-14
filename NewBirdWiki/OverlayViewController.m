//
//  OverlayViewController.m
//  NewBirdWiki
//
//  Created by Luke on 01/04/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import "OverlayViewController.h"
#import "SearchBirdIndexViewController.h"

@implementation OverlayViewController
@synthesize rvController;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[rvController resetTapped:nil];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[rvController release];
    [super dealloc];
}


@end
