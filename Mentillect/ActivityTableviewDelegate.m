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



@end
