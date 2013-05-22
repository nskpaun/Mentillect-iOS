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
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (PFObject *obj in [query findObjects])
    {
        [array addObject:[self pfDeserialize:obj]];
    }
    return array;
}
-(BOOL)ratingSave{
    PFObject *obj = [self pfSerialize];
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
    mtRating.user  = [MtUser getUserById:user.objectId];
    mtRating.number = [rating objectForKey:numberKey];
    mtRating.goal = [rating objectForKey:rGoalKey];
    mtRating.created = [rating objectForKey:dateKey];
    
    return mtRating;
}

-(BOOL)update
{
    
}
-(BOOL)destroy
{
    
}

@end
