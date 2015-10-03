//
//  HuntingCarsTests.m
//  HuntingCarsTests
//
//  Created by Lorenz Hänggi on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "VehicleApi.h"

@interface HuntingCarsTests : XCTestCase
@property (strong, nonatomic) VehicleApi* restApi;
@end

@implementation HuntingCarsTests

- (void)setUp {
    [super setUp];
//    NSString *baseUrl = @"https://private-anon-25e20dbfa-amaghackzurich.apiary-mock.com/hackzurich";
    NSString *baseUrl = @"http://api.hackzurich.amag.ch/hackzurich";
    self.restApi = [[VehicleApi alloc] initWithBaseUrl: baseUrl];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFetchingByMultipleScores {
    // given
    NSDictionary *dict = [NSDictionary dictionaryWithObjects: @[[self standardValue], [self standardValue], [self standardValue], [self standardValue], [self standardValue]] forKeys: @[@"family", @"sport", @"eco", @"design", @"offroad"]];
    
    // when
    NSArray *results = [self.restApi fetchCarsByScores:dict];
    
    // then
    XCTAssertNotNil(results);
    XCTAssertTrue([results count] > 0);
}

- (void)testFetchingVehicleDetails {
    // given
    NSString *vin = @"VSSZZZ1PZ9R032038";
    
    // when
    NSDictionary *result = [self.restApi fetchDetailsByVin: vin];
    NSArray *images = [result objectForKey:@"vehicleImages"];
    
    // then
    XCTAssertNotNil(result);
    XCTAssertNotNil(images);
}

-(NSValue*) standardValue
{
    return [NSValue valueWithRange:NSMakeRange(1, 1)];
}

-(void) testRangeComparison {
    NSRange lowerRange = NSMakeRange(0, 1);
    NSRange higherRange = NSMakeRange(2, 1);
    
    XCTAssertFalse(NSEqualRanges(lowerRange, higherRange));
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
