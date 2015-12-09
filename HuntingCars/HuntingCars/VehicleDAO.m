//
//  VehicleDAO.m
//  HuntingCars
//
//  Created by Cédric Wider on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VehicleDAO.h"
#import <UIKit/UIKit.h>


@implementation VehicleDAO : DAO

-(id) initWithDictionary:(NSDictionary *)dict {
    self.totalScore = 1.0f;
    self.countResult = 1;
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
- (NSString*) totalScoreString {
    int totalScoreInt = self.totalScore * 100;
    return [NSString stringWithFormat:@"%i%%", totalScoreInt];
}


- (NSString*) tcoPerMonth {
    return [self s1: @"800" and: @" " s2: @"Fr."];
}


- (DealerDAO*) dealer {
    return [[DealerDAO alloc] initWithDictionary: [self d: @"dealerDetails"]];
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




- (int) sportScore {
    return [self int: @"sportScore"];
}
- (int) familyScore {
    return [self int: @"familyScore"];
}
- (int) ecoScore {
    return [self int: @"ecoScore"];
}
- (int) priceScore {
    return [self int: @"priceScore"];
}
- (int) offroadScore {
    return [self int: @"offroadScore"];
}
- (int) designScore {
    return [self int: @"designScore"];
}

- (float)updateTotalScore: (ScoreFilter*) filter {
    self.totalScore = [filter calculateTotalScore: self];
    
    int f = self.totalScore * 100;
    NSString * totalScoreString = [NSString stringWithFormat:@"%i%%", f];
    //NSLog(@"%@ - total score = %@", [self vehicleMainHeading1], totalScoreString);

    return self.totalScore;
}




@end