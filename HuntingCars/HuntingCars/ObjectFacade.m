//
//  ObjectFacade.m
//  HuntingCars
//
//  Created by Lorenz Hänggi on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#import "ObjectFacade.h"
#import "ProfileCruncher.h"
#import "ApplicationState.h"

@implementation ObjectFacade

- (NSDictionary*) calculateSearchCriteria {
    return [[[ProfileCruncher alloc] initWithCustomerProfile: [[ApplicationState instance] customerProfile]] calculateSearchCriteria];
}

@end
