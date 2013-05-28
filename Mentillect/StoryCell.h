//
//  StoryCell.h
//  Mentillect
//
//  Created by Nathan Spaun on 5/22/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoryCell : UIView

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageLabel;
@property (strong, nonatomic) IBOutlet UIImageView *userImageLabel;
@property (strong, nonatomic) IBOutlet UIButton *readButton;
@property (strong, nonatomic) IBOutlet UIView *innerView;



@end
