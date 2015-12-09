//
//  DealerDAO.h
//  HuntingCars
//
//  Created by Lorenz Hänggi on 09/12/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#include "DAO.h"

@interface DealerDAO : DAO


- (NSString*) name;
- (double) longitude;
- (double) latitude;
- (NSString*) address1;
- (NSString*) address2;
- (NSString*) contacts;


@end
