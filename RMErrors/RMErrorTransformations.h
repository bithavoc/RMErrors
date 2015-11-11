//
//  RMErrorTransformations.h
//  RideMarketplace
//
//  Created by Johan Ride on 8/25/15.
//  Copyright (c) 2015 Ride. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMErrorTransformation.h"

/**
 Collection of Transformations
 */
@interface RMErrorTransformations : NSObject

/**
 Adds a Transformation to the collection.
 */
- (void)add:(id<RMErrorTransformation>)transformation;

/**
 Transforms an error into a new instance, depending on the implementation the original could be returned.
 */
- (NSError *)transform:(NSError *)original;

@end
