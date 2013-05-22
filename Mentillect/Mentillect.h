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
