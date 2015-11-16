//
//  RMErrorCodeDefinition.h
//  RideMarketplace
//
//  Created by Johan Ride on 8/24/15.
//  Copyright (c) 2015 Ride. All rights reserved.
//

@import Foundation;
#import "RMErrorCodeBoundary.h"
#import "RMErrorDescription.h"

/**
 Describes how the app sees error code for a Domain.
 */
@interface RMErrorCodeDefinition : NSObject

/**
 Initializes the Error Code definition with a boundary, friendly message and transient indicator
 @param boundary Boundary to Match the error code
 @param friendlyMessage (optional) a text message to show in UI when error is matched
 @param transient indicates whether the error is transient or not
 */
- (instancetype)initWithBoundary:(id<RMErrorCodeBoundary>)boundary
                 friendlyMessage:(NSString *)friendlyMessage transient:(BOOL)transient NS_DESIGNATED_INITIALIZER;

/**
 Initializes the Error Code definition with boundary and attributes dictionary(RMErrors.plist)
 @param boundary Boundary to Match the error code
 @param attributes NSDictionary with attributes (See RMErrors.plist)
 */
- (instancetype)initWithBoundary:(id<RMErrorCodeBoundary>)boundary andAttributes:(NSDictionary *)attributes;

/**
 Boundary of this error code.
 See RMErrorCodeRangeBoundary.
 */
@property (nonatomic, readonly) id<RMErrorCodeBoundary> boundary;

/**
 User-Friendly message associated with the matched code boundary.
 */
@property (nonatomic, readonly) NSString *friendlyMessage;

/**
 Indicates whether the matched error code is transient. Transient errors should be retried with our without user intervention after a certain amount of time.
 */
@property (nonatomic, readonly) BOOL transient;

/**
 Indicates whether it can describe the error or not
 */
- (BOOL)canDescribe:(NSInteger)code;

/**
 Describes the given error code with a default message
 @param code error code to describe
 @param defaultMessage default known message for the error code
 */
- (RMErrorDescription *)describe:(NSInteger)code withDefaultMessage:(NSString *)defaultMessage;

@end
