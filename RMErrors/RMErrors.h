//
//  RMErrors.h
//  RideMarketplace
//
//  Created by Johan Ride on 8/24/15.
//  Copyright (c) 2015 Ride. All rights reserved.
//

@import Foundation;
#import "RMErrorDomains.h"
#import "RMErrorDescription.h"
#import "RMErrorTransformations.h"
#import "RMErrorCodes.h"

extern NSString *__nonnull const RMErrorsContentDomainsKey;
extern NSString *__nonnull const RMErrorsContentDefaultKey;
extern NSString *__nonnull const RMErrorsDefaultFileName;

@interface RMErrors : NSObject

/**
 Error Domain definitions
 */
@property (nonatomic, nonnull, readonly) RMErrorDomains* domains;

/**
 A collection of transformation to run prior describing the original error.
 */
@property (nonatomic, nonnull, readonly) RMErrorTransformations *transformations;

/**
 Default error description in case is not found in domains and errors.
 */
@property (nonatomic, nullable) RMErrorDescription *defaultDescription;

/**
 Load from parsed RMErrors.plist
 */
- (void)load:(nonnull NSDictionary *)content;

/*
 Loads from property list in the main bundle
 */
- (void)loadPropertyList;

/*
 Load the content of RMErrors with Property List
 @param name Name of the property list in the bundle. Can not be nil.
 @param bundle Bundle to load the property list from. Can not be nil.
 */
- (void)loadPropertyList:(nonnull NSString *)name bundle:(nonnull NSBundle *)bundle;

/**
 Process an error and returns a description
 */
- (nullable RMErrorDescription *)describe:(nonnull NSError *)error;

@end
