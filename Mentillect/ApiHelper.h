//
//  ApiHelper.h
//  Mentillect
//
//  Created by Nathan Spaun on 5/29/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiHelper : NSObject {
@private
    NSMutableData* _receivedData;
    void (^ callbackBlock)(NSDictionary *response);
    NSString *_params;
}

@property (copy, nonatomic) NSMutableData* responseData;

-(void) postToUrl: (NSString*) url withParams: (NSString*) params
     withCallback: (void(^) (NSDictionary* response)) callback withPage:(int)p;
+ (NSObject *) getDataFrom:(NSString *)url;
+ (NSObject *) postDataFrom:(NSString *)url withParams:(NSString *)params withAuth:(BOOL)auth;
+ (NSString *) dictToString:(NSDictionary*) dict;
+ (NSObject *) putDataFrom:(NSString *)url withParams:(NSString *)params withAuth:(BOOL)auth;

-(ApiHelper*) init;

@end
