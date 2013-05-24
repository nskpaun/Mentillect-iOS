//
//  Rating.m
//  Mentillect
//
//  Created by Nathan Spaun on 5/20/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import "Rating.h"

@implementation Rating

@synthesize user;
@synthesize number;
@synthesize created;
@synthesize goal;
@synthesize object;

const NSString* userKey = @"User";
const NSString* dateKey = @"Date";
const NSString* rGoalKey = @"Goal";
const NSString* numberKey = @"Number";

+(Rating*)createRatingWithGoal:(NSString*)goal
                      withUser:(MtUser*)user
                    withNumber:(NSNumber*)number
{
    Rating *rating = [[Rating alloc] init];
    rating.goal = goal;
    rating.user = user;
    rating.number = number;
    rating.created = [NSDate date];
    
    return rating;
    
}
+(NSArray*)getRatingsForUser:(MtUser*)user withGoal:(NSString*)goal
{
    PFQuery *query = [PFQuery queryWithClassName:@"Rating"];
    [query whereKey:userKey equalTo:user._user];
    [query orderByAscending:@"createdAt"];
    [query setLimit:100];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (PFObject *obj in [query findObjects])
    {
        [array addObject:[self pfDeserialize:obj]];
    }
    return array;
}

-(Rating*)getLast
{
    PFQuery *query = [PFQuery queryWithClassName:@"Rating"];
    [query whereKey:userKey equalTo:user._user];
    [query orderByDescending:@"createdAt"];
    [query setLimit:1];
    for (PFObject *obj in [query findObjects])
    {
        return [Rating pfDeserialize:obj];
    }
    return nil;
}

-(BOOL)ratingSave{
    PFObject *obj = [self pfSerialize];
    
    if ( number.integerValue > 50 ) {
        user.rating= [NSNumber numberWithInt:user.rating.integerValue + 1];
        Rating *prev = [self getLast];
        if (prev) {
            if ( prev.number.integerValue < 50 ) {
                user.comebacks = [NSNumber numberWithInt:user.comebacks.integerValue+1 ];
                
            }
        }
        [user update];
    }
    
    return [obj save];

}

-(PFObject*)pfSerialize
{
    self.object = [PFObject objectWithClassName:@"Rating"];
    [self.object setObject:user._user forKey:userKey];
    [self.object setObject:number forKey:numberKey];
    [self.object setObject:created forKey:dateKey];
    [self.object setObject:goal forKey:rGoalKey];
    
    return self.object;
}

+(Rating*)pfDeserialize:(PFObject*)rating
{
    Rating* mtRating = [[Rating alloc] init];
    mtRating.object = rating;
    PFUser *user = [rating objectForKey:userKey];
    [user fetchIfNeeded];
    mtRating.user  = [MtUser pfDeserialize:user];
    mtRating.number = [rating objectForKey:numberKey];
    mtRating.goal = [rating objectForKey:rGoalKey];
    mtRating.created = [rating objectForKey:dateKey];
    
    return mtRating;
}

+(NSArray*)recentRatings {
    PFQuery *query = [PFQuery queryWithClassName:@"Rating"];
    [query setLimit:50];
    [query orderByDescending:@"createdAt"];
    
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (PFObject *obj in [query findObjects]) {
        [array addObject:[Rating pfDeserialize:obj]];
    }
    
    return array;
}

-(BOOL)update
{
    
}
-(BOOL)destroy
{
    
}

@end
