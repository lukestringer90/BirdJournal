//
//  MyCustomTableView.m
//  NewBirdWiki
//
//  Created by Luke on 04/04/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import "MyCustomTableView.h"


@implementation MyCustomTableView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"Touched");
	[super touchesBegan:touches withEvent:event];
}

- (void)reloadData {
	NSLog(@"reloading");
	[super reloadData];
}

@end
