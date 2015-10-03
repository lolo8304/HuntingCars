//
//  RestApi.m
//  HuntingCars
//
//  Created by Cédric Wider on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestApi : NSObject
@property (strong, nonatomic) NSString *baseUrl;
@end

@implementation RestApi

-(id) initWithBaseUrl: (NSString*) baseUrl
{
    self = [super init];
    if (self) {
        self.baseUrl = baseUrl;
    }
    return self;
}

- (NSDictionary*) fetchAllCars
{
    return [self queryServer:@"vehicles.json"];
}

- (NSDictionary*) fetchFastCars
{
    return [self queryServer:[NSString stringWithFormat:@"/score/sport/5.json"]];
}

- (NSDictionary*) queryServer: (NSString*) query
{
    __block NSDictionary *vehicles = nil;
    
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@", self.baseUrl,query];
    NSURL *url = [NSURL URLWithString: requestUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error: &error];
    
    if (error == nil) {
        vehicles = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    }
    
    return vehicles;

}

@end