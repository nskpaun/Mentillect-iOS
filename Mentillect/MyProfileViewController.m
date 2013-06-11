//
//  DetailViewController.m
//  Mentillect
//
//  Created by Nathan Spaun on 5/20/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import "MyProfileViewController.h"
#import "MtLoginViewController.h"
#import "Mentillect.h"
#import "Activity.h"
#import "Post.h"
#import "Rating.h"
#import <QuartzCore/QuartzCore.h>

@interface MyProfileViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation MyProfileViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [activityContainer.layer setBorderColor:mentDarkGray.CGColor];
    [activityContainer.layer setBorderWidth:1];
    [graphContainer.layer setBorderColor:mentDarkGray.CGColor];
    [graphContainer.layer setBorderWidth:1];
    [storyContainer.layer setBorderColor:mentDarkGray.CGColor];
    [storyContainer.layer setBorderWidth:1];
    

	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    user = [MtUser getCurrentUser];
    if (!user || user.mId.integerValue<1) {
        MtLoginViewController *livc = [[MtLoginViewController alloc] initWithNibName:@"MtLoginViewController" bundle:nil];
        [MentillectAppDelegate.navController pushViewController:livc animated:YES];
    } else {
        [profileImage setImage:user.picture];
        [profileImage.layer setCornerRadius:profileImage.frame.size.height/2];
        profileImage.clipsToBounds = YES;
        [userName setText:user.name];
        [userScore setText:[NSString stringWithFormat:@"%d", user.rating.integerValue]];
        [userComebacks setText:[NSString stringWithFormat:@"%d", user.comebacks.integerValue]];

        [userDesc setText:user.description];
        [userLocation setText:user.location];
        UIActivityIndicatorView *activityView=[[UIActivityIndicatorView alloc]     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        activityView.frame = CGRectMake(200, 200, 300, 200);
        [activityView setBackgroundColor:[UIColor blackColor]];
        [activityView setAlpha:0.5f];
        
        
        [activityView startAnimating];
        
        [self.view addSubview:activityView];
        
        UIActivityIndicatorView *activityView1=[[UIActivityIndicatorView alloc]     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        activityView1.frame = CGRectMake(200, 500, 300, 100);
        [activityView1 setBackgroundColor:[UIColor blackColor]];
        [activityView1 setAlpha:0.5f];
        
        
        [activityView1 startAnimating];
        
        [self.view addSubview:activityView1];
        

        
//        dispatch_queue_t queue = dispatch_queue_create("com.mentillect.nkspaun", NULL);
//        dispatch_async(queue, ^{
//            dispatch_async(dispatch_get_main_queue(), ^{
//            });
//        });
        
        
        dispatch_queue_t queue = dispatch_queue_create("com.mentillect.nkspaun", NULL);
        dispatch_async(queue, ^{
            activityTableDelegate = [[ActivityTableviewDelegate alloc] initWithActivities:[Activity getLatestActivities]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [activityTable setDataSource:activityTableDelegate];
                [activityTable setDelegate:activityTableDelegate];
                [activityTable reloadData];
                [activityView removeFromSuperview];
            });
        });
        dispatch_queue_t queue1 = dispatch_queue_create("com.mentillect.nkspaun1", NULL);
        dispatch_async(queue1, ^{
            storyTableDelegate = [[StoryTableViewDelegate alloc] initWithStories:[Post getRecentPosts]];
 
            dispatch_async(dispatch_get_main_queue(), ^{

                [storiesTable setDelegate:storyTableDelegate];
                [storiesTable refreshData];
                [storiesTable setBackgroundColor:[UIColor clearColor]];
                [activityView1 removeFromSuperview];
            });
        });

        [self setUpLineGraph];
            


        
        [self setUpPieChart];
    
    }
    
    
}

