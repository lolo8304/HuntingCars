//
//  VehicleDAO.m
//  HuntingCars
//
//  Created by Cédric Wider on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAO.h"
#import "VehicleDAO.h"

@implementation VehicleDAO : DAO

-(id) initWithDictionary:(NSDictionary *)dict {
    return [super initWithDictionary: dict];
}

- (NSString*) vehicleMainHeading1 {
    return [self s1:[self s: @"brand"] and: @"-" s2: [self s: @"modelGerman"]];
}
- (NSString*) vehicleMainHeading2 {
    return [self s1:[self s: @"firstRegistration"] and: @"-" s2: [self i: @"mileage"]];
}

- (NSString*) vin {
    return [self s: @"vin"];
}

- (NSArray*) images {
    return [self a: @"vehicleImages"];
}

- (NSURL*) image: (int) index {
    NSArray* array = [self images];
    if (index < [array count]) {
        return [NSURL URLWithString: [self images][index]];
    } else {
        return nil;
    }
}

- (NSURL*) image0 {
    return [self image: 0];
}




@end