//
//  MasterViewController.h
//  Mentillect
//
//  Created by Nathan Spaun on 5/20/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyProfileViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) MyProfileViewController *detailViewController;

@end
