//
//  FTLeaksAssistant.m
//  FTLeaks
//
//  Created by Glasses on 08/04/2017.
//  Copyright © 2017 organization. All rights reserved.
//

#import "FTObjectShadow.h"
#import "FTLeaksCenter.h"
#import "FTLeaksQueryProtocol.h"
#import <KVOController.h>

@interface FTObjectShadow () <FTLeaksQueryProtocol>

@property (nonatomic, strong)   NSArray *allWatchedProperties;

@end

@implementation FTObjectShadow

- (BOOL)shouldCheckMe {
  return NO;
}

- (void)dealloc {
  
}

- (instancetype)init {
  if (self = [super init]) {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveAliveQuery:) name:FTLeaksAreYouAliveNotification object:nil];
  }
  return self;
}

- (void)didReceiveAliveQuery:(NSNotification *)noti {
  
}


@end
