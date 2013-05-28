//
//  ReadPostViewController.h
//  Mentillect
//
//  Created by Nathan Spaun on 5/24/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@interface ReadPostViewController : UIViewController <UITableViewDataSource> {
    
    IBOutlet UIWebView *webView;
    IBOutlet UITableView *commentTable;
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *nameLabel;
    
    Post *_post;
    NSArray *_comments;
    UITextField *textField;
    
}

-(id)initWithPost:(Post*)p;

@end
