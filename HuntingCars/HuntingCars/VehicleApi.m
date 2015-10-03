//
//  VehicleApi.m
//  HuntingCars
//
//  Created by Cédric Wider on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VehicleApi.h"

@implementation VehicleApi : RestApi

- (id) initWithBaseUrl: (NSString*) baseUrl {
    return [super initWithBaseUrl: baseUrl];
}

- (NSArray*) fetchAllCars
{
    return [super queryServer:@"vehicles.json"];
}

- (NSArray*) fetchCarsByScores: (NSDictionary*) scores
{
    NSMutableSet* results = nil;
    
    for (NSString* key in scores)
    {
        NSString *queryString = [self ratingQueryWithKey: key andValue: [scores objectForKey: key]];
        NSArray* resultForScore = [super queryServer: queryString];
        if (results == nil) {
           
            results = [NSMutableSet set];
        }
        [results addObjectsFromArray:resultForScore];
    }
    return [results allObjects];
}

- (NSArray*) fetchFastCars
{
    return [super queryServer:[NSString stringWithFormat:@"/score/sport/5.json"]];
}

- (NSString*) ratingQueryWithKey: (NSString*) key andValue: (NSValue*) value
{
    NSRange range = [value rangeValue];
    return [NSString stringWithFormat: @"/score/%@/%lu/%lu.json", key, (unsigned long)range.location, (unsigned long)NSMaxRange(range)];
}


@end
