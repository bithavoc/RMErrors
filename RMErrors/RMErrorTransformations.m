//
//  RMErrorTransformations.m
//  RideMarketplace
//
//  Created by Johan Ride on 8/25/15.
//  Copyright (c) 2015 Ride. All rights reserved.
//

#import "RMErrorTransformations.h"

@interface RMErrorTransformations()

@property (nonatomic) NSMutableArray *list;

@end

@implementation RMErrorTransformations
@synthesize list;

- (instancetype)init {
    if((self = [super init])) {
        self.list = [NSMutableArray array];
    }
    return self;
}

- (void)add:(id<RMErrorTransformation>)transformation {
    NSParameterAssert(transformation);
    [self.list addObject:transformation];
}

- (NSError *)transform:(NSError *)original {
    NSError *last = original;
    for (id<RMErrorTransformation> transformation in self.list) {
        last = [transformation transform:last];
    }
    return last;
}

@end
