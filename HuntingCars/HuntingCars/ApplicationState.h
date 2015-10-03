//
//  ApplicationState.h
//  HuntingCars
//
//  Created by Lorenz Hänggi on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomerProfile.h"

@interface ApplicationState : NSObject

+ (ApplicationState*) instance;//singleton
- (id) init;

@property (strong, nonatomic) CustomerProfile* customerProfile;



@end
