//
//  Post.h
//  Mentillect
//
//  Created by Nathan Spaun on 5/20/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MtUser.h"

@interface Post : NSObject

@property(nonatomic,copy) NSString* url;
@property(nonatomic,copy) UIImage* picture;
@property(nonatomic,copy) NSString* pictureUrl;
@property(nonatomic,copy) NSString* text;
@property(nonatomic,copy) NSString* title;
@property(nonatomic,strong) MtUser *poster;
@property(nonatomic,strong) NSDate* created;
@property(nonatomic,strong) NSDictionary* object;
@property(nonatomic,strong) NSNumber *mId;

+(Post*)createWithPicture:(UIImage*)picture
                  withUrl:(NSString*)url
                 withText:(NSString*)text
               withPoster:(MtUser*)poster
                withTitle:(NSString*)title;
-(BOOL)save;
-(BOOL)update;
-(BOOL)destroy;

+(Post*)getPostById:(NSNumber*)postId;
+(NSArray*)getRecentPosts;

@end
