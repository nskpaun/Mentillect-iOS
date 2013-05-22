//
//  JournalPostViewController.h
//  Mentillect
//
//  Created by Nathan Spaun on 5/21/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JournalPostViewController : UIViewController <UIImagePickerControllerDelegate> {
    
    IBOutlet UITextField *titleText;
    IBOutlet UITextView *textArea;
    IBOutlet UIButton *imageButton;
    UIPopoverController *myPopover;
        UIImagePickerController *picker;
}

@property (nonatomic, retain) UIImage * selectedImage;

@end
