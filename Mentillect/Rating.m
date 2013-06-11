//
//  Rating.m
//  Mentillect
//
//  Created by Nathan Spaun on 5/20/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import "Rating.h"
#import "ApiHelper.h"

@implementation Rating

@synthesize user;
@synthesize number;
@synthesize created;
@synthesize goal;
@synthesize object;

const NSString* userKey = @"forUser";
const NSString* dateKey = @"createdDate";
const NSString* rGoalKey = @"goal";
const NSString* numberKey = @"number";
const NSString* rExtraKey = @"extras";

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
    NSString *urlString = [NSString stringWithFormat:@"/users/%d/ratings/", user.mId.integerValue ];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *obj in [ApiHelper getDataFrom:urlString])
    {
        [array addObject:[self pfDeserialize:obj] ];
    }
    return array;
}

-(Rating*)getLast
{
    NSString *urlString = [NSString stringWithFormat:@"/users/%d/ratings/", user.mId.integerValue ];
    NSArray *array = [ApiHelper getDataFrom:urlString];
    if (array.count > 1 ) {
        NSDictionary *obj = [array objectAtIndex:array.count-2];
        return [Rating pfDeserialize:obj] ;
    }
   
    return nil;
}

-(BOOL)ratingSave{
    NSDictionary *obj = [self pfSerialize];
    
    [ApiHelper postDataFrom:@"/ratings/" withParams:[ApiHelper dictToString:obj] withAuth:NO];
    
    if ( number.integerValue > 50 ) {
        user.rating= [NSNumber numberWithInt:user.rating.integerValue + 1];
        if (user.rating.integerValue > 19) user.rating = [NSNumber numberWithInt:0];
        Rating *prev = [self getLast];
        if (prev) {
            if ( prev.number.integerValue < 50 ) {
                user.comebacks = [NSNumber numberWithInt:user.comebacks.integerValue+1 ];
                
            }
        }
        [user update];
    }
    
    return YES;

}

-(NSDictionary*)pfSerialize
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    self.object = [[NSMutableDictionary alloc] init];
    [self.object setValue:user.mId forKey:userKey];
    [self.object setValue:number forKey:numberKey];
    
    [self.object setValue:[dateFormat stringFromDate:created] forKey:dateKey];
    [self.object setValue:goal forKey:rGoalKey];
    [self.object setValue:@"null" forKey:rExtraKey];
    
    
    return self.object;
}

+(Rating*)pfDeserialize:(NSDictionary*)rating
{
    Rating* mtRating = [[Rating alloc] init];
    mtRating.object = rating;
    NSNumber * num =  [rating objectForKey:userKey];
    mtRating.user  = [MtUser getUserById: num.integerValue];
    mtRating.number = [rating objectForKey:numberKey];
    mtRating.goal = [rating objectForKey:rGoalKey];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    mtRating.created = [dateFormat dateFromString:[rating objectForKey:dateKey]];
    
    return mtRating;
}

+(NSArray*)recentRatings {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *obj in [ApiHelper getDataFrom:@"/ratings/"])
    {
        [array addObject:[self pfDeserialize:obj] ];
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
