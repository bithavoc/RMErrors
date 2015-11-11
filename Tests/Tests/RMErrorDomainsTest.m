//
//  RMErrorDomainsTest.m
//  RideMarketplace
//
//  Created by Johan Ride on 8/25/15.
//  Copyright (c) 2015 Ride. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <RMErrors/RMErrors.h>

@interface RMErrorDomainsTest : XCTestCase {
    NSDictionary *_content;
}

@end

@implementation RMErrorDomainsTest

- (void)setUp {
    [super setUp];
    _content = @{
                 @"NSURLErrorDomain": @{
                         @"codes": @{
                                 @"500-599": @{}
                                 }
                         }
                };
}

- (void)testAddFromContent {
    RMErrorDomains *domains = [[RMErrorDomains alloc] init];
    [domains addFromContent:_content];
    XCTAssertEqual(domains.definitions.count, 1);
    
    RMErrorDomainDefinition* definition = domains.definitions.firstObject;
    XCTAssertEqualObjects([definition class], [RMErrorDomainDefinition class]);
    XCTAssertEqualObjects(definition.name, @"NSURLErrorDomain");
    XCTAssertEqual(definition.codes.definitions.count, 1);
}

@end
