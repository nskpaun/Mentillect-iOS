//
//  RatingViewController.h
//  Mentillect
//
//  Created by Nathan Spaun on 5/21/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MtUser.h"

@interface RatingViewController : UIViewController {
    
    IBOutlet UILabel *scoreLabel;
    IBOutlet UISlider *score;
    IBOutlet UILabel *goalLabel;
    
    MtUser *user;
}


-(id)initWithUser:(MtUser*)u;

@end
