//
//  VehicleApi.h
//  HuntingCars
//
//  Created by Cédric Wider on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#ifndef VehicleApi_h
#define VehicleApi_h
#import "RestApi.h"

@interface VehicleApi : RestApi

- (id) initWithBaseUrl: (NSString*) baseUrl;
- (NSArray*) fetchAllCars;
- (NSArray*) fetchCarsByScores: (NSDictionary*) scores;
- (NSDictionary*) fetchDetailsByVin: (NSString*) vid;

@end

#endif /* VehicleApi_h */
