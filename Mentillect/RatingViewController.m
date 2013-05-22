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
    
    Rating *rating = [Rating createRatingWithGoal:user.goal withUser:user withNumber: [NSNumber numberWithInt:val]];
    [rating ratingSave];
    [MentillectAppDelegate.navController popViewControllerAnimated:YES];
}

@end
