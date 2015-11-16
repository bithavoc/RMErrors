//
//  RMErrorDomains.m
//  RideMarketplace
//
//  Created by Johan Ride on 8/24/15.
//  Copyright (c) 2015 Ride. All rights reserved.
//

#import "RMErrorDomains.h"
#import "RMErrorDomainDefinition.h"

@interface RMErrorDomains()

@property (nonatomic) NSMutableArray *domains;

@end

@implementation RMErrorDomains
@dynamic definitions;
@synthesize domains;

- (instancetype)init {
    return [self initWithDictionary:nil];
}

- (instancetype)initWithDictionary:(NSDictionary *)domains {
    if((self = [super init])) {
        self.domains = [NSMutableArray array];
    }
    return self;
}

- (void)addFromContent:(NSDictionary *)content {
    for (NSString *domain in content.allKeys) {
        NSDictionary *domainContent = content[domain];
        RMErrorDomainDefinition *definition = [[RMErrorDomainDefinition alloc] initWithName:domain];
        [definition loadFromContent:domainContent];
        [self add:definition];
    }
}

- (void)add:(RMErrorDomainDefinition *)definition {
    NSParameterAssert([definition isKindOfClass:[RMErrorDomainDefinition class]]);
    [self.domains addObject:definition];
}

- (NSArray *)definitions {
    return [self.domains copy];
}

- (RMErrorDescription *)describe:(NSError *)error {
    for (RMErrorDomainDefinition *domain in self.domains) {
        if([domain canDescribe:error]) {
            return [domain describe:error];
        }
    }
    return nil;
}

@end
