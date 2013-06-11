//
//  S3Uploader.m
//  Mentillect
//
//  Created by Nathan Spaun on 5/29/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import "S3Uploader.h"
#import <AWSRuntime/AWSRuntime.h>
#import <AWSS3/AWSS3.h>

@implementation S3Uploader



+(void)uploadToS3:(UIImage*)image withKey:(NSString*)key
{

    
    NSString *ACCESS_KEY = @"AKIAJ6A3L4FL5CX6PLJQ";
    NSString *SECRET_KEY = @"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";
    NSString *bucket = @"mentillect";
    
    NSData* dataToUpload = UIImagePNGRepresentation(image);
    
    S3PutObjectRequest *request = [[S3PutObjectRequest alloc] initWithKey:key inBucket:bucket];
    [request setData:dataToUpload];
    AmazonS3Client *client = [[AmazonS3Client alloc] initWithAccessKey:ACCESS_KEY withSecretKey:SECRET_KEY];
    [client putObject:request];
    
}

+(NSData *)downloadFromKey:(NSString*)key
{
    
    
    NSString *ACCESS_KEY = @"AKIAJ6A3L4FL5CX6PLJQ";
    NSString *SECRET_KEY = @"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";
    NSString *bucket = @"mentillect";
    
    S3GetObjectRequest *request = [[S3GetObjectRequest alloc] initWithKey:key withBucket:bucket];
    
    AmazonS3Client *client = [[AmazonS3Client alloc] initWithAccessKey:ACCESS_KEY withSecretKey:SECRET_KEY];
    return [client getObject:request].body;
}


@end
