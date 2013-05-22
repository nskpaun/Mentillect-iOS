//
//  Mentillect.m
//  Mentillect
//
//  Created by Nathan Spaun on 5/20/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import "Mentillect.h"

@implementation MentillectSingleton

MentillectSingleton *Mentillect;

const NSString* COLOR_ORANGE = @"F68820";
const NSString* COLOR_GREEN = @"99CA3E";
const NSString* COLOR_PURPLE = @"9C6AAD";
const NSString* COLOR_RED = @"E5454A";
const NSString* COLOR_PALE_GRAY = @"EBF0F2";
const NSString* COLOR_LIGHT_GRAY = @"CED5D9";
const NSString* COLOR_MEDIUM_GRAY = @"929FA6";
const NSString* COLOR_MEDIUM_DARK_GRAY = @"4A5257";
const NSString* COLOR_DARK_GRAY = @"262A2B";
const NSString* COLOR_BLUE = @"37B4E2";


- (NSString *)generateUUIDString
{
//    // create a new UUID which you own
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
//
//    // create a new CFStringRef (toll-free bridged to NSString)
//    // that you own
    NSString *uuidString = (__bridge NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuid);
//
//    // release the UUID
    CFRelease(uuid);
//
    return uuidString;
}

- (BOOL)directoryExistsAtAbsolutePath:(NSString*)filename
{
    BOOL isDirectory;
    BOOL fileExistsAtPath = [[NSFileManager defaultManager] fileExistsAtPath:filename isDirectory:&isDirectory];
    
    return fileExistsAtPath && isDirectory;
}

- (UIBarButtonItem*)customNavButton
{
    UIImage *buttonImage = [UIImage imageNamed:@"nav_next"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [button setImage:buttonImage forState:UIControlStateNormal];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
    
}

-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

@end
