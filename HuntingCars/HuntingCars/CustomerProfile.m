
//
//  CustomerProfile.m
//  HuntingCars
//
//  Created by Lorenz Hänggi on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#import "CustomerProfile.h"
@implementation CustomerProfile


- (id) init {
    self.priceToBuy = 1;
    self.horsePower = 3;
    self.gender = nil;
    self.age = NSMakeRange(0, 0);
    self. familyStatus = nil;
    self.design = 0;
    return self;
}

- (void) setFamilyStatusIndex: (int) index {
    self.familyStatus = [NSString stringWithFormat:@"%d", index];
}
- (int) getFamilyStatusIndex {
    return [self.familyStatus intValue];
}

- (void) setGenderIndex: (int) index {
    self.gender = [NSString stringWithFormat:@"%d", index];
}
- (int) getGenderIndex {
    return [self.gender intValue];
}


@end
