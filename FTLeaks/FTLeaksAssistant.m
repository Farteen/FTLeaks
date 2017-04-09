//
//  FTLeaksAssistant.m
//  FTLeaks
//
//  Created by Glasses on 08/04/2017.
//  Copyright © 2017 organization. All rights reserved.
//

#import "FTLeaksAssistant.h"
#import "FTLeaksCenter.h"
#import "FTLeaksQueryProtocol.h"
#import <KVOController.h>

@interface FTLeaksAssistant () <FTLeaksQueryProtocol>

@property (nonatomic, strong)   NSArray *allWatchedProperties;

@end

@implementation FTLeaksAssistant

- (void)dealloc {
  for (NSString *prop in self.allWatchedProperties) {
    [self.weakOwner removeObserver:self.KVOControllerNonRetaining forKeyPath:prop];
  }
}

- (instancetype)init {
  if (self = [super init]) {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveAliveQuery:) name:FTLeaksAreYouAliveNotification object:nil];
  }
  return self;
}

- (void)didReceiveAliveQuery:(NSNotification *)noti {
  
}

/// 是否需要检查
- (BOOL)shouldCheckMe {
  return NO;
}

- (void)observeWeakOwner:(id)weakOwner watchedProperties:(NSArray *)properties {
  __weak id weakSelf = self;
  self.allWatchedProperties = [properties copy];
  for (NSString *property in properties) {
    [self.KVOControllerNonRetaining observe:weakOwner keyPath:property options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
      //      __strong id strongSelf = weakSelf;
      [weakSelf handlePropertyObserver:observer object:object change:change];
    }];
  }
}

- (void)handlePropertyObserver:(id)observer object:(id)object change:(NSDictionary *)change {
  NSLog(@"...%@",observer);
  NSLog(@"...%@",object);
  NSLog(@"...%@",change);
}

@end
