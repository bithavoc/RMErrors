//
//  RMErrorDescription.h
//  RideMarketplace
//
//  Created by Johan Ride on 8/25/15.
//  Copyright (c) 2015 Ride. All rights reserved.
//

@import Foundation;

extern NSString *const RMErrorDescriptionContentFriendlyMessageKey;
extern NSString *const RMErrorDescriptionContentTransientKey;
extern NSString *const RMErrorDescriptionContentCodeKey;

/**
 Description of an error that occurred in the application
 */
@interface RMErrorDescription : NSObject

/**
 Initializes the error description with the given message and transient indicator
 */
- (instancetype)initWithFriendlyMessage:(NSString *)friendlyMessage transient:(BOOL)transient code:(NSInteger)code NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithContent:(NSDictionary *)content;

/**
 Indicates whether the error is transient or not
 */
@property (nonatomic, readonly) BOOL transient;

/**
 A user friendly message to be shown to the user
 */
@property (nonatomic, readonly) NSString *friendlyMessage;

/**
 Error code
 */
@property (nonatomic, readonly) NSInteger code;

@end
