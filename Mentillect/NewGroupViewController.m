//
//  NewGroupViewController.m
//  Mentillect
//
//  Created by Nathan Spaun on 6/1/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import "NewGroupViewController.h"
#import "MtGroup.h"
#import "Mentillect.h"

@interface NewGroupViewController ()

@end

@implementation NewGroupViewController

@synthesize selectedImage;
@synthesize titleText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)createPressed:(id)sender {
    picker = [[UIImagePickerController alloc] init];
    
    picker.delegate = self;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        
    {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
    } else
        
    {
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    }
    
    myPopover = [[UIPopoverController alloc] initWithContentViewController:picker];
    [myPopover presentPopoverFromRect:CGRectMake(100, 100, 400, 400) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *) Picker {
    
    [myPopover dismissPopoverAnimated:YES];
    
}

- (void)imagePickerController:(UIImagePickerController *) Picker

didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [myPopover dismissPopoverAnimated:YES];
    
    
    [myPopover dismissPopoverAnimated:YES];

    NSString *title = titleText.text;
    if (title.length<1) {
        title = @"My Group";
    }
    
    MtGroup *group  = [MtGroup createGroup:title withPicture:selectedImage];
    
    UIActivityIndicatorView *activityView=[[UIActivityIndicatorView alloc]     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.frame = CGRectMake(200, 200, 300, 200);
    [activityView setBackgroundColor:[UIColor blackColor]];
    [activityView setAlpha:0.5f];
    [activityView startAnimating];
    [self.view addSubview:activityView];
    
    dispatch_queue_t queue = dispatch_queue_create("com.mentillect.nkspaun", NULL);
    
    dispatch_async(queue, ^{
        [group save];
        dispatch_async(dispatch_get_main_queue(), ^{
            [activityView removeFromSuperview];
            [MentillectAppDelegate.navController popToRootViewControllerAnimated:YES];
        });
    });
    
}

@end
