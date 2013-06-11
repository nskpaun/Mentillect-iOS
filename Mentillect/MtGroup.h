//
//  MtGroup.h
//  Mentillect
//
//  Created by Nathan Spaun on 6/1/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MtUser.h"

@interface MtGroup : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *picUrl;
@property (nonatomic,strong) UIImage *picture;
@property (nonatomic,strong) NSNumber *mId;
@property (nonatomic,strong) MtUser *mtAdmin;
@property (nonatomic,strong) NSDictionary *dict;

+(MtGroup*)createGroup:(NSString*)name
           withPicture:(UIImage*)picture;
+(MtGroup*)allGroups;


-(void)join;
-(void)leave;

-(BOOL)save;

@end
