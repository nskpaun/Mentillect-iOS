//
//  Post.m
//  Mentillect
//
//  Created by Nathan Spaun on 5/20/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import "Post.h"
#import "S3Uploader.h"
#import "ApiHelper.h"


@implementation Post

@synthesize object;
@synthesize url;
@synthesize picture;
@synthesize text;
@synthesize poster;
@synthesize created;
@synthesize title;
@synthesize mId;
@synthesize pictureUrl;

const NSString* postPicKey = @"thumbnailUrl";
const NSString* postURLKey = @"url";
const NSString* postTextKey = @"text";
const NSString* postUserKey = @"user";
const NSString* postTitleKey = @"title";
const NSString* pDateKey = @"createdDate";
const NSString* pmIdKey = @"id";
const NSString* pExtrasKey = @"extras";


+(Post*)createWithPicture:(UIImage*)picture
                  withUrl:(NSString*)url
                 withText:(NSString*)text
               withPoster:(MtUser*)poster
                withTitle:(NSString *)title
{
    Post *p = [[Post alloc] init];
    p.picture = picture;
    p.url = url;
    p.text = text;
    p.poster = poster;
    p.title = title;
    p.created = [NSDate date];
    
    return p;
    
}
-(BOOL)save
{
    NSDictionary *obj = [self pfSerialize];
    obj = [ApiHelper postDataFrom:@"/posts/" withParams:[ApiHelper dictToString:obj] withAuth:NO];

    NSNumber *myId = [obj objectForKey:pmIdKey];
    if (myId){
        NSString *key = pictureUrl;
        [S3Uploader uploadToS3:picture withKey:key];
        return YES;
    }
    return NO;
}
-(BOOL)update
{
    
}
-(BOOL)destroy
{
    
}
+(Post*)getPostById:(NSNumber*)postId {
    NSDictionary *obj = [ApiHelper getDataFrom:[NSString stringWithFormat:@"/posts/%d/",postId.integerValue]];
    return [self pfDeserialize:obj];
}

+(NSArray*)getRecentPosts
{
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (NSDictionary *obj in [ApiHelper getDataFrom:@"/posts/"]) {
        [array addObject:[Post pfDeserialize:obj]];
    }
    
    return array;
}

+(Post*)pfDeserialize:(NSDictionary*)post
{
    Post *p = [[Post alloc] init];
    NSString *keyString = [post objectForKey:postPicKey];
    NSData *data = [S3Uploader downloadFromKey:keyString];
    p.picture = [UIImage imageWithData:data];
    NSNumber *user = [post objectForKey:postUserKey];
    p.poster = [MtUser getUserById:user.integerValue];
    p.text = [post objectForKey:postTextKey];
    p.url = [post objectForKey:postURLKey];
    p.title = [post objectForKey:postTitleKey];
    p.mId = [post objectForKey:pmIdKey];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    p.created = [dateFormat dateFromString:[post objectForKey:pDateKey]];
    p.object = post;
    
    return p;
}

-(NSDictionary*)pfSerialize
{
    NSMutableDictionary *obj = [[NSMutableDictionary alloc] init];
    [obj setObject:url forKey:postURLKey];
    [obj setObject:poster.mId forKey:postUserKey];
    [obj setObject:text forKey:postTextKey];

    [obj setObject:title forKey:postTitleKey];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    [obj setObject:[dateFormat stringFromDate:created] forKey:pDateKey];
    
    self.pictureUrl = [NSString stringWithFormat:@"postthumbnail_%d_%@", poster.mId.integerValue, [dateFormat stringFromDate:created]];
    
    [obj setObject:pictureUrl forKey:postPicKey];
    [obj setObject:@"null" forKey:pExtrasKey];
    

    
    return obj;
}

@end
