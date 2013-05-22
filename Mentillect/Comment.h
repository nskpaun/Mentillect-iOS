//
//  Comment.h
//  Mentillect
//
//  Created by Nathan Spaun on 5/20/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MtUser.h"
#import "Post.h"
#import <Parse/Parse.h>

@interface Comment : NSObject

@property(nonatomic,copy)NSString* text;
@property(nonatomic,strong)MtUser* fromUser;
@property(nonatomic,strong)MtUser* toUser;
@property(nonatomic,strong)Post* forPost;
@property(nonatomic,strong)NSDate* date;
@property(nonatomic,strong)PFObject* object;

+(Comment*)createCommentWithText:(NSString*)text
                     fromUser:(MtUser*)fuser
                       toUser:(MtUser*)tuser
                         forPost:(Post*)post;

+(NSArray*)commentsForPost:(Post*)post;
+(NSArray*)recentComments;


-(BOOL)save;
-(BOOL)update;
-(BOOL)destroy;

@end
