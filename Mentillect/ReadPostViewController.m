//
//  ReadPostViewController.m
//  Mentillect
//
//  Created by Nathan Spaun on 5/24/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import "ReadPostViewController.h"
#import "Comment.h"
#import "ActivityCell.h"
#import "Mentillect.h"
@interface ReadPostViewController ()

@end

@implementation ReadPostViewController

-(id)initWithPost:(Post *)p
{
    self = [super initWithNibName:@"ReadPostViewController" bundle:nil];
    if (self) {
        _post = p;
    }
    return self;
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
    
    [nameLabel setText:_post.poster.name];
    [titleLabel setText:_post.title];
    
    if (_post.url && _post.url.length>0) {
        NSURL *url = [NSURL URLWithString:_post.url];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [webView loadRequest:request];
    } else {


        
        //
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSURL *baseURL = [NSURL fileURLWithPath:path];
        NSString *pngFilePath = [NSString stringWithFormat:@"%@/%@.png",path,_post.title];
        
                NSLog(pngFilePath);
        //
        [[NSFileManager defaultManager] removeItemAtPath:pngFilePath error:NULL];
        NSData *data1 = [NSData dataWithData:UIImagePNGRepresentation(_post.picture)];
        [data1 writeToFile:pngFilePath atomically:YES];
        NSString *htmlStr = [NSString stringWithFormat:@"<img src=\"%@.png\"><br><p>%@</p>",_post.title, _post.text];
        [webView loadHTMLString:htmlStr baseURL:baseURL];
        
        
    }
    
    _comments = [Comment commentsForPost:_post];

    
    [commentTable setDataSource:self];
    [commentTable reloadData];
    
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)newComment:(id)sender {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Comment" message:[NSString stringWithFormat:@"%@\n\n\n",_post.title] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    textField = [[UITextField alloc] init];
    [textField setBackgroundColor:[UIColor whiteColor]];
    textField.delegate = self;
    textField.borderStyle = UITextBorderStyleLine;
    textField.frame = CGRectMake(15, 75, 255, 30);
    textField.font = [UIFont fontWithName:@"ArialMT" size:20];
    textField.placeholder = @"Comment";
    textField.textAlignment = UITextAlignmentCenter;
    textField.keyboardAppearance = UIKeyboardAppearanceAlert;
    [textField becomeFirstResponder];
    [alert addSubview:textField];
    [alert show];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _comments.count;
}

#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Comment *comment = [_comments objectAtIndex:indexPath.row];
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cCell"];
    if (!cell) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ActivityCell" owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[ActivityCell class]])
            {
                cell = (ActivityCell *)currentObject;
                break;
            }
        }
    }
    
    [cell.imageView setImage:comment.fromUser.picture];
    [cell.userName setText:comment.fromUser.name];
    [cell.commentText setText:comment.text];
    [cell.activityInfo setText:@""];
    
    return cell;
}

-(void)viewDidDisappear:(BOOL)animated
{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *pngFilePath = [NSString stringWithFormat:@"%@/%@.png",path,_post.title];
    
    NSLog(pngFilePath);
    //
    [[NSFileManager defaultManager] removeItemAtPath:pngFilePath error:NULL];
}

#pragma mark alertView

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString* detailString = textField.text;
    NSLog(@"String is: %@", detailString); //Put it on the debugger
    if ([textField.text length] <= 0 || buttonIndex == 0){
        return; //If cancel or 0 length string the string doesn't matter
    }
    if (buttonIndex == 1) {
        Comment *comment = [Comment createCommentWithText:textField.text fromUser:[MtUser getCurrentUser] toUser:nil forPost:_post];
        [comment save];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
