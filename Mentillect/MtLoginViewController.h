//
//  MtLoginViewController.h
//  Mentillect
//
//  Created by Nathan Spaun on 5/20/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MtLoginViewController : UIViewController {
    
    IBOutlet UITextField *name;
    IBOutlet UITextField *email;
    IBOutlet UITextField *password;
    
    IBOutlet UITextField *location;
    
    IBOutlet UITextField *goal;
    IBOutlet UITextField *description;
    
    IBOutlet UIImageView *imagePreview;
    UIImagePickerController *picker;
    
    IBOutlet UIImage * selectedImage;
    
    UIPopoverController *popover;

    UITextField *nameText;
    UITextField *passText;
    
    BOOL disable;
    
}

@property (nonatomic, retain) UIImage * selectedImage;

@end
