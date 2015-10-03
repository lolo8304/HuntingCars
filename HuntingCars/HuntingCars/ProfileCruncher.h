//
//  ProfileCruncher.h
//  HuntingCars
//
//  Created by Cédric Wider on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#ifndef ProfileCruncher_h
#define ProfileCruncher_h
#include "CustomerProfile.h"

@interface ProfileCruncher : NSObject
@property (strong, nonatomic) CustomerProfile *profile;

-(id) initWithCustomerProfile: (CustomerProfile*) profile;
-(NSDictionary*) calculateSearchCriteria;
@end

#endif /* ProfileCruncher_h */
