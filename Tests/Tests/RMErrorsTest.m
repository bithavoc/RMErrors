//
//  RMErrorsTest.m
//  RideMarketplace
//
//  Created by Johan Ride on 8/25/15.
//  Copyright (c) 2015 Ride. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RMErrors.h"
#import "RMErrorCodeRangeBoundary.h"

@interface RMErrorsTest : XCTestCase

@end

@implementation RMErrorsTest

- (void)testLoadContent {
    RMErrors *errors = [[RMErrors alloc] init];
    [errors load:@{
                   @"domains": @{
                        @"NSURLErrorDomain": @{}
                    }
                   }];
    XCTAssertEqual(errors.domains.definitions.count, 1);
}

- (void)testDescribe {
    RMErrors *errors = [[RMErrors alloc] init];
    RMErrorDomainDefinition *errorDomain = [[RMErrorDomainDefinition alloc] initWithName:@"com.foo.bar.oopsie"];
    [errorDomain.codes add:[[RMErrorCodeDefinition alloc] initWithBoundary:[RMErrorCodeRangeBoundary boundaryWithPattern:@"500..503"] friendlyMessage:@"server error" transient:YES]];
    
    [errors.domains add:errorDomain];
    
    [errorDomain.codes add:[[RMErrorCodeDefinition alloc] initWithBoundary:[RMErrorCodeRangeBoundary boundaryWithPattern:@"504..510"] friendlyMessage:@"server is gone forever" transient:NO]];
    
    [errors.domains add:errorDomain];
    
    RMErrorDescription *description = [errors describe:[NSError errorWithDomain:@"com.foo.bar.oopsie" code:500 userInfo:nil]];
    XCTAssertNotNil(description);
    XCTAssertEqualObjects(description.friendlyMessage, @"server error");
    XCTAssertTrue(description.transient);
    
    
    description = [errors describe:[NSError errorWithDomain:@"com.foo.bar.oopsie" code:507 userInfo:nil]];
    XCTAssertNotNil(description);
    XCTAssertEqualObjects(description.friendlyMessage, @"server is gone forever");
    XCTAssertFalse(description.transient);
}

@end
