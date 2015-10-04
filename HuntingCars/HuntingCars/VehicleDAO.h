//
//  VehicleDAO.h
//  HuntingCars
//
//  Created by Cédric Wider on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#ifndef VehicleDAO_h
#define VehicleDAO_h
#include "DAO.h"

@interface VehicleDAO : DAO


- (NSString*) vehicleMainHeading1;
- (NSString*) vehicleMainHeading2;
- (NSString*) vin;
- (NSArray*) images;
- (NSURL*) image: (int) index;
- (NSURL*) image0;

@end

#endif /* VehicleDAO_h */
