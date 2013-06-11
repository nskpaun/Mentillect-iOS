//
//  ApiHelper.m
//  Mentillect
//
//  Created by Nathan Spaun on 5/29/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import "ApiHelper.h"

@implementation ApiHelper

NSString const *HTTP_PRE  =                         @"http://";
NSString const *HOST_API  =                         @"ec2-50-18-120-111.us-west-1.compute.amazonaws.com:8081";//@"localhost:8000";//
NSString const *USERNAME = 								@"u";
NSString const *PASSWORD = 								@"p";


- (ApiHelper*) init {
    return self;
}

-(void) postToUrl:(NSString *)url withParams:(NSString*) params
     withCallback: (void (^)(NSDictionary *))callback withPage:(int)p {
        NSLog(@"Api Loading");
    _params = params;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *post1 = @"";
    
    NSString *keyString = USERNAME;
    post1 = [NSString stringWithFormat:@"%@%@=%@&", post1, keyString,[defaults stringForKey:keyString] ] ;
    
    keyString = PASSWORD;
    post1 = [NSString stringWithFormat:@"%@%@=%@&", post1, keyString,[defaults stringForKey:keyString] ] ;
    
    NSString *post;
    
    if (params) {
        post = [NSString stringWithFormat:@"%@&%@",params,post1];
    } else {
        post = post1;
    }
    
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSLog(post);
    NSString *urlstring = [NSString stringWithFormat:@"%@%@%@",HTTP_PRE,HOST_API,url];
    NSLog(urlstring);
    NSMutableURLRequest* request = [NSMutableURLRequest
                                    requestWithURL: [NSURL URLWithString: urlstring]];
    [request setHTTPMethod:@"POST"];
    NSError *error;
    // should check for and handle errors here
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    //[request setHTTPBody:body];
    NSURLConnection *conn = [[NSURLConnection alloc]
                             initWithRequest: request delegate:self];
    
    callbackBlock = callback;
}

-(void)apiPost:(NSString*)url
{
    
}

#pragma NSUrlConnectionDelegate Methods

-(void)connection:(NSConnection*)conn didReceiveResponse:
(NSURLResponse *)response
{
    if (_receivedData == NULL) {
        _receivedData = [[NSMutableData alloc] init];
    }
    [_receivedData setLength:0];
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    }
    else
    {
        [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:
(NSData *)data
{
    // Append the new data to receivedData.
    [_receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:
(NSError *)error
{
    //Naive error handling - log it!
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:
           NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
        NSLog(@"Api finish Loading");
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:_receivedData options:kNilOptions error:&error];
    
    callbackBlock(json);
}

+ (NSObject *) getDataFrom:(NSString *)url {
        NSLog(@"Api Loading");
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    NSString *urlstring = [NSString stringWithFormat:@"%@%@%@",HTTP_PRE,HOST_API,url];
    [request setURL:[NSURL URLWithString:urlstring]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %i", url, [responseCode statusCode]);
        return nil;
    }

    return [NSJSONSerialization JSONObjectWithData:oResponseData options:kNilOptions error:&error];
}

+ (NSObject *) postDataFrom:(NSString *)url withParams:(NSString *)params withAuth:(BOOL)auth{
        NSLog(@"Api Loading");
    NSString *post1 = @"";
    NSString *post;
    if (auth) {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    
    NSString *keyString = USERNAME;
    post1 = [NSString stringWithFormat:@"%@%@=%@&", post1, keyString,[defaults stringForKey:keyString] ] ;
        
    keyString = PASSWORD;
    post1 = [NSString stringWithFormat:@"%@%@=%@&", post1, keyString,[defaults stringForKey:keyString] ] ;
    

    
    if (params) {
        post = [NSString stringWithFormat:@"%@&%@",params,post1];
    } else {
        post = post1;
    }
    } else {
        post1 = params;
        post = params;
    }
    
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSString *urlstring = [NSString stringWithFormat:@"%@%@%@",HTTP_PRE,HOST_API,url];
    NSMutableURLRequest* request = [NSMutableURLRequest
                                    requestWithURL: [NSURL URLWithString: urlstring]];
    [request setHTTPMethod:@"POST"];
    NSError *error;
    // should check for and handle errors here
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    //[request setHTTPBody:body];
    NSHTTPURLResponse *responseCode = nil;
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    if (oResponseData)    return [NSJSONSerialization JSONObjectWithData:oResponseData options:kNilOptions error:&error];
    
    return nil;
}

+ (NSString *) dictToString:(NSDictionary*) dict
{
    NSLog(@"Api Loading");
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:0 // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    NSString *params = @"";
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(jsonString);
        params =[NSString stringWithFormat:@"%@", jsonString];
    }
    return params;
}

+ (NSObject *) putDataFrom:(NSString *)url withParams:(NSString *)params withAuth:(BOOL)auth{
        NSLog(@"Api Loading");
    NSString *post1 = @"";
    NSString *post;
    if (auth) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        
        NSString *keyString = USERNAME;
        post1 = [NSString stringWithFormat:@"%@%@=%@&", post1, keyString,[defaults stringForKey:keyString] ] ;
        
        keyString = PASSWORD;
        post1 = [NSString stringWithFormat:@"%@%@=%@&", post1, keyString,[defaults stringForKey:keyString] ] ;
        
        
        
        if (params) {
            post = [NSString stringWithFormat:@"%@&%@",params,post1];
        } else {
            post = post1;
        }
    } else {
        post1 = params;
        post = params;
    }
    
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSString *urlstring = [NSString stringWithFormat:@"%@%@%@",HTTP_PRE,HOST_API,url];
    NSMutableURLRequest* request = [NSMutableURLRequest
                                    requestWithURL: [NSURL URLWithString: urlstring]];
    [request setHTTPMethod:@"PUT"];
    NSError *error;
    // should check for and handle errors here
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    //[request setHTTPBody:body];
    NSHTTPURLResponse *responseCode = nil;
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    return [NSJSONSerialization JSONObjectWithData:oResponseData options:kNilOptions error:&error];
}


@end
