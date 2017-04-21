//
//  FTPingCenter.h
//  FTLeaks
//
//  Created by FarTeen on 07/04/2017.
//  Copyright © 2017 organization. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const FTLeaksAreYouAliveNotification;
extern NSString *const FTLeaksIAmAliveNotification;

@class FTObjectShadow;

@interface FTLeaksCenter : NSObject

@property (nonatomic, strong) NSSet   *shadowSet;
- (void)printAllShadows;
+ (instancetype)sharedInstance;
+ (BOOL)isIgnoredClass:(Class)aClass;
- (void)startLeaksQuery;

- (void)enqueueShadow:(FTObjectShadow *)shadow;

@end
