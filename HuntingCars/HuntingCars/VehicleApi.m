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
        NSValue *value = [scores objectForKey:key];
        NSLog([NSString stringWithFormat:@"Searching with %@ and %@", key, value]);
        if ([value rangeValue].location > 0) //values <= 0 don't have to be searched, because there are no negative scores.
        {
            NSString *queryString = [self ratingQueryWithKey: key andValue: [scores objectForKey: key]];
            NSArray* resultForScore = [super queryServer: queryString];
            NSLog([NSString stringWithFormat:@"Found %lu results", (unsigned long)[resultForScore count]]);
            if (results == nil)
            {
                results = [NSMutableSet set];
            }
            [results addObjectsFromArray:resultForScore];
        }
    }
    return [results allObjects];
}

- (NSArray*) fetchFastCars
{
    return [super queryServer:[NSString stringWithFormat:@"/score/sport/5.json"]];
}

- (NSDictionary*) fetchDetailsByVin: (NSString*) vid
{
    NSString *queryUrl = [NSString stringWithFormat:@"/vehicle/%@.json", vid];
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super queryForSingleObject: queryUrl]];
    [result setObject:[self translateImages: [result objectForKey: @"vehicleImages"]] forKey:@"vehicleImages"];
    return result;
}

-(NSArray*) translateImages: (NSArray*) imageDictArray
{
    NSMutableArray *imageUrls = nil;
    if (imageDictArray != nil && [imageDictArray count] > 0) {
        imageUrls = [NSMutableArray array];
        for (NSDictionary *dict in imageDictArray) {
            [imageUrls addObject:[NSString stringWithFormat:@"%@/image/%@/thumbnail", [super baseUrl], [dict objectForKey: @"id"]]];
        }
    }
    return imageUrls;
}

- (NSString*) ratingQueryWithKey: (NSString*) key andValue: (NSValue*) value
{
    NSRange range = [value rangeValue];
    return [NSString stringWithFormat: @"/score/%@/%lu/%lu.json", key, (unsigned long)range.location, (unsigned long)NSMaxRange(range)];
}


@end
