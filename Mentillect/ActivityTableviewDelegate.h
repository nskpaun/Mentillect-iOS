//
//  ActivityTableviewDelegate.h
//  Mentillect
//
//  Created by Nathan Spaun on 5/22/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityTableviewDelegate : NSObject <UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate> {
    NSArray* _activities;
    UITextField *textField;
}

-(id)initWithActivities:(NSArray*)activities;

@end
