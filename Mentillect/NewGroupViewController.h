//
//  NewGroupViewController.h
//  Mentillect
//
//  Created by Nathan Spaun on 6/1/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewGroupViewController : UIViewController {
    UIImagePickerController *picker;
    UIPopoverController *myPopover;
}

@property (strong, nonatomic) IBOutlet UITextField *titleText;
@property (nonatomic, retain) UIImage * selectedImage;

@end
