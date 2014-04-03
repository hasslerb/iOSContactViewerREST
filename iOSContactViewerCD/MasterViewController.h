//
//  MasterViewController.h
//  iOSContactViewerCD
//
//  Created by Diorelle Ramos on 3/25/14.
//  Copyright (c) 2014 Diorelle Ramos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddContactViewController.h"
#import "DetailViewController.h"

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate, AddContactViewControllerDelegate,DetailViewDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
