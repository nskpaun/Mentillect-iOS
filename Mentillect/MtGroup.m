//
//  MtGroup.m
//  Mentillect
//
//  Created by Nathan Spaun on 6/1/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import "MtGroup.h"
#import "MtUser.h"
#import "ApiHelper.h"
#import "S3Uploader.h"

@implementation MtGroup

@synthesize name;
@synthesize picture;
@synthesize picUrl;
@synthesize mId;
@synthesize dict;
@synthesize mtAdmin;

const NSString *gNameKey = @"name";
const NSString *gPicKey = @"pictureUrl";
const NSString *adminKey = @"gAdmin";
const NSString *gmIdKey = @"id";

+(MtGroup*)createGroup:(NSString*)name
           withPicture:(UIImage*)picture
{
    MtGroup *group = [[MtGroup alloc] init];
    
    group.name = name;
    group.picture = picture;
    group.mtAdmin = [MtUser getCurrentUser];
    
    return group;
    
}

-(BOOL)save
{
    NSMutableDictionary *dict = [self mtSerialize];
    [ApiHelper postDataFrom:@"/groups/" withParams:[ApiHelper dictToString:dict] withAuth:NO];
    [S3Uploader uploadToS3:self.picture withKey:self.picUrl];
    
    return YES;
}

+(MtGroup*)allGroups
{

    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for ( NSDictionary *g in [ApiHelper getDataFrom:@"/groups/"] ) {
            MtGroup *group = [MtGroup mtDeserialize:g];
            [array addObject:group];
    }
    return array;
}


-(NSDictionary*)mtSerialize
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:name forKey:gNameKey];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    NSString *key = [NSString stringWithFormat:@"group_pic_%d_%@", mtAdmin.mId.integerValue, [dateFormat stringFromDate:[NSDate date]] ];
    self.picUrl = key;
    [dict setObject:key forKey:gPicKey];
    [dict setObject:mtAdmin.mId forKey:adminKey];
    
    self.dict = dict;
    
    return dict;
    
    
}

+(MtGroup*)mtDeserialize:(NSDictionary *)dict
{
    MtGroup *group = [[MtGroup alloc] init];
    group.name = [dict objectForKey:gNameKey];
    group.mId = [dict objectForKey:gmIdKey];
    group.picUrl = [dict objectForKey:gPicKey];
    
    group.mtAdmin = [dict objectForKey:adminKey];
    
    NSData *data = [S3Uploader downloadFromKey:group.picUrl];
    group.picture = [UIImage imageWithData:data];
    
    
    
    group.dict = dict;
    
    return group;
}

-(void)join
{
    [ApiHelper getDataFrom:[NSString stringWithFormat:@"/groups/%d/join", self.mId.integerValue]];
}

-(void)leave
{
    [ApiHelper getDataFrom:[NSString stringWithFormat:@"/groups/%d/leave", self.mId.integerValue]];
}

@end
