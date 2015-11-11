//
//  RMErrorCodes.m
//  RideMarketplace
//
//  Created by Johan Ride on 8/25/15.
//  Copyright (c) 2015 Ride. All rights reserved.
//

#import "RMErrorCodes.h"
#import "RMErrorCodeRangeBoundary.h"

@interface RMErrorCodes()

@property (nonatomic) NSMutableArray *codes;

@end

@implementation RMErrorCodes
@dynamic definitions;

- (instancetype)init {
    return [self initWithDictionary:nil];
}

- (instancetype)initWithDictionary:(NSDictionary *)domains {
    if(self = [super init]) {
        self.codes = [NSMutableArray array];
    }
    return self;
}

- (void)addFromContent:(NSDictionary *)content {
    for (NSString *pattern in content.allKeys) {
        NSDictionary *codeAttributes = content[pattern];
        id<RMErrorCodeBoundary> boundary = [RMErrorCodeRangeBoundary boundaryWithPattern:pattern];
        RMErrorCodeDefinition *definition = [[RMErrorCodeDefinition alloc] initWithBoundary:boundary andAttributes:codeAttributes];
        [self add:definition];
    }
}

- (void)add:(RMErrorCodeDefinition *)definition {
    NSParameterAssert([definition isKindOfClass:[RMErrorCodeDefinition class]]);
    [self.codes addObject:definition];
}

- (NSArray *)definitions {
    return [self.codes copy];
}

- (RMErrorDescription *)describe:(NSInteger)code withDefaultMessage:(NSString *)defaultMessage {
    for (RMErrorCodeDefinition *definition in self.codes) {
        if([definition canDescribe:code]) {
            return [definition describe:code withDefaultMessage:defaultMessage];
        }
    }
    return nil;
}

@end
