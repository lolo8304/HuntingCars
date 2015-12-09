//
//  ObjectFacade.m
//  HuntingCars
//
//  Created by Lorenz Hänggi on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#import "ObjectFacade.h"
#import "ProfileCruncher.h"
#import "ApplicationState.h"
#import "VehicleDAO.h"


@implementation ObjectFacade

-(id) initWithApi:(VehicleApi *)api
{
    self = [super init];
    if(self)
    {
        self.api = api;
    }
    return self;
}

- (NSDictionary*) calculateSearchCriteria {
    return [[[ProfileCruncher alloc] initWithCustomerProfile: [[ApplicationState instance] customerProfile]] calculateSearchCriteria];
}

-(NSArray*) findMatchingCarsByProfile: (CustomerProfile*) profile
{
    ProfileCruncher *cruncher = [[ProfileCruncher alloc] initWithCustomerProfile: profile];
    NSDictionary *searchCriteria = [cruncher calculateSearchCriteria];
    NSArray *searchResults = [self.api fetchCarsByScores: searchCriteria];
    return searchResults;
}

-(VehicleDAO*) findVehicleByVin: (NSString*) vin
{
    return [[VehicleDAO alloc] initWithDictionary:[self.api fetchDetailsByVin:vin]];
}

-(void) saveSearchResults: (NSArray*) searchResults
{
    [[ApplicationState instance] setFoundCars: [NSArray arrayWithArray: searchResults]];
}

-(NSArray*) restoreSearchResults
{
    NSArray *results = nil;
    if ([[ApplicationState instance] foundCars] != nil)
    {
        results = [NSArray arrayWithArray: [[ApplicationState instance] foundCars]];
    }
    return results;
}


@end
