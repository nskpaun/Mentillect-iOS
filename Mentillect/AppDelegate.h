//
//  AppDelegate.h
//  Mentillect
//
//  Created by Nathan Spaun on 5/20/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MtUser.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, NSURLConnectionDataDelegate, UITabBarControllerDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) MtUser *currentUser;
@property (nonatomic, strong) NSMutableDictionary *userCache;

@property (nonatomic, strong) UINavigationController *navController;

@property (nonatomic, readonly) int networkStatus;

- (BOOL)isParseReachable;

- (void)presentLoginViewController;
- (void)presentLoginViewControllerAnimated:(BOOL)animated;
- (void)presentTabBarController;

- (void)logOut;

@property (strong, nonatomic) UISplitViewController *splitViewController;

@end
