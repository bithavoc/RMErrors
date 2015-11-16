//
//  RMErrorDomainDefinition.h
//  RideMarketplace
//
//  Created by Johan Ride on 8/24/15.
//  Copyright (c) 2015 Ride. All rights reserved.
//

@import Foundation;
#import "RMErrorCodes.h"
#import "RMErrorCodeDefinition.h"

/**
 Describes how the app sees an Error Domain.
 */
@interface RMErrorDomainDefinition : NSObject

/**
 Initializes an error domain definition with the given domain name
 */
- (instancetype)initWithName:(NSString *)name NS_DESIGNATED_INITIALIZER;

/**
 Name of Error Domain
 */
@property (nonatomic, readonly) NSString *name;

/**
 Error codes definitions under this domain
 */
@property (nonatomic, readonly) RMErrorCodes *codes;

/**
 Loads content of this domain definition RMErrors.plist content
 */
- (void)loadFromContent:(NSDictionary *)content;

/**
 Indicates whether the error can be described by this domain
 */
- (BOOL)canDescribe:(NSError *)error;

/**
 Process the given error and returns a description of it
 */
- (RMErrorDescription *)describe:(NSError *)error;

/**
 Default code used when none of the codes are matched
 */
@property (nonatomic) RMErrorCodeDefinition *defaultCode;

@end
