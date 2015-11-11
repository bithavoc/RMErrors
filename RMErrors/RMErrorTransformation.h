//
//  RMErrorTransformation.h
//  RideMarketplace
//
//  Created by Johan Ride on 8/25/15.
//  Copyright (c) 2015 Ride. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Implemented by error transformations
 */
@protocol RMErrorTransformation <NSObject>

/*
 Transforms one NSError into another. Depending on the implementation, either a new NSerror or the original could be returned.
 */
- (NSError *)transform:(NSError *)original;

@end
