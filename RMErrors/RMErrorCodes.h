//
//  RMErrorCodes.h
//  RideMarketplace
//
//  Created by Johan Ride on 8/25/15.
//  Copyright (c) 2015 Ride. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMErrorCodeDefinition.h"
#import "RMErrorDescription.h"

/**
 Collection of error codes known from an error domain
 */
@interface RMErrorCodes : NSObject

/**
 Adds definitions from Content Dictionary (RMErrors.plist) to the collection
 */
- (void)addFromContent:(NSDictionary *)content;

/**
 Adds an error code definition to the collection
 */
- (void)add:(RMErrorCodeDefinition *)definition;

/**
 Returns all the available error definitions
 */
@property (nonatomic, readonly) NSArray *definitions;

/**
 Describes the given error code with default message. Nil will be returned if none of the code definition can describe the error.
 */
- (RMErrorDescription *)describe:(NSInteger)code withDefaultMessage:(NSString *)defaultMessage;

@end
