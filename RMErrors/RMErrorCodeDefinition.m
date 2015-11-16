//
//  RMErrorCodeDefinition.m
//  RideMarketplace
//
//  Created by Johan Ride on 8/24/15.
//  Copyright (c) 2015 Ride. All rights reserved.
//

#import "RMErrorCodeDefinition.h"
#import "RMErrorCodeRangeBoundary.h"

static NSString *const RMErrorCodeDefinitionAttributeFriendlyMessageName= @"friendlyMessage";
static NSString *const RMErrorCodeDefinitionAttributeTransientName= @"transient";

@implementation RMErrorCodeDefinition
@synthesize boundary = _boundary;
@synthesize friendlyMessage = _friendlyMessage;
@synthesize transient = _transient;

- (instancetype)init {
    return [self initWithBoundary:nil friendlyMessage:nil transient:NO];
}

- (instancetype)initWithBoundary:(id<RMErrorCodeBoundary>)boundary
                 friendlyMessage:(NSString *)friendlyMessage transient:(BOOL)transient {
    if((self = [super init])) {
        NSParameterAssert(boundary);
        _boundary = boundary;
        _friendlyMessage = friendlyMessage;
        _transient = transient;
    }
    return self;
}

- (instancetype)initWithBoundary:(id<RMErrorCodeBoundary>)boundary andAttributes:(NSDictionary *)attributes {
    NSString *friendlyMessage = attributes[RMErrorCodeDefinitionAttributeFriendlyMessageName];
    NSNumber *transient = attributes[RMErrorCodeDefinitionAttributeTransientName];
    return [self initWithBoundary:boundary friendlyMessage:friendlyMessage transient:transient.boolValue];
}

- (BOOL)canDescribe:(NSInteger)code {
    return [self.boundary matches:code];
}

- (RMErrorDescription *)describe:(NSInteger)code withDefaultMessage:(NSString *)defaultMessage {
    NSString *msg = self.friendlyMessage;
    if(!msg) {
        msg = defaultMessage;
    }
    return [[RMErrorDescription alloc] initWithFriendlyMessage:msg transient:self.transient code:code];
}

@end
