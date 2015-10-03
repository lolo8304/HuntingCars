//
//  CustomerProfile.h
//  HuntingCars
//
//  Created by Lorenz Hänggi on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerProfile : NSObject
@property (strong, nonatomic) NSString* gender;
@property (strong, nonatomic) NSString* familyStatus;
@property NSRange age;
@property NSInteger* horsePower;
@property integer_t design;
@property NSInteger* priceToBuy;
@end
