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
@synthesize selectedImage;

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
    picker = [[UIImagePickerController alloc] init];
    
    picker.delegate = self;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        
    {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
    } else
        
    {
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    }
    
    myPopover = [[UIPopoverController alloc] initWithContentViewController:picker];
    [myPopover presentPopoverFromRect:CGRectMake(100, 100, 400, 400) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//    NSError *error = nil;
//    NSString *htmlSource = [webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"];
//    
//    HTMLParser *parser = [[HTMLParser alloc] initWithString:htmlSource error:&error];
//    
//    if (error) {
//        NSLog(@"Error: %@", error);
//        return;
//    }
//    
//    HTMLNode *bodyNode = [parser body];
//    
//    NSArray *imgNodes = [bodyNode findChildTags:@"img"];
//    imgs = [[NSMutableArray alloc] init];
//    NSString *location = [webView stringByEvaluatingJavaScriptFromString:@"window.location"];
//    
//    UIActivityIndicatorView *activityView=[[UIActivityIndicatorView alloc]     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    activityView.frame = CGRectMake(200, 200, 300, 200);
//    [activityView setBackgroundColor:[UIColor blackColor]];
//    [activityView setAlpha:0.5f];
//    [activityView startAnimating];
//    [self.view addSubview:activityView];
//    
//    dispatch_queue_t queue = dispatch_queue_create("com.mentillect.nkspaun", NULL);
//    dispatch_async(queue, ^{
//        @try {
//            for (HTMLNode *imgNode in imgNodes) {
//                NSString *urlString = [NSString stringWithFormat:@"%@%@",location,[imgNode getAttributeNamed:@"src"] ];
//                NSURL *url = [NSURL URLWithString:[imgNode getAttributeNamed:@"src"]];
//                NSData *data = [NSData dataWithContentsOfURL:url];
//                
//                UIImage *img = [UIImage imageWithData:data];
//                if(img) [imgs addObject:img];
//                
//                url = [NSURL URLWithString:urlString];
//                data = [NSData dataWithContentsOfURL:url];
//                
//                img = [UIImage imageWithData:data];
//                if(img) [imgs addObject:img];
//            }
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [activityView removeFromSuperview];
//                UITableViewController *tableView = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
//                [tableView.tableView setDelegate:self];
//                [tableView.tableView setDataSource:self];
//                myPopover = [[UIPopoverController alloc] initWithContentViewController:tableView];
//                [myPopover presentPopoverFromRect:CGRectMake(100, 100, 500, 100) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//            });
//        }
//        @catch (NSException *e) {
//            
//        } @finally {
//            
//        }
//    });
    

    
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

    
    UIActivityIndicatorView *activityView=[[UIActivityIndicatorView alloc]     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.frame = CGRectMake(200, 200, 300, 200);
    [activityView setBackgroundColor:[UIColor blackColor]];
    [activityView setAlpha:0.5f];
    [activityView startAnimating];
    [self.view addSubview:activityView];
    
    dispatch_queue_t queue = dispatch_queue_create("com.mentillect.nkspaun", NULL);
    if (commentBox.text.length>0) {
        
        Comment *comm = [Comment createCommentWithText:commentBox.text fromUser:[MtUser getCurrentUser] toUser:nil forPost:post];
        
        dispatch_async(queue, ^{
            [comm save];
            dispatch_async(dispatch_get_main_queue(), ^{
         
            });
        });
        
    }


    dispatch_async(queue, ^{
        [post save];
        dispatch_async(dispatch_get_main_queue(), ^{
            [activityView removeFromSuperview];
            [MentillectAppDelegate.navController popToRootViewControllerAnimated:YES];
        });
    });

    


}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *) Picker {
    
    [myPopover dismissPopoverAnimated:YES];
    
}

- (void)imagePickerController:(UIImagePickerController *) Picker

didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [myPopover dismissPopoverAnimated:YES];
    
    
    [myPopover dismissPopoverAnimated:YES];
    NSString *url = webView.request.URL.absoluteString;
    NSString *title = titleText.text;
    if (title.length<1) {
        title = @"My Post";
    }
    Post *post = [Post createWithPicture:selectedImage withUrl:url withText:@"" withPoster:[MtUser getCurrentUser] withTitle:title];
    
    
    UIActivityIndicatorView *activityView=[[UIActivityIndicatorView alloc]     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.frame = CGRectMake(200, 200, 300, 200);
    [activityView setBackgroundColor:[UIColor blackColor]];
    [activityView setAlpha:0.5f];
    [activityView startAnimating];
    [self.view addSubview:activityView];
    
    dispatch_queue_t queue = dispatch_queue_create("com.mentillect.nkspaun", NULL);
    if (commentBox.text.length>0) {
        
        Comment *comm = [Comment createCommentWithText:commentBox.text fromUser:[MtUser getCurrentUser] toUser:nil forPost:post];
        
        dispatch_async(queue, ^{
            [comm save];
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
        });
        
    }
    
    
    dispatch_async(queue, ^{
        [post save];
        dispatch_async(dispatch_get_main_queue(), ^{
            [activityView removeFromSuperview];
            [MentillectAppDelegate.navController popToRootViewControllerAnimated:YES];
        });
    });
    
}



@end
