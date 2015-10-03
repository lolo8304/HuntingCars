//
//  DAO.m
//  HuntingCars
//
//  Created by Cédric Wider on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface DAO : NSObject
@property (strong, nonatomic) NSDictionary *dict;
@end

@implementation DAO

-(id) initWithDictionary: (NSDictionary*) dict
{
    self = [super init];
    if (self) {
        self.dict = dict;
    }
    return self;
}

@end
