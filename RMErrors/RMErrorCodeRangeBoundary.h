//
//  RMErrorCodeRangeBoundary.h
//  RideMarketplace
//
//  Created by Johan Ride on 8/24/15.
//  Copyright (c) 2015 Ride. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMErrorCodeBoundary.h"

extern NSInteger const RMErrorCodeRangeBoundaryDefaultLimit;

/**
 Boundary of error codes based on upper and lower inclusive limits
 */
@interface RMErrorCodeRangeBoundary : NSObject<RMErrorCodeBoundary>

/**
 Initializes the Boundary Ranges with lower and upper limits.
 */
- (instancetype)initWithLower:(NSInteger)lower andUpper:(NSInteger)upper NS_DESIGNATED_INITIALIZER;

/**
 Upper limit of the error code (inclusive).
 */
@property (nonatomic, readonly) NSInteger upperLimit;

/**
 Lower limit of the error codes (inclusive).
 */
@property (nonatomic, readonly) NSInteger lowerLimit;

/**
 Creates a range boundary using the given pattern.
 A pattern is an string as "500..599" or just "500" which is the same as "500..500".
 */
+ (instancetype)boundaryWithPattern:(NSString *)pattern;

/**
 Returns a range boundary that matches all the error codes
 */
+ (instancetype)wildcard;

@end
