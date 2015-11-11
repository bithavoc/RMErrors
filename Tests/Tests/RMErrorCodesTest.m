//
//  RMErrorCodesTest.m
//  RideMarketplace
//
//  Created by Johan Ride on 8/25/15.
//  Copyright (c) 2015 Ride. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RMErrorCodes.h"
#import "RMErrorCodeRangeBoundary.h"

@interface RMErrorCodesTest : XCTestCase {
    NSDictionary *_content;
}

@end

@implementation RMErrorCodesTest

- (void)setUp {
    [super setUp];
    _content = @{
                 @"500-599": @{
                         @"friendlyMessage": @"server down, try again later",
                         @"transient": @(YES)
                         }
                 };
}

- (void)testAddFromContent {
    RMErrorCodes *codes = [[RMErrorCodes alloc] init];
    [codes addFromContent:_content];
    XCTAssertEqual(codes.definitions.count, 1);
    
    RMErrorCodeDefinition* definition = codes.definitions.firstObject;
    XCTAssertEqualObjects([definition class], [RMErrorCodeDefinition class]);
    XCTAssertEqualObjects(definition.boundary.class, [RMErrorCodeRangeBoundary class]);
    XCTAssertTrue(definition.transient);
    XCTAssertEqual(definition.friendlyMessage, @"server down, try again later");
}

@end
