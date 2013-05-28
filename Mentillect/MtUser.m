//
//  User.m
//  Mentillect
//
//  Created by Nathan Spaun on 5/20/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import "MtUser.h"
#import <Parse/Parse.h>

@implementation MtUser

@synthesize email;
@synthesize name;
@synthesize password;
@synthesize description;
@synthesize location;
@synthesize goal;
@synthesize picture;
@synthesize comebacks;
@synthesize rating;
@synthesize _user;

const NSString* descKey = @"Description";
const NSString* locationKey = @"Location";
const NSString* goalKey = @"Goal";
const NSString* pictureKey = @"Picture";
const NSString* comebacksKey = @"Comebacks";
const NSString* ratingKey = @"Rating";

+(MtUser*)   createWithName:(NSString*)name
                  withEmail:(NSString*)email
               withPassword:(NSString*)password
            withDescription:(NSString*)description
               withLocation:(NSString*)location
                   withGoal:(NSString*)goal
                  withImage:(UIImage*)image
{
    MtUser *user = [[MtUser alloc] init];
    user.name = name;
    user.email = email;
    user.password = password;
    user.description = description;
    user.location = location;
    user.goal = goal;
    user.picture = image;
    user.comebacks = [NSNumber numberWithInt:0];
    user.rating = [NSNumber numberWithInt:0];
    
    return user;
}

-(BOOL)mtSave
{
    PFUser *user = [self pfSerialize];
    
    [user signUp];
    
    [user save];
    
    return YES;
    
}

-(BOOL)update
{
    [self._user setEmail:email];

    [self._user setUsername:name];
    [self._user setObject:description forKey:descKey];
    [self._user setObject:location forKey:locationKey];
    [self._user setObject:goal forKey:goalKey];
    [self._user setObject:comebacks forKey:comebacksKey];
    [self._user setObject:rating forKey:ratingKey];
    NSData *data = UIImagePNGRepresentation(picture);
    PFFile *imageFile = [PFFile fileWithName:@"image.png" data:data];
    [self._user setObject:imageFile forKey:pictureKey];
    
    return [self._user save];
}

-(BOOL)destroy
{
    return NO;
}
+(MtUser*)getCurrentUser
{
    PFUser *cuser = [PFUser currentUser];
    [cuser refresh];
    if(cuser) {
        return [self pfDeserialize:cuser];
    }
    
    return nil;
}
+(MtUser*)getUserById:(NSString*)userId
{
    PFQuery *query = [PFUser query];
    [query whereKey:@"objectId" containedIn:[NSArray arrayWithObject:userId]];
    NSArray* array = [query findObjects];
    return [self pfDeserialize:[array objectAtIndex:0]];
    
}

-(NSString*)getObjectId {
    return [self._user objectId];
}

-(PFUser*)pfSerialize
{
    PFUser *user = [[PFUser alloc] init];
    [user setEmail:email];
    [user setPassword:password];
    [user setUsername:name];
    [user setObject:description forKey:descKey];
    [user setObject:location forKey:locationKey];
    [user setObject:goal forKey:goalKey];
    [user setObject:comebacks forKey:comebacksKey];
    [user setObject:rating forKey:ratingKey];
    NSData *data = UIImagePNGRepresentation(picture);
    PFFile *imageFile = [PFFile fileWithName:@"image.png" data:data];
    [user setObject:imageFile forKey:pictureKey];
    
    self._user = user;
    
    return user;
}

+(MtUser*)pfDeserialize:(PFUser*)user
{
    MtUser *muser = [[MtUser alloc] init];
    muser.name = [user username];
    muser.email = [user email];
    muser.password = [user password];
    muser.description = [user objectForKey:descKey];
    muser.location = [user objectForKey:locationKey];
    muser.goal = [user objectForKey:goalKey];
    PFFile *imgFile = [user objectForKey:pictureKey];
    NSData *data = [imgFile getData];
    muser.picture = [UIImage imageWithData:data];
    muser.comebacks = [user objectForKey:comebacksKey];
    muser.rating = [user objectForKey:ratingKey];
    muser._user = user;
    
    return muser;
}

@end
