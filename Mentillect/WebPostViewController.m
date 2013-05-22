//
//  WebPostViewController.m
//  Mentillect
//
//  Created by Nathan Spaun on 5/21/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import "WebPostViewController.h"
#import "HTMLParser.h"
#import "HTMLNode.h"
#import "MtUser.h"
#import "Post.h"
#import "Comment.h"
#import "Mentillect.h"

@interface WebPostViewController ()

@end

@implementation WebPostViewController

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
    NSURL *url = [NSURL URLWithString:@"http://www.bing.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)backPressed:(id)sender {
    [webView goBack];
}
- (IBAction)goPressed:(id)sender {
    NSURL *url = [NSURL URLWithString:webAddress.text];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}
- (IBAction)postPressed:(id)sender {
    NSError *error = nil;
    NSString *htmlSource = [webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"];
    
    HTMLParser *parser = [[HTMLParser alloc] initWithString:htmlSource error:&error];
    
    if (error) {
        NSLog(@"Error: %@", error);
        return;
    }
    
    HTMLNode *bodyNode = [parser body];
    
    NSArray *imgNodes = [bodyNode findChildTags:@"img"];
    imgs = [[NSMutableArray alloc] init];
    
    for (HTMLNode *imgNode in imgNodes) {
        NSURL *url = [NSURL URLWithString:[imgNode getAttributeNamed:@"src"]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithData:data];
        if(img) [imgs addObject:img];
    }
    
    UITableViewController *tableView = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    [tableView.tableView setDelegate:self];
    [tableView.tableView setDataSource:self];
    myPopover = [[UIPopoverController alloc] initWithContentViewController:tableView];
    [myPopover presentPopoverFromRect:CGRectMake(100, 100, 500, 100) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return imgs.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.height, cell.frame.size.height)];
    [iv setImage:[imgs objectAtIndex:indexPath.row]];
    
    [cell addSubview:iv];
    
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [myPopover dismissPopoverAnimated:YES];
    NSString *url = webView.request.URL.absoluteString;
    NSString *title = titleText.text;
    if (title.length<1) {
        title = @"My Post";
    }
    
    Post *post = [Post createWithPicture:[imgs objectAtIndex:indexPath.row] withUrl:url withText:@"" withPoster:[MtUser getCurrentUser] withTitle:title];
    [post save];
    if (commentBox.text.length>0) {
        Comment *comm = [Comment createCommentWithText:commentBox.text fromUser:[MtUser getCurrentUser] toUser:nil forPost:post];
        [comm save];
    }
    
    [MentillectAppDelegate.navController popToRootViewControllerAnimated:YES];

}


@end
