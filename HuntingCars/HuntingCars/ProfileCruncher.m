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
    searchCriteria = [self updateByAge: searchCriteria];
    searchCriteria = [self updateByFamilyStatus: searchCriteria];
    searchCriteria = [self updateByHorsepower: searchCriteria];
    searchCriteria = [self updateByDesign: searchCriteria];
    searchCriteria = [self updateByPrice: searchCriteria];
    
    return searchCriteria;
}

-(NSDictionary*) updateByGender: (NSDictionary*) original
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:original];
    if ([@"male" isEqualToString:[self.profile gender]]) {
        [dict setObject:[self increaseValueOf:dict withKey:@"sport"] forKey:@"sport"];
    } else {
        [dict setObject:[self increaseValueOf:dict withKey:@"family"] forKey:@"family"];
//        [dict setObject:[self decreaseValueOf: dict withKey: @"design"] forKey:@"design"];
    }
    return dict;
}

-(NSDictionary*) updateByAge: (NSDictionary*) original
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:original];
    if (0 == [self.profile age].location) {
        /* skip */
    }
    else if (26 > [self.profile age].location)
    {
//        [dict setObject:[self decreaseValueOf:dict withKey:@"price"] forKey:@"price"];
//        [dict setObject:[NSValue valueWithRange:NSMakeRange(1, 1)] forKey:@"family"];
    }
    else if (36 > [self.profile age].location)
    {
//        [dict setObject:[NSValue valueWithRange:NSMakeRange(1, 1)] forKey:@"family"];
//        [dict setObject:[self increaseValueOf:dict withKey:@"design"] forKey:@"design"];
    }
    else if (46 > [self.profile age].location)
    {
        [dict setObject:[NSValue valueWithRange:NSMakeRange(1, 1)] forKey:@"eco"];
        // [dict setObject:[NSValue valueWithRange:NSMakeRange(1, 1)] forKey:@"family"];
    }
    else
    {
        [dict setObject:[self increaseValueOf:dict withKey:@"design"] forKey:@"design"];
    }
    return dict;
}

-(NSDictionary*) updateByFamilyStatus: (NSDictionary*) original
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:original];
    if ([@"alone" isEqualToString:[self.profile familyStatus]])
    {
        [dict setObject:[self increaseValueOf:dict withKey:@"design"] forKey:@"design"];
    }
    return dict;
}

-(NSDictionary*) updateByHorsepower: (NSDictionary*) original
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary: original];
    if ([self.profile horsePower] != nil)
    {
        [dict setObject:[NSValue valueWithRange: NSMakeRange((unsigned long)[self.profile horsePower], 1)] forKey:@"sport"];
    }
    return dict;
}

-(NSDictionary*) updateByDesign: (NSDictionary*) original
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:original];
    switch ([self.profile design]) {
        case 1:
            [dict setObject:[NSValue valueWithRange:NSMakeRange(4, 1)] forKey:@"sport"];
            break;
        case 2:
            [dict setObject: [NSValue valueWithRange:NSMakeRange(4, 1)] forKey:@"family"];
            break;
        case 3:
            [dict setObject: [NSValue valueWithRange:NSMakeRange(4, 1)] forKey:@"offroad"];
            break;
        case 4:
            [dict setObject: [NSValue valueWithRange:NSMakeRange(3, 1)] forKey:@"offroad"];
            break;
        case 5:
            [dict setObject:[NSValue valueWithRange:NSMakeRange(1, 1)] forKey:@"offroad"];
            [dict setObject:[NSValue valueWithRange:NSMakeRange(4, 1)] forKey:@"eco"];
            break;
        case 6:
            [dict setObject:[NSValue valueWithRange:NSMakeRange(1, 1)] forKey:@"design"];
            break;
        case 7:
            [dict setObject:[NSValue valueWithRange:NSMakeRange(1, 1)] forKey:@"price"];
            break;
        default:
            break;
    }
    return dict;
}

-(NSDictionary*) updateByPrice: (NSDictionary*) original
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:original];
    if ([self.profile priceToBuy] != nil)
    {
        [dict setObject:[NSValue valueWithRange:NSMakeRange((unsigned long)[self.profile priceToBuy], 1)] forKey:@"price"];
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
    return [NSMutableDictionary dictionaryWithObjects: @[[NSValue valueWithRange:NSMakeRange(0, 1)], [NSValue valueWithRange:NSMakeRange(0, 1)], [NSValue valueWithRange:NSMakeRange(0, 1)], [NSValue valueWithRange:NSMakeRange(0, 1)], [NSValue valueWithRange:NSMakeRange(0, 1)], [NSValue valueWithRange:NSMakeRange(0, 1)]]
                                                     forKeys: @[@"family", @"sport", @"eco", @"design", @"offroad", @"price"]];
}

@end