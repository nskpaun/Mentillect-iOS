//
//  StoryTableViewDelegate.m
//  Mentillect
//
//  Created by Nathan Spaun on 5/22/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import "StoryTableViewDelegate.h"
#import "HorizontalTableView.h"
#import "StoryCell.h"
#import "Post.h"

@implementation StoryTableViewDelegate


-(id)initWithStories:(NSArray*)stories{
    self = [super init];
    if (self) {
        _stories = stories;
    }
    return self;

}

- (NSInteger)numberOfColumnsForTableView:(HorizontalTableView *)tableView {
    return [_stories count];
}

- (UIView *)tableView:(HorizontalTableView *)aTableView viewForIndex:(NSInteger)index {
    
    StoryCell *cell = nil;
    
    Post *post = [_stories objectAtIndex:index];
    
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"StoryCell" owner:nil options:nil];
    
    for(id currentObject in topLevelObjects)
    {
        if([currentObject isKindOfClass:[StoryCell class]])
        {
            cell = (StoryCell *)currentObject;
            break;
        }
    }
    
    [cell.imageLabel setImage: post.picture];
    [cell.userImageLabel setImage: post.poster.picture];
    [cell.titleLabel setText:post.title];
    
	return cell;
}

- (CGFloat)columnWidthForTableView:(HorizontalTableView *)tableView {
    return 180.0f;
}

@end
