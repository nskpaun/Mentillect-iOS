//
//  Rating.h
//  Mentillect
//
//  Created by Nathan Spaun on 5/20/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MtUser.h"

@interface Rating : NSObject

@property(nonatomic,strong)NSDate* created;
@property(nonatomic,strong)MtUser* user;
@property(nonatomic)NSNumber* number;
@property(nonatomic,copy)NSString* goal;
@property(nonatomic,strong)PFObject* object;

+(Rating*)createRatingWithGoal:(NSString*)goal
                      withUser:(MtUser*)user
                    withNumber:(NSNumber*)number;
+(NSArray*)getRatingsForUser:(MtUser*)user withGoal:(NSString*)goal;
+(NSArray*)recentRatings;

-(BOOL)ratingSave;
-(BOOL)update;
-(BOOL)destroy;

@end
