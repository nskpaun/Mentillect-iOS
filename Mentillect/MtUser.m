//
//  User.m
//  Mentillect
//
//  Created by Nathan Spaun on 5/20/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import "MtUser.h"
#import "ApiHelper.h"
#import "Mentillect.h"
#import "S3Uploader.h"

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
@synthesize pictureUrl;
@synthesize mId;

const NSString* nameKey = @"username";
const NSString* passwordKey = @"password";
const NSString* emailKey = @"email";
const NSString* descKey = @"description";
const NSString* locationKey = @"location";
const NSString* goalKey = @"goal";
const NSString* pictureKey = @"pictureUrl";
const NSString* comebacksKey = @"comebacks";
const NSString* ratingKey = @"userRating";
const NSString* idKey = @"id";
const NSString* extraKey = @"extras";

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
    user.pictureUrl = [NSString stringWithFormat:@"profilepic_%@", name ];
    

    
    return user;
}

-(BOOL)mtSave
{
    NSDictionary *user = [self pfSerialize];
    NSDictionary *dict = [ApiHelper postDataFrom:@"/users/" withParams:[ApiHelper dictToString:user] withAuth:NO];
    
    if (![[dict objectForKey:idKey] isEqual:@""]) {
        [S3Uploader uploadToS3:picture withKey:pictureUrl];
        [[NSUserDefaults standardUserDefaults] setValue:name forKey:@"u"];
        [[NSUserDefaults standardUserDefaults] setValue:password forKey:@"p"];
    }
    
    return YES;
}

-(BOOL)update
{
    NSMutableDictionary *dict =[[NSMutableDictionary alloc] initWithDictionary:self._user];
    self._user = dict;
    [self._user setValue:email forKey:emailKey];

    [self._user setValue:name forKey:nameKey];
    [self._user setValue:description forKey:descKey];
    [self._user setValue:location forKey:locationKey];
    [self._user setValue:goal forKey:goalKey];
    [self._user setValue:comebacks forKey:comebacksKey];
    [self._user setValue:rating forKey:ratingKey];
    [self._user setValue:pictureUrl forKey:pictureKey];
    
    NSNumber *num = [self._user objectForKey:idKey];
    NSString *urlString = [NSString stringWithFormat:@"/users/%d/", num.integerValue];
    [ApiHelper postDataFrom:urlString withParams:[ApiHelper dictToString:dict] withAuth:NO];
    
    return true;
}

-(BOOL)destroy
{
    return NO;
}
+(MtUser*)getCurrentUser
{
    if (MentillectAppDelegate.currentUser) {
        return MentillectAppDelegate.currentUser;
    } else {
        NSDictionary *cuser = [ApiHelper postDataFrom:@"/MtLogin/" withParams:@"" withAuth:YES];
        if(![[cuser objectForKey:idKey] isEqual:@""]) {
            return [self pfDeserialize:cuser];
        }
    }
    
    return nil;
}
+(MtUser*)getUserById:(int)userId
{
    MtUser *user = [MentillectAppDelegate.userCache objectForKey:[NSNumber numberWithInt:userId]];
    if (user) return user;
    NSDictionary *dict = [ApiHelper getDataFrom:[NSString stringWithFormat:@"/users/%d/",userId]];
    user = [self pfDeserialize:dict];
    [MentillectAppDelegate.userCache setObject:user forKey:user.mId];
    return user;
    
}

-(NSString*)getObjectId {
    [self._user objectForKey:idKey];
    return [self._user objectForKey:idKey];
}

-(NSDictionary*)pfSerialize
{
    NSDictionary *user = [[NSMutableDictionary alloc] init];
    [user setValue:email forKey:emailKey];
    [user setValue:name forKey:nameKey];
    [user setValue:password forKey:passwordKey];
    [user setValue:description forKey:descKey];
    [user setValue:location forKey:locationKey];
    [user setValue:goal forKey:goalKey];
    [user setValue:comebacks forKey:comebacksKey];
    [user setValue:rating forKey:ratingKey];
    [user setValue:pictureUrl forKey:pictureKey];
    [user setValue:@"null" forKey:extraKey];
    
    self._user = user;
    
    return user;
}

+(MtUser*)pfDeserialize:(NSDictionary*)user
{
    MtUser *muser = [[MtUser alloc] init];
    muser.mId = [user objectForKey:idKey];
    muser.name = [user objectForKey:nameKey];
    muser.email = [user objectForKey:emailKey];
    muser.password = [user objectForKey:passwordKey];
    muser.description = [user objectForKey:descKey];
    muser.location = [user objectForKey:locationKey];
    muser.goal = [user objectForKey:goalKey];
    muser.pictureUrl = [user objectForKey:pictureKey];
    NSData *data = [S3Uploader downloadFromKey:muser.pictureUrl];
    muser.picture = [UIImage imageWithData:data];
    muser.comebacks = [user objectForKey:comebacksKey];
    muser.rating = [user objectForKey:ratingKey];
    muser._user = user;
    
    return muser;
}
+(void*)login:(NSString*)u p:(NSString*)p {
    [[NSUserDefaults standardUserDefaults] setValue:u forKey:@"u"];
    [[NSUserDefaults standardUserDefaults] setValue:p forKey:@"p"];
}

-(void*)logout
{
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"u"];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"p"];
    
    [ApiHelper getDataFrom:@"/MtLogout/"];
    
    MentillectAppDelegate.currentUser = nil;
    
}
@end
