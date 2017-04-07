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

@interface FTLeaksCenter : NSObject

+ (instancetype)sharedInstance;

- (void)startLeaksQuery;

- (void)configIgnoreList:(NSArray<NSString *> *)ignoreList;

@end
