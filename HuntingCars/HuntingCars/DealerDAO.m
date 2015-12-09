//
//  DealerDAO.m
//  HuntingCars
//
//  Created by Lorenz Hänggi on 09/12/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#include "DealerDAO.h"

@implementation DealerDAO

-(id) initWithDictionary:(NSDictionary *)dict {
    return [super initWithDictionary: dict];
}

- (NSString*) name {
    return [self s: @"name"];
}
- (NSString*) address1 {
    return [self s: @"address" ];
}
- (NSString*) address2 {
    return  [self s1: @"zip" and: @" " s2: @"city"];
}
- (NSString*) contacts {
    return  [self s1: @"email" and: @", " s2: @"phone"];
}
- (double) longitude {
    return [self double: @"longitude"];
}
- (double) latitude {
    return [self double: @"latitude"];
}

@end
