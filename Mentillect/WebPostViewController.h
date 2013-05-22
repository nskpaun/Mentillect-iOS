//
//  WebPostViewController.h
//  Mentillect
//
//  Created by Nathan Spaun on 5/21/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebPostViewController : UIViewController <UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource> {
    IBOutlet UIWebView *webView;
    IBOutlet UITextField *commentBox;
    NSMutableArray *imgs;
    UIPopoverController *myPopover;
    IBOutlet UITextField *webAddress;
}

@end
