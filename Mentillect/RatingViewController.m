//
//  RatingViewController.m
//  Mentillect
//
//  Created by Nathan Spaun on 5/21/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import "RatingViewController.h"
#import "Mentillect.h"
#import "Rating.h"

@interface RatingViewController ()

@end

@implementation RatingViewController

-(id)initWithUser:(MtUser*)u{
    self = [super initWithNibName:@"RatingViewController" bundle:nil];
    if (self) {
        user = u;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [goalLabel setText:user.goal];
    
    [score addTarget:self action:@selector(changedSlider:) forControlEvents:UIControlEventTouchDragInside];
    // Do any additional setup after loading the view from its nib.
}

-(void)changedSlider:(id)sender {
    int val = score.value;
    NSString *txt = [NSString stringWithFormat:@"%d",val];
    [scoreLabel setText:txt];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submitRating:(id)sender {
    int val = score.value;
    
    dispatch_queue_t queue = dispatch_queue_create("com.mentillect.nkspaun", NULL);
    
    UIActivityIndicatorView *activityView=[[UIActivityIndicatorView alloc]     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.frame = CGRectMake(200, 200, 300, 200);
    [activityView setBackgroundColor:[UIColor blackColor]];
    [activityView setAlpha:0.5f];
    [activityView startAnimating];
    [self.view addSubview:activityView];
    
    dispatch_async(queue, ^{
        Rating *rating = [Rating createRatingWithGoal:user.goal withUser:user withNumber: [NSNumber numberWithInt:val]];
        [rating ratingSave];
        dispatch_async(dispatch_get_main_queue(), ^{
            [activityView removeFromSuperview];
            [MentillectAppDelegate.navController popViewControllerAnimated:YES];
        });
    });



}

@end
