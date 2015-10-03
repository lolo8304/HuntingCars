
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
    self.horsePower = 1;
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

/* 18-25, 26-35, 36-45, 46-99 */
/* default = 0-0 */
- (int) getAgeIndex {
    switch ([self age].location) {
        case 0:
            return -1;
            break;
        case 18:
            return 0;
            break;
        case 26:
            return 1;
            break;
        case 36:
            return 2;
            break;
        case 46:
            return 3;
            break;
        default:
            break;
    }
    return -1;
}

/* 18-25, 26-35, 36-45, 46-99 */
/* default = 0-0 */
- (void) setAgeIndex: (int) index {
    switch (index) {
        case -1:
            self.age = NSMakeRange(0, 0);
            break;
        case 0:
            self.age = NSMakeRange(18,25);
            break;
        case 1:
            self.age = NSMakeRange(26,35);
            break;
        case 2:
            self.age = NSMakeRange(36,45);
            break;
        case 3:
            self.age = NSMakeRange(46,99);
            break;
            
        default:
            break;
    }
}

@end
