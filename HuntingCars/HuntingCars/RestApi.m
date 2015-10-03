//
//  RestApi.m
//  HuntingCars
//
//  Created by Cédric Wider on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestApi.h"

@implementation RestApi

-(id) initWithBaseUrl: (NSString*) baseUrl
{
    self = [super init];
    if (self) {
        self.baseUrl = baseUrl;
    }
    return self;
}

- (NSArray*) queryServer: (NSString*) query
{
    NSArray *vehicles = nil;
    NSDictionary *responseBody = [self queryForSingleObject:query];
    if (responseBody != nil) {
        vehicles = [responseBody objectForKey:@"vehicles"];
    }
    return vehicles;
}

-(NSDictionary*) queryForSingleObject: (NSString*) query
{
    NSDictionary *responseBody = nil;
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@", self.baseUrl,query];
    NSURL *url = [NSURL URLWithString: requestUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error: &error];
    
    if (error == nil) {
        responseBody = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    }
    
    return responseBody;
}

@end