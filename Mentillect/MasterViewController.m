//
//  MasterViewController.m
//  Mentillect
//
//  Created by Nathan Spaun on 5/20/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import "MasterViewController.h"

#import "MyProfileViewController.h"
#import "Mentillect.h"
#import "RatingViewController.h"
#import "PostSelectionViewController.h"
#import "GroupsViewController.h"
#import "MtLoginViewController.h"
#import "MtUser.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Menu", @"Menu");
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self insertNewObject:@"Log Out"];
    [self insertNewObject:@"Groups"];
    [self insertNewObject:@"New Post"];
    [self insertNewObject:@"Rate Your Day"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:sender atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }


    NSString *object = _objects[indexPath.row];
    cell.textLabel.text = object;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        RatingViewController *rvc = [[RatingViewController alloc]initWithUser:[MtUser getCurrentUser]];
        [MentillectAppDelegate.navController pushViewController:rvc animated:YES];
    } else if (indexPath.row == 1){
        PostSelectionViewController *psvc = [[PostSelectionViewController alloc]initWithNibName:@"PostSelectionViewController" bundle:nil];
        [MentillectAppDelegate.navController pushViewController:psvc animated:YES];
    } else if ( indexPath.row == 2 ) {
        GroupsViewController *ngvc = [[GroupsViewController alloc] initWithNibName:@"GroupsViewController" bundle:nil];
        [MentillectAppDelegate.navController pushViewController:ngvc animated:YES];
    } else if ( indexPath.row == 3 ) {
        [[MtUser getCurrentUser] logout];
        [MentillectAppDelegate.navController popToRootViewControllerAnimated:YES];
        MtLoginViewController *ngvc = [[MtLoginViewController alloc] initWithNibName:@"MtLoginViewController" bundle:nil];
        [MentillectAppDelegate.navController pushViewController:ngvc animated:YES];
    }
}

@end
