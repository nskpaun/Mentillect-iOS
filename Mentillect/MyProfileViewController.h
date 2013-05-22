//
//  DetailViewController.h
//  Mentillect
//
//  Created by Nathan Spaun on 5/20/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MtUser.h"

@interface MyProfileViewController : UIViewController <UISplitViewControllerDelegate> {
    MtUser *user;
}

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
