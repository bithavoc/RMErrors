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
NSString *const RMErrorsDefaultFileName = @"RMErrors";

@implementation RMErrors
@synthesize domains = _domains;
@synthesize transformations = _transformations;
@synthesize defaultDescription = _defaultDescription;

- (instancetype)init {
    if((self = [super init])) {
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

- (nullable RMErrorDescription *)describe:(NSError *)error {
    NSError *transformed = [self.transformations transform:error];
    RMErrorDescription *description = [self.domains describe:transformed];
    if(description) {
        return description;
    }
    return self.defaultDescription;
}

- (void)loadPropertyList {
    [self loadPropertyList:RMErrorsDefaultFileName bundle:[NSBundle mainBundle]];
}

- (void)loadPropertyList:(NSString *)name bundle:(NSBundle *)bundle {
    NSString *path = [bundle pathForResource:name ofType:@"plist"];
    NSDictionary *content = [NSDictionary dictionaryWithContentsOfFile:path];
    if(!content) {
        NSString *reason = [NSString stringWithFormat:@"Unable to load %@.plist", name];
        [[NSException exceptionWithName:@"RMErrorsConfigFileException" reason:reason userInfo:nil] raise];
    }
    [self load:content];
}

@end
