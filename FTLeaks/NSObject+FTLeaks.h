//
//  NSObject+FTLeaks.h
//  FTLeaks
//
//  Created by FarTeen on 07/04/2017.
//  Copyright © 2017 organization. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "FTLeaksQueryProtocol.h"
@class FTLeaksAssistant;

@interface NSObject (FTLeaks)<FTLeaksQueryProtocol>

@property (nonatomic, weak)   id                parentNode;

@property (nonatomic, strong) FTLeaksAssistant  *leaksAssistant;

- (NSArray *)classChain;

- (NSString *)nearestToSystemClassName;

- (Class)nearestToSystemClass;


@end


static inline BOOL isSystemClass(Class aClass) {
  NSBundle *b = [NSBundle bundleForClass:[aClass class]];
  if (b == [NSBundle mainBundle]) {
    return NO;
  }
  return YES;
}

