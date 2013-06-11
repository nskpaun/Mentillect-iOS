//
//  GroupsViewController.h
//  Mentillect
//
//  Created by Nathan Spaun on 6/3/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate> {
    
    NSArray *groups;
    IBOutlet UITableView *tableView;
}

@end
