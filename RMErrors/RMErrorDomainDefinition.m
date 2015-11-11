//
//  RMErrorDomainDefinition.m
//  RideMarketplace
//
//  Created by Johan Ride on 8/24/15.
//  Copyright (c) 2015 Ride. All rights reserved.
//

#import "RMErrorDomainDefinition.h"
#import "RMErrorCodes.h"
#import "RMErrorCodeRangeBoundary.h"

static NSString *const RMErrorDomainDefinitionContentCodesKey = @"codes";
static NSString *const RMErrorDomainDefinitionContentDefaultCodeKey = @"(default)";

@implementation RMErrorDomainDefinition

- (instancetype)init {
    return [self initWithName:nil];
}

- (instancetype)initWithName:(NSString *)name {
    if(self = [super init]) {
        NSParameterAssert(name);
        _name = name;
        _codes = [[RMErrorCodes alloc] init];
    }
    return self;
}

- (void)loadFromContent:(NSDictionary *)content {
    [self.codes addFromContent:content[RMErrorDomainDefinitionContentCodesKey]];
    NSDictionary *defaultCodeContent = content[RMErrorDomainDefinitionContentDefaultCodeKey];
    if(defaultCodeContent) {
        self.defaultCode = [[RMErrorCodeDefinition alloc] initWithBoundary:[RMErrorCodeRangeBoundary wildcard] andAttributes:defaultCodeContent];
    }
}

- (BOOL)canDescribe:(NSError *)error {
    return [error.domain isEqualToString:self.name];
}

- (RMErrorDescription *)describe:(NSError *)error {
    NSInteger code = error.code;
    NSString *originalMessage = error.userInfo[NSLocalizedDescriptionKey];
    RMErrorDescription *description = [self.codes describe:code withDefaultMessage:originalMessage];
    if(description) {
        return description;
    }
    return [self.defaultCode describe:code withDefaultMessage:originalMessage];
}

@end
