//
//  RMErrorsTransformationTest.m
//  RideMarketplace
//
//  Created by Johan Ride on 8/25/15.
//  Copyright (c) 2015 Ride. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <RMErrors/RMErrorTransformations.h>

@interface RMTestHelloErrorTransformation : NSObject<RMErrorTransformation>

@end

@implementation RMTestHelloErrorTransformation

- (NSError *)transform:(nonnull NSError *)original {
    NSString *msg = original.userInfo[@"msg"];
    if([@"hello" isEqualToString:msg]) {
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:original.userInfo];
        userInfo[@"msg"] = [original.userInfo[@"msg"] stringByAppendingString:@" world"];
        return [NSError errorWithDomain:original.domain code:original.code userInfo:userInfo];
    }
    return original;
}

@end

@interface RMTestWorldErrorTransformation : NSObject<RMErrorTransformation>

@end

@implementation RMTestWorldErrorTransformation

- (NSError *)transform:(NSError *)original {
    if(original.userInfo[@"msg"]) {
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:original.userInfo];
        userInfo[NSLocalizedDescriptionKey] = userInfo[@"msg"];
        return [NSError errorWithDomain:original.domain code:original.code userInfo:userInfo];
    }
    return original;
}

@end

@interface RMErrorsTransformationTest : XCTestCase

@end

@implementation RMErrorsTransformationTest

- (void)testTransformationOriginal {
    RMErrorTransformations *transformations = [[RMErrorTransformations alloc] init];
    [transformations add:[[RMTestHelloErrorTransformation alloc] init]];
    [transformations add:[[RMTestWorldErrorTransformation alloc] init]];
    
    NSError *original = [NSError errorWithDomain:@"com.foo.test" code:1 userInfo:@{NSLocalizedDescriptionKey: @"this is not a greeting, should be kept original"}];
    NSError *transformed = [transformations transform:original];
    XCTAssertEqualObjects(transformed.userInfo[NSLocalizedDescriptionKey], @"this is not a greeting, should be kept original");
}

- (void)testTransformationChain {
    RMErrorTransformations *transformations = [[RMErrorTransformations alloc] init];
    [transformations add:[[RMTestHelloErrorTransformation alloc] init]];
    [transformations add:[[RMTestWorldErrorTransformation alloc] init]];
    
    NSError *original = [NSError errorWithDomain:@"com.foo.test" code:1 userInfo:@{@"msg": @"hello"}];
    NSError *transformed = [transformations transform:original];
    XCTAssertEqualObjects(transformed.userInfo[NSLocalizedDescriptionKey], @"hello world");
}

@end
