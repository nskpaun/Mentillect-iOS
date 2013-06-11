//
//  MtLoginViewController.m
//  Mentillect
//
//  Created by Nathan Spaun on 5/20/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import "MtLoginViewController.h"
#import "MtUser.h"
#import <QuartzCore/QuartzCore.h>
#import "Mentillect.h"

@interface MtLoginViewController ()

@end

@implementation MtLoginViewController

@synthesize selectedImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)choosePhoto:(id)sender {
    picker = [[UIImagePickerController alloc] init];
    
    picker.delegate = self;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        
    {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
    } else
        
    {
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    }
    
    UIPopoverController *myPopover = [[UIPopoverController alloc] initWithContentViewController:picker];
    [myPopover presentPopoverFromRect:CGRectMake(100, 100, 400, 400) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    popover = myPopover;
    

    
}

- (IBAction)existingSignIn:(id)sender {
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Existing User" message:[NSString stringWithFormat:@"%@\n\n\n\n\n",@"signIn"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    nameText = [[UITextField alloc] init];
    [nameText setBackgroundColor:[UIColor whiteColor]];
    nameText.delegate = self;
    nameText.borderStyle = UITextBorderStyleLine;
    nameText.frame = CGRectMake(15, 75, 255, 30);

    nameText.placeholder = @"Username";
    nameText.textAlignment = UITextAlignmentCenter;
    nameText.keyboardAppearance = UIKeyboardAppearanceAlert;
    nameText.autocapitalizationType = NO;
    [nameText becomeFirstResponder];
    
    passText = [[UITextField alloc] init];
    [passText setBackgroundColor:[UIColor whiteColor]];
    passText.delegate = self;
    passText.borderStyle = UITextBorderStyleLine;
    passText.frame = CGRectMake(15, 115, 255, 30);

    passText.secureTextEntry = YES;
    passText.placeholder = @"Password";
    passText.textAlignment = UITextAlignmentCenter;
    passText.keyboardAppearance = UIKeyboardAppearanceAlert;
    
    [alert addSubview:nameText];
    [alert addSubview:passText];
    
    [alert show];
}


- (IBAction)signin:(id)sender {
    if ( !disable ) {
    disable = YES;
    if ( name.text && email.text && password.text && description.text && location.text && goal.text && selectedImage ) {
        dispatch_queue_t queue = dispatch_queue_create("com.mentillect.nkspaun", NULL);
        dispatch_async(queue, ^{
            MtUser *user1 = [MtUser createWithName:name.text withEmail:email.text withPassword:password.text withDescription:description.text withLocation:location.text withGoal:goal.text withImage:selectedImage];
            [user1 mtSave];
            dispatch_async(dispatch_get_main_queue(), ^{
                [MentillectAppDelegate.navController popViewControllerAnimated:YES];
            });
        });


        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sign Up"
                                                        message:@"You must enter all information"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        disable = NO;
    }
    }
}

- (void)viewDidLoad
{
    disable = NO;
    [super viewDidLoad];
    

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *) Picker {
    
    [popover dismissPopoverAnimated:YES];
    
}

- (void)imagePickerController:(UIImagePickerController *) Picker

    didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];

    [imagePreview setImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
    [[imagePreview layer] setCornerRadius:100.0f];
    
    [popover dismissPopoverAnimated:YES];
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ( passText.text.length > 0 && nameText.text.length > 0 ) {
        [MtUser login:nameText.text p:passText.text];
        [MentillectAppDelegate.navController popViewControllerAnimated:YES];
    }
}

@end
