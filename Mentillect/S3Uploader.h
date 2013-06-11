//
//  S3Uploader.h
//  Mentillect
//
//  Created by Nathan Spaun on 5/29/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface S3Uploader : NSObject

+(void)uploadToS3:(UIImage*)image withKey:(NSString*)key;
+(NSData *)downloadFromKey:(NSString*)key;

@end
