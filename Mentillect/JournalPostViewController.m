//
//  JournalPostViewController.m
//  Mentillect
//
//  Created by Nathan Spaun on 5/21/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import "JournalPostViewController.h"
#import "Post.h"
#import "MtUser.h"
#import "Mentillect.h"
#import <QuartzCore/QuartzCore.h>

@interface JournalPostViewController ()

@end

@implementation JournalPostViewController
@synthesize selectedImage;

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

- (IBAction)selectImage:(id)sender {
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

- (IBAction)post:(id)sender {
    if (selectedImage) {
        Post *p = [Post createWithPicture:selectedImage withUrl:@"" withText:textArea.text withPoster:[MtUser getCurrentUser]];
        [p save];
        [MentillectAppDelegate.navController popToRootViewControllerAnimated:YES];
    }

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
    
    [imageButton setBackgroundImage:[info objectForKey:UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
    [[imageButton layer] setCornerRadius:100.0f];
    
    [myPopover dismissPopoverAnimated:YES];
    
}

@end
