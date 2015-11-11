//
//  RMErrorDomainDefinitionTest.m
//  RideMarketplace
//
//  Created by Johan Ride on 8/25/15.
//  Copyright (c) 2015 Ride. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RMErrorDomainDefinition.h"

@interface RMErrorDomainDefinitionTest : XCTestCase

@end

@implementation RMErrorDomainDefinitionTest

- (void)testDesignatedInitializer {
    RMErrorDomainDefinition *definition = [[RMErrorDomainDefinition alloc]initWithName:@"NSURLErrorDomain"];
    XCTAssertEqualObjects(definition.name, @"NSURLErrorDomain");
    XCTAssertNotNil(definition.codes);
}

- (void)testAttributesInitializer {
    NSDictionary *attributes = @{
                                 @"codes": @{
                                         @"500": @{}
                                         }
                                 };
    RMErrorDomainDefinition *definition = [[RMErrorDomainDefinition alloc]initWithName:@"NSURLErrorDomain"];
    [definition loadFromContent:attributes];
    XCTAssertEqualObjects(definition.name, @"NSURLErrorDomain");
    XCTAssertNotNil(definition.codes);
    XCTAssertEqual(definition.codes.definitions.count, 1);
}

- (void)testMatchNoDefaultCode {
    NSDictionary *content = @{
                                 @"codes": @{
                                         @"500": @{}
                                         }
                                 };
    RMErrorDomainDefinition *definition = [[RMErrorDomainDefinition alloc]initWithName:@"NSURLErrorDomain"];
    [definition loadFromContent:content];
    RMErrorDescription *description =[definition describe:[NSError errorWithDomain:@"NSURLErrorDomain" code:20 userInfo:nil]];
    XCTAssertNil(description, @"should have been nil since there is no default code at this error domain level");
}

- (void)testMatchWithDefaultCode {
    NSDictionary *content = @{
                              @"(default)": @{
                                      @"transient": @(YES),
                                      },
                              @"codes": @{
                                      @"500": @{}
                                      }
                              };
    RMErrorDomainDefinition *definition = [[RMErrorDomainDefinition alloc]initWithName:@"NSURLErrorDomain"];
    [definition loadFromContent:content];
    RMErrorDescription *description =[definition describe:[NSError errorWithDomain:@"NSURLErrorDomain" code:20 userInfo:@{
                                                                                                                          NSLocalizedDescriptionKey: @"original error message",
                                                                                                                          }]];
    XCTAssertNotNil(description, @"should have been an error description instance since there is a default code at this error domain level");
    XCTAssertTrue(description.transient);
    XCTAssertEqualObjects(description.friendlyMessage, @"original error message", @"should have included the original NSError message since friendlyMessage was not specified in default code for the domain");
}

- (void)testMatchWithDefaultCodeAndFriendlyMessageOverride {
    NSDictionary *content = @{
                              @"(default)": @{
                                      @"transient": @(YES),
                                      @"friendlyMessage": @"Default error message for all codes in this domain",
                                      },
                              @"codes": @{
                                      @"500": @{}
                                      }
                              };
    RMErrorDomainDefinition *definition = [[RMErrorDomainDefinition alloc]initWithName:@"NSURLErrorDomain"];
    [definition loadFromContent:content];
    RMErrorDescription *description =[definition describe:[NSError errorWithDomain:@"NSURLErrorDomain" code:20 userInfo:@{
                                                                                                                          NSLocalizedDescriptionKey: @"original error message",
                                                                                                                          }]];
    XCTAssertNotNil(description, @"should have been an error description instance since there is a default code at this error domain level");
    XCTAssertTrue(description.transient);
    XCTAssertEqualObjects(description.friendlyMessage, @"Default error message for all codes in this domain", @"should have included the overriden default message for the domain");
}
@end
