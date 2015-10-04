//
//  ApplicationState.h
//  HuntingCars
//
//  Created by Lorenz Hänggi on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomerProfile.h"
#import "ObjectFacade.h"
#import "VehicleDAO.h"

@interface ApplicationState : NSObject

+ (ApplicationState*) instance;//singleton
- (id) init;

@property (strong, nonatomic) CustomerProfile* customerProfile;
@property (strong, nonatomic) ObjectFacade* objectFacade;

@property (strong, nonatomic) NSArray *foundCars; // search results are 'persisted' here.
@property (strong, nonatomic) NSMutableArray *chosenCars; // liked vehicles


@property (nonatomic) int foundCarsIndex;
@property (nonatomic) int chosenCarsIndex;

- (int) searchWithCustomerProfile;
- (void) likeVehicle: (VehicleDAO*) vehicle;
- (void) dislikeVehicle: (VehicleDAO*) vehicle;
- (void) removeChooseVehicle: (VehicleDAO*) vehicle;

- (VehicleDAO*) loadVehicleDetails: (VehicleDAO*) vehicle;


- (VehicleDAO*)getCurrentFoundCar;
- (VehicleDAO*)getCurrentChoosenCar;
- (bool)hasCurrentFoundCar;
- (bool)hasCurrentChoosenCar;

- (void) likeCurrentVehicle;
- (void) dislikeCurrentVehicle;
- (void) removeCurrentChooseVehicle;


@end
