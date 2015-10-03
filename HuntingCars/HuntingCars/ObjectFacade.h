//
//  ObjectFacade.h
//  HuntingCars
//
//  Created by Lorenz Hänggi on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomerProfile.h"
#import "VehicleApi.h"

@interface ObjectFacade : NSObject
@property (nonatomic, strong) VehicleApi *api;

-(id) initWithApi: (VehicleApi*) api;
-(NSArray*) findMatchingCarsByProfile: (CustomerProfile*) profile;
-(void) saveSearchResults: (NSArray*) searchResults;
-(NSArray*) restoreSearchResults;
@end
