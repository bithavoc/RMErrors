//
//  RMErrorCodeDefinitionTest.m
//  RideMarketplace
//
//  Created by Johan Ride on 8/25/15.
//  Copyright (c) 2015 Ride. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RMErrorCodeDefinition.h"

@interface RMErrorCodeDefinitionTest : XCTestCase<RMErrorCodeBoundary>

@end

@implementation RMErrorCodeDefinitionTest

- (BOOL)matches:(NSInteger)code {
    if(code <= 200) {
        return NO;
    }
    return YES;
}

- (void)testDefaultInitializer {
    RMErrorCodeDefinition *definition = [[RMErrorCodeDefinition alloc] initWithBoundary:self friendlyMessage:@"oops!" transient:YES];
    XCTAssertEqualObjects(definition.friendlyMessage, @"oops!");
    XCTAssertTrue(definition.transient);
    XCTAssertEqualObjects(definition.boundary, self, @"boundary should have been the same passed in initializer");
}

- (void)testDefaultWithAttributes {
    NSDictionary *attributes = @{
                                 @"friendlyMessage": @"oops!",
                                 @"transient": @(YES)
                                 };
    RMErrorCodeDefinition *definition = [[RMErrorCodeDefinition alloc] initWithBoundary:self andAttributes:attributes];
    XCTAssertEqualObjects(definition.friendlyMessage, @"oops!");
    XCTAssertTrue(definition.transient);
    XCTAssertEqualObjects(definition.boundary, self, @"boundary should have been the same passed in initializer");
}

- (void)testDescribeWithoutFriendlyMessage {
    NSDictionary *attributes = @{
                                 @"transient": @(YES)
                                 };
    RMErrorCodeDefinition *definition = [[RMErrorCodeDefinition alloc] initWithBoundary:self andAttributes:attributes];
    RMErrorDescription *errorDescription = [definition describe:300 withDefaultMessage:@"original error message"];
    XCTAssertEqualObjects(errorDescription.friendlyMessage, @"original error message", @"should have described with the original error message since no friendlyMessage was provided");
}

- (void)testDescribeWithFriendlyMessage {
    NSDictionary *attributes = @{
                                 @"friendlyMessage": @"Oops, sorry",
                                 @"transient": @(YES)
                                 };
    RMErrorCodeDefinition *definition = [[RMErrorCodeDefinition alloc] initWithBoundary:self andAttributes:attributes];
    RMErrorDescription *errorDescription = [definition describe:300 withDefaultMessage:@"original error message"];
    XCTAssertEqualObjects(errorDescription.friendlyMessage, @"Oops, sorry", @"should have described with the friendly message since it was included in the error definition");
}

@end
