//
//  Comment.m
//  Mentillect
//
//  Created by Nathan Spaun on 5/20/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import "Comment.h"

@implementation Comment
@synthesize text;
@synthesize fromUser;
@synthesize toUser;
@synthesize forPost;
@synthesize object;

const NSString* cTextKey = @"Text";
const NSString* cFromKey = @"FromUser";
const NSString* cToKey = @"ToUser";
const NSString* cForKey = @"ForPost";

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
    
    return comment;
}

+(NSArray*)commentsForPost:(Post*)post
{
    PFQuery *query = [PFQuery queryWithClassName:@"Comment"];
    [query whereKey:cForKey equalTo:post.object.objectId];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (PFObject *obj in [query findObjects]) {
        [array addObject:[Comment pfDeserialize:obj]];
    }
    
    return array;
}

+(NSArray*)recentComments {
    PFQuery *query = [PFQuery queryWithClassName:@"Comment"];
    [query setLimit:50];
    [query orderByDescending:@"createdAt"];
    
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (PFObject *obj in [query findObjects]) {
        [array addObject:[Comment pfDeserialize:obj]];
    }
    
    return array;
}


-(BOOL)save
{
    PFObject *obj = [self pfSerialize];
    self.object = obj;
    return [obj save];
    
}
-(BOOL)update
{
    return NO;
}
-(BOOL)destroy
{
    return NO;
}

-(PFObject*)pfSerialize
{
    PFObject *obj = [PFObject objectWithClassName:@"Comment"];
    [obj setObject:text forKey:cTextKey];
    [obj setObject:fromUser._user forKey:cFromKey];
    if(toUser)    [obj setObject:toUser._user forKey:cToKey];
    if (forPost)  [obj setObject:forPost.object forKey:cForKey];
    
    return obj;
}

+(Comment*)pfDeserialize:(PFObject*)comm
{
    Comment *c = [[Comment alloc] init];
    c.text = [comm objectForKey:cTextKey];
    PFUser *user = [comm objectForKey:cFromKey];
    [user fetchIfNeeded];
    c.fromUser = [MtUser pfDeserialize:user];
    user = [comm objectForKey:cToKey];
    [user fetchIfNeeded];
    c.toUser = [MtUser pfDeserialize:user];
    
    PFObject *post = [comm objectForKey:cForKey];
    if (post) c.forPost = [Post getPostById:post.objectId];
    
    c.object = comm;
    
    return c;
}

@end
