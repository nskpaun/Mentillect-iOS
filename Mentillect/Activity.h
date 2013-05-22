//
//  Activity.h
//  Mentillect
//
//  Created by Nathan Spaun on 5/20/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MtUser.h"

typedef enum {
    CommentType,
    RatingType,
    PostType
} ActivityType;

@interface Activity : NSObject

@property(nonatomic)ActivityType type;
@property(nonatomic,strong)MtUser* user;
@property(nonatomic,strong)NSObject* referent;
@property(nonatomic,copy)NSString* text;
@property(nonatomic,copy)NSString* activityInfo;

+(NSArray*)getLatestActivities;

@end
