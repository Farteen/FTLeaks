//
//  FTPingCenter.m
//  FTLeaks
//
//  Created by FarTeen on 07/04/2017.
//  Copyright © 2017 organization. All rights reserved.
//

#import "FTLeaksCenter.h"
#import "UIView+FTLeaksQuery.h"
#import "UINavigationController+FTLeaksQuery.h"
#import "UIViewController+FTLeaksQuery.h"
#import "NSObject+FTLeaks.h"
#import "FTObjectShadow.h"

NSString *const FTLeaksAreYouAliveNotification  = @"FTLeaksAreYouAliveNotification";
NSString *const FTLeaksIAmAliveNotification     = @"FTLeaksIAmAliveNotification";

NSTimeInterval const FTLeakQueryTimeinterval = 5.0;

static FTLeaksCenter *__sharedPingCenter = nil;
static NSTimer       *__sharedTimer      = nil;

@interface FTLeaksCenter ()

@property (nonatomic, strong) NSArray *ignoredClasses;

@property (nonatomic, strong) NSArray *ignoredPrefixs;

@end

@implementation FTLeaksCenter

+ (instancetype)sharedInstance {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    __sharedPingCenter = [[[self class] alloc] init];
  });
  return __sharedPingCenter;
}

- (void)printAllShadows {
  for (FTObjectShadow *shadow in self.shadowSet) {
    NSLog(@"----%@"/*,shadow.ownerName*/,shadow.weakOwner);
  }
}

- (instancetype)init {
  if (self = [super init]) {
    self.shadowSet = [NSSet set];
    self.ignoredClasses = @[@"AspectInfo",@"AspectTracker", @"AspectIdentifier",@"AppDelegate"];
    self.ignoredPrefixs = @[@"FLEX"];
    dispatch_async(dispatch_get_main_queue(), ^{
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveAlive:) name:FTLeaksIAmAliveNotification object:nil];
    });
  }
  return self;
}

+ (BOOL)isIgnoredClass:(Class)aClass {
  NSString *classString = NSStringFromClass(aClass);
  BOOL isIgnoredClass = [[FTLeaksCenter sharedInstance].ignoredClasses containsObject:classString];
  if (isIgnoredClass) {
    return YES;
  }
  for (NSString *classPrefix in [FTLeaksCenter sharedInstance].ignoredPrefixs) {
    if ([classString hasPrefix:classPrefix]) {
      return YES;
    }
  }
  return NO;
}

- (void)startLeaksQuery {
  [NSObject prepareForQuery];
  __sharedTimer = [NSTimer scheduledTimerWithTimeInterval:FTLeakQueryTimeinterval repeats:YES block:^(NSTimer * _Nonnull timer) {
    [self printAllShadows];
  }];
  [__sharedTimer fire];
}

- (void)didReceiveAlive:(NSNotification *)noti {
  
}

- (void)configIgnoreList:(NSArray<NSString *> *)ignoreList {
  
}

- (void)enqueueShadow:(FTObjectShadow *)shadow {
  self.shadowSet = [self.shadowSet setByAddingObject:shadow];
}

@end
