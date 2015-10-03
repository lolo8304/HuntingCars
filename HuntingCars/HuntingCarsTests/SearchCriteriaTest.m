//
//  SearchCriteriaTest.m
//  HuntingCars
//
//  Created by Cédric Wider on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CustomerProfile.h"
#import "ProfileCruncher.h"

@interface SearchCriteriaTest : XCTestCase
@property (nonatomic, strong) CustomerProfile *profile;
@end

@implementation SearchCriteriaTest

- (void)setUp {
    [super setUp];
    self.profile = [[CustomerProfile alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMaleGenderModifications {
    // given
    [self.profile setGender:@"male"];
    ProfileCruncher *cruncher = [[ProfileCruncher alloc] initWithCustomerProfile:self.profile];
    
    // when
    NSDictionary *criteria = [cruncher calculateSearchCriteria];
    NSValue *sportValue = (NSValue*) [criteria objectForKey:@"sport"];
    NSValue *offroadValue = (NSValue*) [criteria objectForKey:@"offroad"];
    
    // then
    NSRange sportRange = [sportValue rangeValue];
    XCTAssertTrue(sportRange.location == 1);

    NSRange offroadRange = [offroadValue rangeValue];
    XCTAssertTrue(offroadRange.location == 1);
    
}

- (void)testFemaleGenderModifications {
    // given
    [self.profile setGender:@"female"];
    ProfileCruncher *cruncher = [[ProfileCruncher alloc] initWithCustomerProfile:self.profile];
    
    // when
    NSDictionary *criteria = [cruncher calculateSearchCriteria];
    NSValue *familyValue = (NSValue*) [criteria objectForKey:@"family"];
    NSValue *designValue = (NSValue*) [criteria objectForKey:@"design"];
    
    // then
    NSRange familyRange = [familyValue rangeValue];
    XCTAssertTrue(familyRange.location == 1);
    
    NSRange designRange = [designValue rangeValue];
    XCTAssertFalse(designRange.location == 1);
    
}

- (void)testYoungAgeModifications {
    // given
    [self.profile setAge: NSMakeRange(0, 25)];
    ProfileCruncher *cruncher = [[ProfileCruncher alloc] initWithCustomerProfile:self.profile];
    
    // when
    NSDictionary *criteria = [cruncher calculateSearchCriteria];
    NSValue *familyValue = (NSValue*) [criteria objectForKey:@"family"];
    NSValue *priceValue = (NSValue*) [criteria objectForKey:@"price"];
    
    // then
    NSRange familyRange = [familyValue rangeValue];
    XCTAssertTrue(1 == familyRange.location);
    
    NSRange priceRange = [priceValue rangeValue];
    XCTAssertTrue(-1 == priceRange.location);
}

-(void) testMediumAgeModifications {
    // given
    [self.profile setAge: NSMakeRange(26, 9)];
    ProfileCruncher *cruncher = [[ProfileCruncher alloc] initWithCustomerProfile:self.profile];
    
    // when
    NSDictionary *criteria = [cruncher calculateSearchCriteria];
    NSValue *familyValue = [criteria objectForKey:@"family"];
    NSValue *ecoValue = [criteria objectForKey:@"eco"];
    NSValue *designValue = [criteria objectForKey:@"design"];
    
    // then
    XCTAssertTrue(1 == [familyValue rangeValue].location);
    XCTAssertTrue(2 == [familyValue rangeValue].length);
    XCTAssertTrue(3 == [ecoValue rangeValue].location);
    XCTAssertTrue(2 == [ecoValue rangeValue].length);
    XCTAssertTrue(0 == [designValue rangeValue].location); //it's 0 because the age check decreases it by 1 first.
    XCTAssertTrue(1 == [designValue rangeValue].length);
}

-(void) testUpperAgeModifications {
    // given
    [self.profile setAge: NSMakeRange(36, 9)];
    ProfileCruncher *cruncher = [[ProfileCruncher alloc] initWithCustomerProfile:self.profile];
    
    // when
    NSDictionary *criteria = [cruncher calculateSearchCriteria];
    NSValue *familyValue = [criteria objectForKey:@"family"];
    NSValue *ecoValue = [criteria objectForKey:@"eco"];
    
    // then
    XCTAssertTrue(1 == [familyValue rangeValue].location);
    XCTAssertTrue(2 == [familyValue rangeValue].length);
    XCTAssertTrue(3 == [ecoValue rangeValue].location);
    XCTAssertTrue(2 == [ecoValue rangeValue].length);
}

-(void) testSeniorAgeSegmendModifications {
    // given
    [self.profile setAge: NSMakeRange(46, 9)];
    ProfileCruncher *cruncher = [[ProfileCruncher alloc] initWithCustomerProfile:self.profile];
    
    // when
    NSDictionary *criteria = [cruncher calculateSearchCriteria];
    NSValue *designValue = [criteria objectForKey:@"design"];
    
    // then
    XCTAssertTrue(0 == [designValue rangeValue].location); //it's 0 because the age check decreases it by 1 first.
    XCTAssertTrue(1 == [designValue rangeValue].length);
}

-(void) testNegativeRangeIsPossible {
    NSRange range = NSMakeRange(-1, 1);
    XCTAssertTrue(range.location == -1);
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
