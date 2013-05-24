//
//  Activity.m
//  Mentillect
//
//  Created by Nathan Spaun on 5/20/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import "Activity.h"
#import "Comment.h"
#import "Rating.h"

@implementation Activity

@synthesize user;
@synthesize text;
@synthesize activityInfo;
@synthesize type;
@synthesize referent;

+(NSArray*)getLatestActivities
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSArray *ratingArray = [Rating recentRatings];
    
    int counter = 0;
    
    for (Comment *c in [Comment recentComments]) {
        if ( counter < [ratingArray count] ) {
            Rating *r = [ratingArray objectAtIndex:counter];
            Activity *a = [Activity alloc];
            a.type = RatingType;
            a.user = r.user;
            a.text = [NSString stringWithFormat:@"%@ rated their day %d",r.user.name, r.number.integerValue];
            a.activityInfo = [NSString stringWithFormat:@"Goal: %@",r.goal];
            [array addObject:a];
            counter++;
        }
        Activity *act = [[Activity alloc] init];
        act.type = CommentType;
        act.user = c.fromUser;
        act.text = c.text;
        if ( c.forPost ) act.activityInfo = [NSString stringWithFormat:@"Comment on %@",c.forPost.title];
        else if (c.toUser) act.activityInfo = [NSString stringWithFormat:@"to %@",c.toUser.name];
        
        [array addObject:act];
    }
    
    return array;
    
}

@end
