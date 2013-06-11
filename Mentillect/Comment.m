//
//  Comment.m
//  Mentillect
//
//  Created by Nathan Spaun on 5/20/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import "Comment.h"
#import "ApiHelper.h"

@implementation Comment
@synthesize text;
@synthesize fromUser;
@synthesize toUser;
@synthesize forPost;
@synthesize object;
@synthesize date;

const NSString* cTextKey = @"text";
const NSString* cFromKey = @"fromUser";
const NSString* cToKey = @"toUser";
const NSString* cForKey = @"forPost";
const NSString* cDateKey = @"createdDate";
const NSString* cExtrasKey = @"extras";


+(Comment*)createCommentWithText:(NSString*)text
                        fromUser:(MtUser*)fuser
                          toUser:(MtUser*)tuser
                         forPost:(Post*)post
{
    Comment *comment = [[Comment alloc] init];
    comment.text = text;
    comment.toUser = tuser;
    comment.fromUser = fuser;
    comment.forPost = post;
    comment.date = [NSDate date];
    
    return comment;
}

+(NSArray*)commentsForPost:(Post*)post
{
    NSString *urlString = [NSString stringWithFormat:@"/posts/%d/comments/", post.mId.integerValue ];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (NSDictionary *obj in [ApiHelper getDataFrom:urlString] ) {
        [array addObject:[Comment pfDeserialize:obj]];
    }
    
    return array;
}

+(NSArray*)recentComments {
    
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (NSDictionary *obj in [ApiHelper getDataFrom:@"/comments/"]) {
        [array addObject:[Comment pfDeserialize:obj]];
    }
    
    return array;
}


-(BOOL)save
{
    NSDictionary *obj = [self pfSerialize];
    
    [ApiHelper postDataFrom:@"/comments/" withParams:[ApiHelper dictToString:obj ] withAuth:NO];
    
    return YES;
    
}
-(BOOL)update
{
    return NO;
}
-(BOOL)destroy
{
    return NO;
}

-(NSDictionary*)pfSerialize
{
    NSMutableDictionary *obj = [[NSMutableDictionary alloc] init];
    [obj setObject:text forKey:cTextKey];
    [obj setObject:fromUser.mId forKey:cFromKey];
    if(toUser)    {[obj setObject:toUser.mId forKey:cToKey];}
//    else {
//        [obj setObject:[NSNumber numberWithInt:fromUser.mId.integerValue] forKey:cToKey];
//    }
    if (forPost) {
        [obj setObject:forPost.mId forKey:cForKey];
    }
//    else {
//        [obj setObject:[NSNumber numberWithInt:2] forKey:cToKey];
//    }
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    [obj setObject:[dateFormat stringFromDate:date] forKey:cDateKey];
    [obj setObject:@"null" forKey:cExtrasKey];
    return obj;
}

+(Comment*)pfDeserialize:(NSDictionary*)comm
{
    Comment *c = [[Comment alloc] init];
    c.text = [comm objectForKey:cTextKey];
    NSNumber *user = [comm objectForKey:cFromKey];
    c.fromUser = [MtUser getUserById:user.integerValue];
    user = [comm objectForKey:cToKey];
    if (![user isEqual:[NSNull null]])  c.toUser = [MtUser getUserById:user.integerValue];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    c.date = [dateFormat dateFromString:[comm objectForKey:cDateKey]];
    
    NSNumber *post = [comm objectForKey:cForKey];
    if (![post isEqual:[NSNull null]]) c.forPost = [Post getPostById:post];
    
    c.object = comm;
    
    return c;
}

@end
