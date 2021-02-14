//
//  ChangeNumberSeenViewController.h
//  NewBirdWiki
//
//  Created by Luke on 18/04/2011.
//  Copyright 2011 Luke Stringer Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ChangeNumberSeenViewController : UITableViewController {

	IBOutlet UITableViewCell *theCell;
	IBOutlet UITextField *countField;
	
}

@property (nonatomic, retain) IBOutlet UITableViewCell *theCell;
@property (nonatomic, retain) IBOutlet UITextField *countField;


@end
