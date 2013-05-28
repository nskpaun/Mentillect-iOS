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
#import "LineChartDatasource.h"
#import "PieChartDataSource.h"
#import <CorePlot-CocoaTouch.h>

@interface MyProfileViewController : UIViewController <UISplitViewControllerDelegate> {
    MtUser *user;
    
    ActivityTableviewDelegate *activityTableDelegate;
    StoryTableViewDelegate *storyTableDelegate;
    LineChartDatasource *lineChartDatasource;
    PieChartDataSource *pieChartDatasource;
    
    
    IBOutlet UIImageView *profileImage;
    IBOutlet UITableView *activityTable;
    IBOutlet HorizontalTableView *storiesTable;
    IBOutlet CPTGraphHostingView *lineGraphHost;
    IBOutlet CPTGraphHostingView *pieGraphHost;
    
    IBOutlet UIView *activityContainer;
    IBOutlet UIView *graphContainer;
    IBOutlet UIView *storyContainer;
    
    IBOutlet UILabel *userLocation;
    IBOutlet UILabel *userDesc;
    IBOutlet UILabel *userName;
    IBOutlet UILabel *userScore;
    IBOutlet UILabel *userComebacks;
    
    CPTXYGraph *graph;
}

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
