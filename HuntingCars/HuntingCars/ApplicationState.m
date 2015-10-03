//
//  ApplicationState.m
//  HuntingCars
//
//  Created by Lorenz Hänggi on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#import "ApplicationState.h"
#import "CustomerProfile.h"

@implementation ApplicationState


+ (ApplicationState*)instance {
    static ApplicationState *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id) init {
    self.customerProfile = [[CustomerProfile alloc] init];
    return self;
}

@end
