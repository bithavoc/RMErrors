//
//  RMErrorDescription.m
//  RideMarketplace
//
//  Created by Johan Ride on 8/25/15.
//  Copyright (c) 2015 Ride. All rights reserved.
//

#import "RMErrorDescription.h"

NSString *const RMErrorDescriptionContentFriendlyMessageKey = @"friendlyMessage";
NSString *const RMErrorDescriptionContentTransientKey = @"transient";
NSString *const RMErrorDescriptionContentCodeKey = @"code";

@implementation RMErrorDescription
@synthesize transient = _transient;
@synthesize friendlyMessage = _friendlyMessage;
@synthesize code = _code;

- (instancetype)init {
    return [self initWithFriendlyMessage:nil transient:NO code:-1];
}

- (instancetype)initWithFriendlyMessage:(NSString *)friendlyMessage transient:(BOOL)transient code:(NSInteger)code {
    if((self = [super init])) {
        _friendlyMessage = friendlyMessage;
        _transient = transient;
        _code = code;
    }
    return self;
}

- (instancetype)initWithContent:(NSDictionary *)content {
    NSString *friendlyMessage = content[RMErrorDescriptionContentFriendlyMessageKey];
    NSNumber *transient = content[RMErrorDescriptionContentTransientKey];
    NSNumber *code = content[RMErrorDescriptionContentCodeKey];
    return [self initWithFriendlyMessage:friendlyMessage transient:transient.boolValue code:code.integerValue];
}

@end
