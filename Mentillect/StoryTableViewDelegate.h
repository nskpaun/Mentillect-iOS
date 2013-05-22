//
//  StoryTableViewDelegate.h
//  Mentillect
//
//  Created by Nathan Spaun on 5/22/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HorizontalTableView.h"

@interface StoryTableViewDelegate : NSObject <HorizontalTableViewDelegate> {
    NSArray *_stories;
}

-(id)initWithStories:(NSArray*)stories;

@end
