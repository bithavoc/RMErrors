//
//  RMErrorCodeRangeBoundaryTest.m
//  RideMarketplace
//
//  Created by Johan Ride on 8/25/15.
//  Copyright (c) 2015 Ride. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RMErrorCodeRangeBoundary.h"

@interface RMErrorCodeRangeBoundaryTest : XCTestCase

@end

@implementation RMErrorCodeRangeBoundaryTest

- (void)testDefaultInitializer {
    RMErrorCodeRangeBoundary *boundary = [[RMErrorCodeRangeBoundary alloc] init];
    XCTAssertEqual(boundary.lowerLimit, RMErrorCodeRangeBoundaryDefaultLimit);
    XCTAssertEqual(boundary.upperLimit, RMErrorCodeRangeBoundaryDefaultLimit);
}

- (void)testDesignatedInitializer {
    RMErrorCodeRangeBoundary *boundary = [[RMErrorCodeRangeBoundary alloc] initWithLower:500 andUpper:599];
    XCTAssertEqual(boundary.lowerLimit, 500);
    XCTAssertEqual(boundary.upperLimit, 599);
}

- (void)testEmptyPattern {
    RMErrorCodeRangeBoundary *boundary = [RMErrorCodeRangeBoundary boundaryWithPattern:@""];
    XCTAssertEqual(boundary.lowerLimit, RMErrorCodeRangeBoundaryDefaultLimit);
    XCTAssertEqual(boundary.upperLimit, RMErrorCodeRangeBoundaryDefaultLimit);
}

- (void)testInvalidPattern {
    RMErrorCodeRangeBoundary *boundary = [RMErrorCodeRangeBoundary boundaryWithPattern:@".."];
    XCTAssertEqual(boundary.lowerLimit, RMErrorCodeRangeBoundaryDefaultLimit);
    XCTAssertEqual(boundary.upperLimit, RMErrorCodeRangeBoundaryDefaultLimit);
}

- (void)testImplicitPattern {
    RMErrorCodeRangeBoundary *boundary = [RMErrorCodeRangeBoundary boundaryWithPattern:@"404"];
    XCTAssertNotNil(boundary);
    
    XCTAssertEqual(boundary.lowerLimit, 404);
    XCTAssertEqual(boundary.upperLimit, 404);
}

- (void)testExplicitPattern {
    RMErrorCodeRangeBoundary *boundary = [RMErrorCodeRangeBoundary boundaryWithPattern:@"403..404"];
    XCTAssertNotNil(boundary);
    
    XCTAssertEqual(boundary.lowerLimit, 403);
    XCTAssertEqual(boundary.upperLimit, 404);
}

- (void)testLowerInclusiveMatching {
    RMErrorCodeRangeBoundary *boundary = [[RMErrorCodeRangeBoundary alloc] initWithLower:200 andUpper:200];
    XCTAssertTrue([boundary matches:200]);
    XCTAssertFalse([boundary matches:199]);
}

- (void)testUpperInclusiveMatching {
    RMErrorCodeRangeBoundary *boundary = [[RMErrorCodeRangeBoundary alloc] initWithLower:200 andUpper:299];
    XCTAssertTrue([boundary matches:200]);
    XCTAssertTrue([boundary matches:299]);
    XCTAssertFalse([boundary matches:300]);
}

- (void)testWildcard {
    RMErrorCodeRangeBoundary *boundary = [RMErrorCodeRangeBoundary wildcard];
    XCTAssertTrue([boundary matches:NSIntegerMin]);
    XCTAssertTrue([boundary matches:NSIntegerMax]);
}

@end
