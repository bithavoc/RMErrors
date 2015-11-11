//
//  RMErrorCodeBoundary.h
//  RideMarketplace
//
//  Created by Johan Ride on 8/24/15.
//  Copyright (c) 2015 Ride. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RMErrorCodeBoundary <NSObject>

/**
 Evaluates the error code and return YES if it fits the boundary
 */
- (BOOL)matches:(NSInteger)code;

@end
