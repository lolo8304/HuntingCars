//
//  ScoreFilter.h
//  HuntingCars
//
//  Created by Lorenz Hänggi on 08/12/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VehicleDAO;

@interface ScoreFilter : NSObject
@property (nonatomic) NSRange sportScore;
@property (nonatomic) NSRange familyScore;
@property (nonatomic) NSRange ecoScore;
@property (nonatomic) NSRange priceScore;
@property (nonatomic) NSRange offroadScore;
@property (nonatomic) NSRange designScore;


- (id)initWithScores: (NSDictionary*) scores;
- (float)calculateTotalScore: (VehicleDAO*) vehicle;

@end
