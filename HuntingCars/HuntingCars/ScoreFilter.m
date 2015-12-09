//
//  ScoreFilter.m
//  HuntingCars
//
//  Created by Lorenz Hänggi on 08/12/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#import "ScoreFilter.h"
#import "VehicleDAO.h"

@implementation ScoreFilter

- (id)initWithScores: (NSDictionary*) scores {
    self = [super init];
    if (self) {
        self.sportScore =   [ self getScore: @"sport"   fromDictionary: scores];
        self.familyScore =  [ self getScore: @"family"  fromDictionary: scores];
        self.ecoScore =     [ self getScore: @"eco"     fromDictionary: scores];
        self.priceScore =   [ self getScore: @"price"   fromDictionary: scores];
        self.offroadScore = [ self getScore: @"offroad" fromDictionary: scores];
        self.designScore =  [ self getScore: @"design"  fromDictionary: scores];
    }
    return self;
}

- (NSRange) getScore: (NSString*) key fromDictionary: (NSDictionary*) scores {
    NSValue *value = [scores objectForKey:key];
    if (value && ([value rangeValue].location > 0)) {
        return [value rangeValue];
    } else {
        return NSMakeRange(0, 0);
    }
}

- (float)factor: (int) score inRange: (NSRange) range {
    if (range.location == 0) {
        return 1.0;
    } else {
        if (NSLocationInRange(score, range)) {
            if (range.length == 0) {
                /* if full match and no range */
                return 1.0f;
            } else {
                /* if full match and within range */
                return 0.9f;
            }
        } else {
            /* calculate difference outside of range */
            /* per diff, 0.2 less factor, min = 0.2, max = 0.8 */
            if (score < range.location) {
                return 1.0f - (range.location - score + 1.0f)/5.0f;
            } else {
                return 1.0f - (score - (range.location + range.length) + 1.0f)/5.0f;
            }
        }
    }
}

- (float)factor2: (NSString*) scoreString score: (int) score inRange: (NSRange) range {
    float f = [self factor: score inRange: range];
    //NSLog(@"%@ = %f, from %i ", scoreString, f, score);
    return f;
}

- (float)calculateTotalScore: (VehicleDAO*) vehicle {
    return [self calculateAvgTotalScore: vehicle];
}


 - (float)calculateAvgTotalScore: (VehicleDAO*) vehicle {
 return
 ([self factor2: @"sport" score: [vehicle sportScore] inRange: self.sportScore] +
 [self factor2: @"family" score: [vehicle familyScore] inRange: self.familyScore] +
 [self factor2: @"eco" score: [vehicle ecoScore] inRange: self.ecoScore] +
 [self factor2: @"price" score: [vehicle priceScore] inRange: self.priceScore] +
 [self factor2: @"offroad" score: [vehicle offroadScore] inRange: self.offroadScore] +
 [self factor2: @"design" score: [vehicle designScore] inRange: self.designScore]) / 6;
 }


 - (float)calculateProductTotalScore: (VehicleDAO*) vehicle {
 return
 [self factor2: @"sport" score: [vehicle sportScore] inRange: self.sportScore] *
 [self factor2: @"family" score: [vehicle familyScore] inRange: self.familyScore] *
 [self factor2: @"eco" score: [vehicle ecoScore] inRange: self.ecoScore] *
 [self factor2: @"price" score: [vehicle priceScore] inRange: self.priceScore] *
 [self factor2: @"offroad" score: [vehicle offroadScore] inRange: self.offroadScore] *
 [self factor2: @"design" score: [vehicle designScore] inRange: self.designScore];
 }



/*
 @property (nonatomic) NSRange sportScore;
 @property (nonatomic) NSRange familyScore;
 @property (nonatomic) NSRange ecoScore;
 @property (nonatomic) NSRange priceScore;
 @property (nonatomic) NSRange offroadScore;
 @property (nonatomic) NSRange designScore;
*/


@end
