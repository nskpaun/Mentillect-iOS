//
//  DetailViewController.h
//  Mentillect
//
//  Created by Nathan Spaun on 5/20/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MtUser.h"
#import "ActivityTableviewDelegate.h"
#import "StoryTableViewDelegate.h"
#import "HorizontalTableView.h"

@interface MyProfileViewController : UIViewController <UISplitViewControllerDelegate> {
    MtUser *user;
    ActivityTableviewDelegate *activityTableDelegate;
    StoryTableViewDelegate *storyTableDelegate;
    IBOutlet UITableView *activityTable;
    IBOutlet HorizontalTableView *storiesTable;
}

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
