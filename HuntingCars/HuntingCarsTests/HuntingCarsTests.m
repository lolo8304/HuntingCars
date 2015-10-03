//
//  HuntingCarsTests.m
//  HuntingCarsTests
//
//  Created by Lorenz Hänggi on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RestApi.h"

@interface HuntingCarsTests : XCTestCase
@property (strong, nonatomic) RestApi* restApi;
@end

@implementation HuntingCarsTests

- (void)setUp {
    [super setUp];
    NSString *baseUrl = @"https://private-anon-25e20dbfa-amaghackzurich.apiary-mock.com/hackzurich";
    self.restApi = [[RestApi alloc] initWithBaseUrl: baseUrl];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    NSDictionary *fastCars = [self.restApi fetchFastCars];
    XCTAssertNotNil(fastCars);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
