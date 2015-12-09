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
#include "ScoreFilter.h"
#include "DealerDAO.h"
#import <UIKit/UIKit.h>


@interface VehicleDAO : DAO
@property (nonatomic) float totalScore;
@property (nonatomic) int countResult;

- (NSString*) vehicleMainHeading1;
- (NSString*) vehicleMainHeading2;
- (NSString*) vin;
- (NSString*) milage;
- (NSString*) price;
- (NSString*) emissions;
- (NSString*) tcoPerMonth;
- (NSString*) totalScoreString;

- (NSArray*) images;
- (NSURL*) image: (int) index;
- (NSURL*) image0;
- (UIImage*) uiImage: (int) index;
- (UIImage*) uiImage0;

- (DealerDAO*) dealer;

- (int) sportScore;
- (int) familyScore;
- (int) ecoScore;
- (int) priceScore;
- (int) offroadScore ;
- (int) designScore;

- (float)updateTotalScore: (ScoreFilter*) filter;

@end

#endif /* VehicleDAO_h */
