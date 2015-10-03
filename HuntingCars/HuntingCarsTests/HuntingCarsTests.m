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
    NSString *baseUrl = @"https://private-anon-25e20dbfa-amaghackzurich.apiary-mock.com/hackzurich";
    self.restApi = [[VehicleApi alloc] initWithBaseUrl: baseUrl];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testE2EAvailability {
    NSArray *fastCars = [self.restApi fetchFastCars];
    XCTAssertNotNil(fastCars);
}

- (void)testFetchingByMultipleScores {
    // given
    NSDictionary *dict = [NSDictionary dictionaryWithObjects: @[@5, @5, @5, @5, @5] forKeys: @[@"family", @"sport", @"eco", @"design", @"offroad"]];
    
    // when
    NSArray *results = [self.restApi fetchCarsByScores:dict];
    
    // then
    XCTAssertNotNil(results);
    XCTAssertTrue([results count] > 0);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
