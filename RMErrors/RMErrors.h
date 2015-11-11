//
//  RMErrors.h
//  RideMarketplace
//
//  Created by Johan Ride on 8/24/15.
//  Copyright (c) 2015 Ride. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMErrorDomains.h"
#import "RMErrorDescription.h"
#import "RMErrorTransformations.h"
#import "RMErrorCodes.h"

extern NSString *const RMErrorsContentDomainsKey;
extern NSString *const RMErrorsContentDefaultKey;

@interface RMErrors : NSObject

/**
 Error Domain definitions
 */
@property (nonatomic, readonly) RMErrorDomains* domains;

/**
 A collection of transformation to run prior describing the original error.
 */
@property (nonatomic, readonly) RMErrorTransformations *transformations;

/**
 Default error description in case is not found in domains and errors.
 */
@property (nonatomic) RMErrorDescription *defaultDescription;

/**
 Load from parsed RMErrors.plist
 */
- (void)load:(NSDictionary *)content;

/**
 Process an error and returns a description
 */
- (RMErrorDescription *)describe:(NSError *)error;

@end
