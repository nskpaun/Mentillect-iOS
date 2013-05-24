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

	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

-(void)viewDidAppear:(BOOL)animated
{

    [super viewDidAppear:animated];
    user = [MtUser getCurrentUser];
    if (!user) {
        MtLoginViewController *livc = [[MtLoginViewController alloc] initWithNibName:@"MtLoginViewController" bundle:nil];
        [MentillectAppDelegate.navController pushViewController:livc animated:YES];
    } else {
        UIActivityIndicatorView *activityView=[[UIActivityIndicatorView alloc]     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        activityView.center=self.view.center;
        
        [activityView startAnimating];
        
        [self.view addSubview:activityView];
        
//        dispatch_queue_t queue = dispatch_queue_create("com.mentillect.nkspaun", NULL);
//        dispatch_async(queue, ^{
//            dispatch_async(dispatch_get_main_queue(), ^{
//            });
//        });
        
        
        dispatch_queue_t queue = dispatch_queue_create("com.mentillect.nkspaun", NULL);
        dispatch_async(queue, ^{
            activityTableDelegate = [[ActivityTableviewDelegate alloc] initWithActivities:[Activity getLatestActivities]];
            [activityTable setDataSource:activityTableDelegate];
            [activityTable setDelegate:activityTableDelegate];
            [activityTable reloadData];
            
            storyTableDelegate = [[StoryTableViewDelegate alloc] initWithStories:[Post getRecentPosts]];
            [storiesTable setDelegate:storyTableDelegate];
            [storiesTable refreshData];
            
            [self setUpLineGraph];
            [self setUpPieChart];
            dispatch_async(dispatch_get_main_queue(), ^{
                [activityView removeFromSuperview];
            });
        });
    
    }
    
    
}

-(void)setUpPieChart
{
    pieChartDatasource = [[PieChartDataSource alloc] initWithCurrent:15 withMax:20];
    
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
    NSString *title = @"Portfolio Prices: May 1, 2012";
    graph1.title = title;
    graph1.titleTextStyle = textStyle;
    graph1.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    graph1.titleDisplacement = CGPointMake(0.0f, -12.0f);
    // 4 - Set theme

    [graph1 applyTheme:[CPTTheme themeNamed:kCPTPlainWhiteTheme]];

    // 2 - Create chart
    CPTPieChart *pieChart = [[CPTPieChart alloc] init];
    pieChart.dataSource = pieChartDatasource;
    pieChart.pieRadius = (pieGraphHost.bounds.size.height * 0.7) / 2;

    pieChart.startAngle = M_PI_4;
    pieChart.sliceDirection = CPTPieDirectionClockwise;
    // 3 - Create gradient
    CPTGradient *overlayGradient = [[CPTGradient alloc] init];
    overlayGradient.gradientType = CPTGradientTypeRadial;
    overlayGradient = [overlayGradient addColorStop:[[CPTColor blackColor] colorWithAlphaComponent:0.0] atPosition:0.9];
    overlayGradient = [overlayGradient addColorStop:[[CPTColor blackColor] colorWithAlphaComponent:0.4] atPosition:1.0];
    pieChart.overlayFill = [CPTFill fillWithGradient:overlayGradient];
    // 4 - Add chart to graph    
    [graph1 addPlot:pieChart];
    
}

-(void)setUpLineGraph
{
    lineChartDatasource = [[LineChartDatasource alloc] initWithRatings:[Rating getRatingsForUser:user withGoal:user.goal]];
    graph = [[CPTXYGraph alloc] initWithFrame: lineGraphHost.bounds];
    
    lineGraphHost.hostedGraph = graph;
    
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0)
                                                    length:CPTDecimalFromFloat(30)];
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
    
    CPTScatterPlot *lineScatterPlot = [[CPTScatterPlot alloc] initWithFrame:lineGraphHost.bounds];
    lineScatterPlot.dataSource = lineChartDatasource;
    [lineScatterPlot reloadData];
    [graph addPlot:lineScatterPlot];
    
    for ( CPTAxis *axis in graph.axisSet.axes ) {
        BOOL hidden = YES;
        
        axis.hidden = hidden;
        for (CPTAxisLabel *axisLabel in axis.axisLabels) {
            axisLabel.contentLayer.hidden = hidden;
        }
    }
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
        self.title = NSLocalizedString(@"Detail", @"Detail");
    }
    return self;
}
							
#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
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
