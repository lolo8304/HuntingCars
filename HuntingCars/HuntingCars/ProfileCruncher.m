//
//  ProfileCruncher.m
//  HuntingCars
//
//  Created by Cédric Wider on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfileCruncher.h"

@implementation ProfileCruncher

-(id) initWithCustomerProfile: (CustomerProfile*) profile
{
    self = [super init];
    if (self) {
        self.profile = profile;
    }
    return self;
}

-(NSDictionary*) calculateSearchCriteria
{
    NSDictionary *searchCriteria = [self initialValues];
    
    searchCriteria = [self updateByGender: searchCriteria];
    
    return searchCriteria;
}

-(NSDictionary*) updateByGender: (NSDictionary*) original
{
    __block NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:original];
    if ([@"male" isEqualToString:[self.profile gender]]) {
        [dict setObject:[self increaseValueOf:dict withKey:@"sport"] forKey:@"sport"];
        [dict setObject:[self increaseValueOf:dict withKey:@"offroad"] forKey:@"offroad"];
    } else {
        [dict setObject:[self increaseValueOf:dict withKey:@"family"] forKey:@"family"];
        [dict setObject:[self decreaseValueOf: dict withKey: @"design"] forKey:@"design"];
    }
    return dict;
}

-(NSValue*) increaseValueOf: (NSDictionary*) original withKey: (NSString*) key
{
    return [self increaseRange:[original objectForKey:key]];
}

-(NSValue*) decreaseValueOf: (NSDictionary*) original withKey: (NSString*) key
{
    return [self decreaseRange:[original objectForKey:key]];
}



-(NSValue*) increaseRange: (NSValue*) existing
{
    NSRange existingRange = [existing rangeValue];
    return [NSValue valueWithRange: NSMakeRange(existingRange.location + 1, existingRange.length)];
}

-(NSValue*) decreaseRange: (NSValue*) existing
{
    NSRange existingRange = [existing rangeValue];
    return [NSValue valueWithRange: NSMakeRange(existingRange.location - 1, existingRange.length)];
}

-(NSMutableDictionary*) initialValues
{
    return [NSMutableDictionary dictionaryWithObjects: @[[NSValue valueWithRange:NSMakeRange(0, 1)], [NSValue valueWithRange:NSMakeRange(0, 1)], [NSValue valueWithRange:NSMakeRange(0, 1)], [NSValue valueWithRange:NSMakeRange(0, 1)], [NSValue valueWithRange:NSMakeRange(0, 1)]]
                                                     forKeys: @[@"family", @"sport", @"eco", @"design", @"offroad"]];
}

@end