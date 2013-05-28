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
#import "ReadPostViewController.h"
#import "Mentillect.h"
#import <QuartzCore/QuartzCore.h>

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
            [cell.readButton addTarget:self action:@selector(openPost:) forControlEvents:UIControlEventTouchUpInside];
            break;
        }
    }
    
    [cell.innerView.layer setBorderWidth:1.0f];
    [cell.innerView.layer setBorderColor:mentDarkGray.CGColor];
    [cell.innerView.layer setCornerRadius:5.0f];
    
    [cell.imageLabel setImage: post.picture];
    [cell.userImageLabel setImage: post.poster.picture];
    [cell.userImageLabel.layer setCornerRadius: cell.userImageLabel.frame.size.height/2];
    cell.userImageLabel.clipsToBounds = YES;
    [cell.titleLabel setText:post.title];
    [cell.readButton setTag:index];
    
	return cell;
}

- (void)openPost:(id)sender {
    UIButton *cellButton = sender;
    Post *p = [_stories objectAtIndex: cellButton.tag];
    
    ReadPostViewController *rpvc = [[ReadPostViewController alloc] initWithPost:p];
    [MentillectAppDelegate.navController pushViewController:rpvc animated:YES];
    
    
}

- (CGFloat)columnWidthForTableView:(HorizontalTableView *)tableView {
    return 270.0f;
}

@end
