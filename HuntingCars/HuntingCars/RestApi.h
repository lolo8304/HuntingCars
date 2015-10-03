//
//  RestApi.h
//  HuntingCars
//
//  Created by Cédric Wider on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#ifndef RestApi_h
#define RestApi_h

@interface RestApi : NSObject

- (id) initWithBaseUrl: (NSString*) baseUrl;
- (NSArray*) queryServer: (NSString*) query;
-(NSDictionary*) queryForSingleObject: (NSString*) query;

@end

#endif /* RestApi_h */
