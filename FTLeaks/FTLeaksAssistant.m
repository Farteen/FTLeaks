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

@interface FTLeaksAssistant () <FTLeaksQueryProtocol>

@end

@implementation FTLeaksAssistant

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

@end