-(void)setUpPieChart
{
    pieChartDatasource = [[PieChartDataSource alloc] initWithCurrent:user.rating.integerValue withMax:20];
    
    CPTGraph *graph1 = [[CPTXYGraph alloc] initWithFrame:pieGraphHost.bounds];
    pieGraphHost.hostedGraph = graph1;

    graph1.paddingLeft = 0.0f;
    graph1.paddingTop = 0.0f;
    graph1.paddingRight = 0.0f;
    graph1.paddingBottom = 0.0f;
    graph1.axisSet = nil;
    // 2 - Set up text style
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    textStyle.color = [CPTColor grayColor];
    textStyle.fontName = @"Helvetica-Bold";
    textStyle.fontSize = 16.0f;
    // 3 - Configure title

    // 4 - Set theme



    // 2 - Create chart
    CPTPieChart *pieChart = [[CPTPieChart alloc] init];
    pieChart.dataSource = pieChartDatasource;
    pieChart.pieRadius = (pieGraphHost.bounds.size.height * 1.00) / 2;

    pieChart.startAngle = 0;
    pieChart.sliceDirection = CPTPieDirectionCounterClockwise;
    // 3 - Create gradient

    // 4 - Add chart to graph    
    [graph1 addPlot:pieChart];
    [pieGraphHost setBackgroundColor:[UIColor clearColor]];
        [graph setBackgroundColor:[UIColor clearColor].CGColor];
    
}

-(void)setUpLineGraph
{
    UIActivityIndicatorView *activityView2=[[UIActivityIndicatorView alloc]     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    activityView2.frame = CGRectMake(500, 200, 300, 200);
    [activityView2 setBackgroundColor:[UIColor blackColor]];
    [activityView2 setAlpha:0.5f];
    
    
    [activityView2 startAnimating];
    
    [self.view addSubview:activityView2];
    
    dispatch_queue_t queue2 = dispatch_queue_create("com.mentillect.nkspaun2", NULL);
    dispatch_async(queue2, ^{
        NSArray * ratings = [Rating getRatingsForUser:user withGoal:user.goal];
        lineChartDatasource = [[LineChartDatasource alloc] initWithRatings: ratings];
        dispatch_async(dispatch_get_main_queue(), ^{
            graph = [[CPTXYGraph alloc] initWithFrame: lineGraphHost.bounds];
            [graph setBackgroundColor:mentMediumGray.CGColor];
            
            lineGraphHost.hostedGraph = graph;
            
            [lineGraphHost.layer setBorderColor:mentDarkGray.CGColor];
            [lineGraphHost.layer setBorderWidth:1.0f];
            
            CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
            plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0)
                                                            length:CPTDecimalFromFloat(ratings.count+1)];
            plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0)
                                                            length:CPTDecimalFromFloat(100)];
            
            
            
            CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
            textStyle.color = [CPTColor grayColor];
            textStyle.fontName = @"Helvetica-Bold";
            textStyle.fontSize = 16.0f;
            
            graph.title = @"";
            graph.titleTextStyle = textStyle;
            graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
            graph.titleDisplacement = CGPointMake(0.0f, -12.0f);
            
            CPTPlotSymbol *symbol = [CPTPlotSymbol ellipsePlotSymbol];
            symbol.fill = [CPTFill fillWithColor:[CPTColor colorWithCGColor:mentLightOrange.CGColor]];
            symbol.size = CGSizeMake(10.0, 10.0);
            symbol.lineStyle = nil;
            CPTScatterPlot *lineScatterPlot = [[CPTScatterPlot alloc] initWithFrame:lineGraphHost.bounds];
            lineScatterPlot.dataSource = lineChartDatasource;
            lineScatterPlot.plotSymbol = symbol;
            [lineScatterPlot reloadData];

            [graph addPlot:lineScatterPlot];
            
            for ( CPTAxis *axis in graph.axisSet.axes ) {
                BOOL hidden = YES;
                
                axis.hidden = hidden;
                for (CPTAxisLabel *axisLabel in axis.axisLabels) {
                    axisLabel.contentLayer.hidden = hidden;
                }
            }
            [activityView2 removeFromSuperview];
        });
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Profile", @"Profile");
    }
    return self;
}
							
#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Menu", @"Menu");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

- (BOOL)splitViewController:(UISplitViewController*)svc
   shouldHideViewController:(UIViewController *)vc
              inOrientation:(UIInterfaceOrientation)orientation
{
    return YES;
}

@end
