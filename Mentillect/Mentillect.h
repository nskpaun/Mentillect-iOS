//
//  Mentillect.h
//  Mentillect
//
//  Created by Nathan Spaun on 5/20/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

#define MentillectAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define mentDarkGray [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0 alpha:0.25f]
#define mentLightGreen [UIColor colorWithRed:227.0/255.0 green:255.0/255.0 blue:222.0/255.0 alpha:1.0f]
#define mentLightOrange [UIColor colorWithRed:255.0/255.0 green:168.0/255.0 blue:76.0/255.0 alpha:1.0f]
#define mentMediumGray [UIColor colorWithRed:226.0/255.0 green:226.0/255.0 blue:226.0/255.0 alpha:1.0f]

@interface MentillectSingleton : NSObject

extern const NSString* COLOR_ORANGE;
extern const NSString* COLOR_GREEN;
extern const NSString* COLOR_PURPLE;
extern const NSString* COLOR_RED;
extern const NSString* COLOR_PALE_GRAY;
extern const NSString* COLOR_LIGHT_GRAY;
extern const NSString* COLOR_MEDIUM_GRAY;
extern const NSString* COLOR_MEDIUM_DARK_GRAY;
extern const NSString* COLOR_DARK_GRAY;
extern const NSString* COLOR_BLUE;



- (NSString *)generateUUIDString;
- (BOOL)directoryExistsAtAbsolutePath:(NSString*)filename;
- (UIColor*)colorWithHexString:(NSString*)hex;
- (UIBarButtonItem*)customNavButton;

@end

extern MentillectSingleton *Mentillect;
