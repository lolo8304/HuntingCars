//
//  ApplicationState.m
//  HuntingCars
//
//  Created by Lorenz Hänggi on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#import "ApplicationState.h"
#import "CustomerProfile.h"
#import "ObjectFacade.h"
#import "VehicleApi.h"
#import "Const.h"

@implementation ApplicationState


+ (ApplicationState*)instance {
    static ApplicationState *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id) init {
    self.customerProfile = [[CustomerProfile alloc] init];
    VehicleApi* vehicleAPI = [[VehicleApi alloc] initWithBaseUrl: REST_API_BASE_URL];
    self.objectFacade = [[ObjectFacade alloc] initWithApi: vehicleAPI];
    self.chosenCars = [[NSMutableArray alloc] init];
    self.foundCars = [[NSArray alloc] init];
    return self;
}

- (int) searchWithCustomerProfile {
    self.foundCars = [self.objectFacade findMatchingCarsByProfile: self.customerProfile];
    self.foundCarsIndex = 0;
    self.chosenCarsIndex = 0;
    return (int)self.foundCars.count;
}
- (void) likeCurrentVehicle {
    VehicleDAO* vehicle = self.getCurrentFoundCar;
    [self likeVehicle: vehicle];
}
- (void) dislikeCurrentVehicle {
    VehicleDAO* vehicle = self.getCurrentFoundCar;
    [self dislikeVehicle: vehicle];
}

- (void) likeVehicle: (VehicleDAO*) vehicle {
    [self.chosenCars addObject: vehicle];
    self.foundCarsIndex++;
    self.chosenCarsIndex = 0;
}
- (void) dislikeVehicle: (VehicleDAO*) vehicle {
    self.foundCarsIndex++;
    self.chosenCarsIndex = 0;
}

- (void) removeCurrentChooseVehicle {
    VehicleDAO* vehicle = self.getCurrentChoosenCar;
    [self removeChooseVehicle: vehicle];
}

- (void) removeChooseVehicle: (VehicleDAO*) vehicle {
    [self.chosenCars removeObject: vehicle];
}

- (VehicleDAO*) loadVehicleDetails: (VehicleDAO*) vehicle {
    VehicleDAO* newVehicle = [[self objectFacade] findVehicleByVin: [vehicle vin]];
    [vehicle updateDictionary: [newVehicle dictionay]];
     return vehicle;
}

- (VehicleDAO*)getCurrentFoundCar {
    if (self.foundCarsIndex < self.foundCars.count) {
        return self.foundCars[self.foundCarsIndex];
    }
    return nil;
}
- (VehicleDAO*)getCurrentChoosenCar {
    if (self.chosenCarsIndex< self.chosenCars.count) {
        return self.chosenCars[self.chosenCarsIndex];
    }
    return nil;
}

- (bool)hasCurrentFoundCar {
    return self.getCurrentFoundCar != nil;
}
- (bool)hasCurrentChoosenCar {
    return self.getCurrentChoosenCar != nil;
}

@end
