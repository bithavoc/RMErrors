//
//  RMErrorDomains.h
//  RideMarketplace
//
//  Created by Johan Ride on 8/24/15.
//  Copyright (c) 2015 Ride. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMErrorDomainDefinition.h"
#import "RMErrorDescription.h"

/**
 Collection of Error domains known by the app
 */
@interface RMErrorDomains : NSObject

/**
 Adds definitions from Content Dictionary (RMErrors.plist) to the collection
 */
- (void)addFromContent:(NSDictionary *)content;

/**
 Adds an error domain definition to the collection
 */
- (void)add:(RMErrorDomainDefinition *)definition;

/**
 Returns all the available domain definitions
 */
@property (nonatomic, readonly) NSArray *definitions;

/**
 Describes an error
 */
- (RMErrorDescription *)describe:(NSError *)error;

@end
