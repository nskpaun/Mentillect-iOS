//
//  ActivityTableviewDelegate.m
//  Mentillect
//
//  Created by Nathan Spaun on 5/22/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import "ActivityTableviewDelegate.h"
#import "ActivityCell.h"
#import "Activity.h"
#import "Comment.h"

@implementation ActivityTableviewDelegate

- (id)initWithActivities:(NSArray *)activities {
    self = [super init];
    if (self) {
        _activities = activities;
    }
    return self;
}

#pragma mark Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Activity *a = [_activities objectAtIndex:indexPath.row];
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Comment" message:[NSString stringWithFormat:@"%@\n\n\n",a.text] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    alert.tag = indexPath.row;
    textField = [[UITextField alloc] init];
    [textField setBackgroundColor:[UIColor whiteColor]];
    textField.delegate = self;
    textField.borderStyle = UITextBorderStyleLine;
    textField.frame = CGRectMake(15, 75, 255, 30);
    textField.font = [UIFont fontWithName:@"ArialMT" size:20];
    textField.placeholder = @"Comment";
    textField.textAlignment = UITextAlignmentCenter;
    textField.keyboardAppearance = UIKeyboardAppearanceAlert;
    [textField becomeFirstResponder];
    [alert addSubview:textField];
    [alert show];
}

#pragma mark Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _activities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ActivityCell";

    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Activity *activity = [_activities objectAtIndex:indexPath.row];
    
    if (cell == nil){
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ActivityCell" owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[ActivityCell class]])
            {
                cell = (ActivityCell *)currentObject;
                break;
            }
        }
    }
    
    [cell.imageView setImage:activity.user.picture];
    [cell.userName setText:activity.user.name];
    [cell.commentText setText:activity.text];
    [cell.activityInfo setText:activity.activityInfo];
    
    
    
    return cell;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString* detailString = textField.text;
    NSLog(@"String is: %@", detailString); //Put it on the debugger
    if ([textField.text length] <= 0 || buttonIndex == 0){
        return; //If cancel or 0 length string the string doesn't matter
    }
    if (buttonIndex == 1) {
        Activity *a = [_activities objectAtIndex: alertView.tag];
        Comment *comment = [Comment createCommentWithText:textField.text fromUser:[MtUser getCurrentUser] toUser:a.user forPost:nil];
        [comment save];
    }
}


@end
