//
//  RMErrors.m
//  RideMarketplace
//
//  Created by Johan Ride on 8/24/15.
//  Copyright (c) 2015 Ride. All rights reserved.
//

#import "RMErrors.h"

NSString *const RMErrorsContentDomainsKey = @"domains";
NSString *const RMErrorsContentDefaultKey = @"(default)";

@implementation RMErrors

- (instancetype)init {
    if(self = [super init]) {
        _domains = [[RMErrorDomains alloc] init];
        _transformations = [[RMErrorTransformations alloc] init];
    }
    return self;
}

- (void)load:(NSDictionary *)content {
    [self.domains addFromContent:content[RMErrorsContentDomainsKey]];
    NSDictionary *defaultContent = content[RMErrorsContentDefaultKey];
    if(defaultContent) {
        self.defaultDescription = [[RMErrorDescription alloc] initWithContent:defaultContent];
    }
}

- (RMErrorDescription *)describe:(NSError *)error {
    NSError *transformed = [self.transformations transform:error];
    RMErrorDescription *description = [self.domains describe:transformed];
    if(description) {
        return description;
    }
    return self.defaultDescription;
}

@end
