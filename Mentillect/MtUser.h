//
//  User.h
//  Mentillect
//
//  Created by Nathan Spaun on 5/20/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MtUser : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *email;
@property(nonatomic, copy) NSString *password;
@property(nonatomic, copy) NSString *description;
@property(nonatomic, copy) NSString *location;
@property(nonatomic, copy) NSString *goal;
@property(nonatomic, copy) NSString *pictureUrl;
@property(nonatomic, strong) UIImage *picture;
@property(nonatomic, strong) NSNumber *comebacks;
@property(nonatomic, strong) NSNumber *rating;
@property(nonatomic, strong) NSDictionary* _user;
@property(nonatomic, strong) NSNumber *mId;

+(MtUser*)   createWithName:(NSString*)name
                withEmail:(NSString*)email
                withPassword:(NSString*)password
                withDescription:(NSString*)description
                withLocation:(NSString*)location
                withGoal:(NSString*)goal
                withImage:(UIImage*)image;
-(BOOL)mtSave;
-(BOOL)update;
-(BOOL)destroy;
-(NSString*)getObjectId;
+(MtUser*)getCurrentUser;
+(void*)login:(NSString*)u p:(NSString*)p;
+(MtUser*)pfDeserialize:(NSDictionary*)user;
+(MtUser*)getUserById:(int)userId;
-(void*)logout;

@end
