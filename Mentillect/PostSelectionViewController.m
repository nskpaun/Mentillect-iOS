//
//  PostSelectionViewController.m
//  Mentillect
//
//  Created by Nathan Spaun on 5/21/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import "PostSelectionViewController.h"
#import "WebPostViewController.h"
#import "JournalPostViewController.h"
#import "Mentillect.h"

@interface PostSelectionViewController ()

@end

@implementation PostSelectionViewController
- (IBAction)startWebPost:(id)sender {
    WebPostViewController *wpvc = [[WebPostViewController alloc] initWithNibName:@"WebPostViewController" bundle:nil];
    [MentillectAppDelegate.navController pushViewController:wpvc animated:NO];
}

- (IBAction)startLocalPost:(id)sender {
    JournalPostViewController *wpvc = [[JournalPostViewController alloc] initWithNibName:@"JournalPostViewController" bundle:nil];
    [MentillectAppDelegate.navController pushViewController:wpvc animated:NO];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
