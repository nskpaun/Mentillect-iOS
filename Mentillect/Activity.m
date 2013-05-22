//
//  Activity.m
//  Mentillect
//
//  Created by Nathan Spaun on 5/20/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import "Activity.h"
#import "Comment.h"

@implementation Activity

@synthesize user;
@synthesize text;
@synthesize activityInfo;
@synthesize type;
@synthesize referent;

+(NSArray*)getLatestActivities
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (Comment *c in [Comment recentComments]) {
        Activity *act = [[Activity alloc] init];
        act.type = CommentType;
        act.user = c.fromUser;
        act.text = c.text;
        act.activityInfo = [NSString stringWithFormat:@"Comment on %@",c.forPost.title];
        
        [array addObject:act];
    }
    
    return array;
    
}

@end
