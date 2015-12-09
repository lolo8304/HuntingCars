//
//  VehicleApi.m
//  HuntingCars
//
//  Created by Cédric Wider on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VehicleApi.h"
#import "ScoreFilter.h"
#import "VehicleDAO.h"

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
    NSMutableArray* results = [NSMutableArray array];
    NSMutableDictionary* resultsDict = [NSMutableDictionary dictionary];
    for (NSString* key in scores)
    {
        NSValue *value = [scores objectForKey:key];
        //values <= 0 don't have to be searched, because there are no negative scores.
        if ([value rangeValue].location > 0)
        {
            NSLog([NSString stringWithFormat:@"Searching with %@ and %@", key, value]);
            NSString *queryString = [self ratingOverviewQueryWithKey: key andValue: [scores objectForKey: key]];
            NSArray* resultForScore = [super queryServer: queryString];
            NSLog([NSString stringWithFormat:@"Found %lu results", (unsigned long)[resultForScore count]]);
            
            for (NSDictionary* vehicleDictionary in resultForScore) {
                VehicleDAO *vehicle = [[VehicleDAO alloc] initWithDictionary: vehicleDictionary];
                VehicleDAO *existingVehicle = [resultsDict valueForKey: [vehicle vin]];
                if (existingVehicle) {
                    existingVehicle.countResult++;
                } else {
                    [resultsDict setValue: vehicle forKey: [vehicle vin]];
                    [results addObject: vehicle];
                }
            }
        }
    }
    ScoreFilter *filter = [[ScoreFilter alloc] initWithScores: scores];
    return [self sortCars: results byFilter: filter];
}

- (NSArray*) sortCars: (NSMutableArray*) results byFilter: (ScoreFilter*) filter {
    NSMutableArray * vehicles = [[NSMutableArray alloc] initWithCapacity: [results count]];
    for (VehicleDAO *vehicle in results) {
        [vehicle updateTotalScore: filter];
        [vehicles addObject: vehicle];
    }
    /* sort by highest value */
    NSArray *sortedArray = [vehicles sortedArrayUsingComparator: ^(VehicleDAO* obj1,VehicleDAO* obj2) {
        float f1 = [obj1 countResult] + [obj1 totalScore];
        float f2 = [obj2 countResult] + [obj2 totalScore];
        
        if (f1 > f2) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        
        if (f1 < f2) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    return sortedArray;
}



- (NSArray*) fetchFastCars
{
    return [super queryServer:[NSString stringWithFormat:@"/score/sport/5/overview.json"]];
}

- (NSDictionary*) fetchDetailsByVin: (NSString*) vid
{
    NSString *queryUrl = [NSString stringWithFormat:@"/vehicle/%@.json", vid];
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super queryForSingleObject: queryUrl]];
    [result setObject:[self translateImages: [result objectForKey: @"vehicleImages"]] forKey:@"vehicleImagesURL"];
    NSDictionary *dealer = [self dealerDetailsById: [result valueForKey: @"dealer"]];
    [result setValue: dealer forKey: @"dealerDetails"];
    return result;
}

-(NSArray*) translateImages: (NSArray*) imageDictArray
{
    NSMutableArray *imageUrls = [NSMutableArray array];
    if (imageDictArray != nil && [imageDictArray count] > 0) {
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

- (NSString*) ratingOverviewQueryWithKey: (NSString*) key andValue: (NSValue*) value
{
    NSRange range = [value rangeValue];
    return [NSString stringWithFormat: @"/score/%@/%lu/%lu/overview.json", key, (unsigned long)range.location, (unsigned long)NSMaxRange(range)];
}

- (NSDictionary*) dealerDetailsById: (NSString*) id
{
    NSString *queryUrl = [NSString stringWithFormat:@"/dealer/%@.json", id];
    return [NSMutableDictionary dictionaryWithDictionary:[super queryForSingleObject: queryUrl]];
}

@end
