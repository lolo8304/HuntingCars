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
#import <UIKit/UIKit.h>

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

- (NSString*) milage {
    return [self s1: [self i: @"mileage"] and: @" " s2: @"km"];
}
- (NSString*) price {
    return [self s1: [self i: @"price"] and: @" " s2: @"Fr."];;
}
- (NSString*) emissions {
    return [self s1: [self i: @"emissions"] and: @" " s2: @"g/km"];
}
- (NSString*) tcoPerMonth {
    return [self s1: @"800" and: @" " s2: @"Fr."];
}



- (NSString*) vin {
    return [self s: @"vin"];
}

- (NSArray*) images {
    return [self a: @"vehicleImagesURL"];
}

- (NSURL*) image: (int) index {
    NSArray* array = [self images];
    if (index < [array count]) {
        return [NSURL URLWithString: array[index]];
    } else {
        return nil;
    }
}
- (UIImage*) uiImage: (int) index {
    NSURL* url = [self image: index];
    if (url) {
        return [self getImageFromURL: url];
    }
    return nil;
}


- (UIImage*)getImageFromURL: (NSURL*) urlString {
    NSData *imageData =[NSData dataWithContentsOfURL: urlString];
    return [UIImage imageWithData: imageData];
}


- (NSURL*) image0 {
    return [self image: 0];
}
- (UIImage*) uiImage0 {
    return [self uiImage: 0];
}




@end