//
//  GroupsViewController.m
//  Mentillect
//
//  Created by Nathan Spaun on 6/3/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import "GroupsViewController.h"
#import "NewGroupViewController.h"
#import "Mentillect.h"
#import "MtGroup.h"

@interface GroupsViewController ()

@end

@implementation GroupsViewController

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
    groups = [MtGroup allGroups];
    [tableView setDataSource:self];
    [tableView setDelegate:self];
    [tableView reloadData];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)newGroupPressed:(id)sender {
    
    NewGroupViewController *ngvc = [[NewGroupViewController alloc] initWithNibName:@"NewGroupViewController" bundle:nil];
    [MentillectAppDelegate.navController pushViewController:ngvc animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MtGroup *group = [groups objectAtIndex:indexPath.row];
    [group join];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return groups.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MtGroup *group = [groups objectAtIndex:indexPath.row];
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    [cell.textLabel setText: [NSString stringWithFormat:@"Join group named: %@", group.name ]];
    return cell;
}


@end
