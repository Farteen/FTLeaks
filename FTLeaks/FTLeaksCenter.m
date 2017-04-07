//
//  FTPingCenter.m
//  FTLeaks
//
//  Created by FarTeen on 07/04/2017.
//  Copyright © 2017 organization. All rights reserved.
//

#import "FTLeaksCenter.h"

NSString *const FTLeaksAreYouAliveNotification  = @"FTLeaksAreYouAliveNotification";
NSString *const FTLeaksIAmAliveNotification     = @"FTLeaksIAmAliveNotification";

NSTimeInterval const FTLeakQueryTimeinterval = .5;

static FTLeaksCenter *__sharedPingCenter = nil;

@interface FTLeaksCenter ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation FTLeaksCenter

+ (instancetype)sharedInstance {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    __sharedPingCenter = [[[self class] alloc] init];
  });
  return __sharedPingCenter;
}

- (instancetype)init {
  if (self = [super init]) {
      dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveAlive:) name:FTLeaksIAmAliveNotification object:nil];
      });
  }
  return self;
}

- (void)startLeaksQuery {
  [self.timer fire];
}

- (NSTimer *)timer {
  if (!_timer) {
    _timer = [NSTimer timerWithTimeInterval:FTLeakQueryTimeinterval target:self selector:@selector(queryAreYouAlive:) userInfo:nil repeats:YES];
  }
  return _timer;
}

- (void)queryAreYouAlive:(NSTimer *)timer {
  dispatch_async(dispatch_get_main_queue(), ^{
    [[NSNotificationCenter defaultCenter] postNotificationName:FTLeaksAreYouAliveNotification object:nil];
  });
}

- (void)didReceiveAlive:(NSNotification *)noti {
  
}

- (void)configIgnoreList:(NSArray<NSString *> *)ignoreList {
  
}

@end
