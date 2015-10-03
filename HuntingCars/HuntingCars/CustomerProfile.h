//
//  CustomerProfile.h
//  HuntingCars
//
//  Created by Lorenz Hänggi on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerProfile : NSObject


/* male, female */
@property (strong, nonatomic) NSString* gender;

/* alone, partner, family */
@property (strong, nonatomic) NSString* familyStatus;


/* 18-25, 26-35, 36-45, 46-99 */
/* default = 0-0 */
@property NSRange age;

/* 1 - 5 */
@property NSInteger horsePower;

/* 1 - 7 */
@property integer_t design;

/* 1-5 */
@property NSInteger priceToBuy;

@property NSInteger priceTCOperMonth;



- (id) init;
- (void) setGenderIndex: (int) index;
- (int) getGenderIndex;

- (void) setFamilyStatusIndex: (int) index;
- (int) getFamilyStatusIndex;


@end
