//
//  Post.m
//  Mentillect
//
//  Created by Nathan Spaun on 5/20/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import "Post.h"

@implementation Post

@synthesize object;
@synthesize url;
@synthesize picture;
@synthesize text;
@synthesize poster;
@synthesize created;

const NSString* postPicKey = @"thumbnail";
const NSString* postURLKey = @"URL";
const NSString* postTextKey = @"Text";
const NSString* postUserKey = @"User";


+(Post*)createWithPicture:(UIImage*)picture
                  withUrl:(NSString*)url
                 withText:(NSString*)text
               withPoster:(MtUser*)poster
{
    Post *p = [[Post alloc] init];
    p.picture = picture;
    p.url = url;
    p.text = text;
    p.poster = poster;
    
    return p;
    
}
-(BOOL)save
{
    PFObject *obj = [self pfSerialize];
    self.object = obj;
    return [obj save];
}
-(BOOL)update
{
    
}
-(BOOL)destroy
{
    
}
+(Post*)getPostById:(NSString*)postId {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query whereKey:@"objectId" equalTo:postId];
    
    return [self pfDeserialize:[[query findObjects] objectAtIndex:0]];
}

+(Post*)pfDeserialize:(PFObject*)post
{
    Post *p = [[Post alloc] init];
    PFFile *imgFile = [post objectForKey:postPicKey];
    NSData *data = [imgFile getData];
    p.picture = [UIImage imageWithData:data];
    PFUser *user = [post objectForKey:postUserKey];
    p.poster = [MtUser getUserById:user.objectId];
    p.text = [post objectForKey:postTextKey];
    p.url = [post objectForKey:postURLKey];
    p.object = post;
    
    return p;
}

-(PFObject*)pfSerialize
{
    PFObject *obj = [PFObject objectWithClassName:@"Post"];
    [obj setObject:url forKey:postURLKey];
    [obj setObject:poster._user forKey:postUserKey];
    [obj setObject:text forKey:postTextKey];
    NSData *data = UIImagePNGRepresentation(picture);
    PFFile *imageFile = [PFFile fileWithName:@"thumbnail.png" data:data];
    [obj setObject:imageFile forKey:postPicKey];
    

    
    return obj;
}

@end
