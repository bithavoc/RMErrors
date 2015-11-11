//
//  RMErrorCodeRangeBoundary.m
//  RideMarketplace
//
//  Created by Johan Ride on 8/24/15.
//  Copyright (c) 2015 Ride. All rights reserved.
//

#import "RMErrorCodeRangeBoundary.h"

NSInteger const RMErrorCodeRangeBoundaryDefaultLimit = -1;

static NSString *const RMErrorCodeRangeBoundaryPatternSeparator = @"..";

@implementation RMErrorCodeRangeBoundary

- (instancetype)init {
    return [self initWithLower:RMErrorCodeRangeBoundaryDefaultLimit andUpper:RMErrorCodeRangeBoundaryDefaultLimit];
}

- (instancetype)initWithLower:(NSInteger)lower andUpper:(NSInteger)upper {
    if(self = [super init]) {
        _lowerLimit = lower;
        _upperLimit = upper;
    }
    return self;
}

- (BOOL)matches:(NSInteger)code {
    return code >= _lowerLimit && code <= _upperLimit;
}

+ (instancetype)boundaryWithPattern:(NSString *)pattern {
    NSParameterAssert(pattern);
    NSArray *limits = [pattern componentsSeparatedByString:RMErrorCodeRangeBoundaryPatternSeparator];
    NSString *lowerText = limits.firstObject;
    NSInteger lower = RMErrorCodeRangeBoundaryDefaultLimit;
    if(lowerText.length != 0) {
        lower = lowerText.integerValue;
    }
    NSInteger upper = lower;
    NSString *upperText = limits.lastObject;
    if(upperText.length != 0) {
        upper = upperText.integerValue;
    }
    return [[RMErrorCodeRangeBoundary alloc] initWithLower:lower andUpper:upper];
}

+ (instancetype)wildcard {
    static RMErrorCodeRangeBoundary *_wildcard;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _wildcard = [[RMErrorCodeRangeBoundary alloc]initWithLower:NSIntegerMin andUpper:NSIntegerMax];
    });
    return _wildcard;
}

@end
