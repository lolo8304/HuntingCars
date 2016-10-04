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

- (float)factor: (int) score inRange: (NSRange) range emptyValue: (int) emptyValue {
    if (range.location == 0) {
        return emptyValue;
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

- (float)factor2: (NSString*) scoreString score: (int) score inRange: (NSRange) range emptyValue: (float) emptyValue {
    float f = [self factor: score inRange: range emptyValue: emptyValue];
    //NSLog(@"%@ = %f, from %i ", scoreString, f, score);
    return f;
}

- (float)calculateTotalScore: (VehicleDAO*) vehicle {
    //return [self calculateAvgTotalScore: vehicle];
    return [self calculateAvgNotCountingEmptyTotalScore: vehicle];
}


- (float)calculateAvgTotalScore: (VehicleDAO*) vehicle {
    return
    ([self factor2: @"sport" score: [vehicle sportScore] inRange: self.sportScore emptyValue: 1.0] +
     [self factor2: @"family" score: [vehicle familyScore] inRange: self.familyScore emptyValue: 1.0] +
     [self factor2: @"eco" score: [vehicle ecoScore] inRange: self.ecoScore emptyValue: 1.0] +
     [self factor2: @"price" score: [vehicle priceScore] inRange: self.priceScore emptyValue: 1.0] +
     [self factor2: @"offroad" score: [vehicle offroadScore] inRange: self.offroadScore emptyValue: 1.0] +
     [self factor2: @"design" score: [vehicle designScore] inRange: self.designScore emptyValue: 1.0]) / 6;
}

- (float)calculateAvgNotCountingEmptyTotalScore: (VehicleDAO*) vehicle {
    float totalScore = 0.0f;
    int count = 0;
    
    float f = [self factor2: @"sport" score: [vehicle sportScore] inRange: self.sportScore emptyValue: 0.0f];
    if (f > 0.0f) { totalScore = totalScore + f; count++; }
    f = [self factor2: @"family" score: [vehicle familyScore] inRange: self.familyScore emptyValue: 0.0f];
    if (f > 0.0f) { totalScore = totalScore + f; count++; }
    f = [self factor2: @"eco" score: [vehicle ecoScore] inRange: self.ecoScore emptyValue: 0.0f];
    if (f > 0.0f) { totalScore = totalScore + f; count++; }
    f = [self factor2: @"price" score: [vehicle priceScore] inRange: self.priceScore emptyValue: 0.0f];
    if (f > 0.0f) { totalScore = totalScore + f; count++; }
    f = [self factor2: @"offroad" score: [vehicle offroadScore] inRange: self.offroadScore emptyValue: 0.0f];
    if (f > 0.0f) { totalScore = totalScore + f; count++; }
    f = [self factor2: @"design" score: [vehicle designScore] inRange: self.designScore emptyValue: 0.0f];
    if (f > 0.0f) { totalScore = totalScore + f; count++; }
    if (count > 0) {
        return totalScore / count;
    } else {
        return 0.0f;
    }
}


 - (float)calculateProductTotalScore: (VehicleDAO*) vehicle {
 return
 [self factor2: @"sport" score: [vehicle sportScore] inRange: self.sportScore emptyValue: 1.0] *
 [self factor2: @"family" score: [vehicle familyScore] inRange: self.familyScore emptyValue: 1.0] *
 [self factor2: @"eco" score: [vehicle ecoScore] inRange: self.ecoScore emptyValue: 1.0] *
 [self factor2: @"price" score: [vehicle priceScore] inRange: self.priceScore emptyValue: 1.0] *
 [self factor2: @"offroad" score: [vehicle offroadScore] inRange: self.offroadScore emptyValue: 1.0] *
 [self factor2: @"design" score: [vehicle designScore] inRange: self.designScore emptyValue: 1.0];
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
