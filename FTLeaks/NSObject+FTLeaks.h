//
//  NSObject+FTLeaks.h
//  FTLeaks
//
//  Created by FarTeen on 07/04/2017.
//  Copyright © 2017 organization. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "FTLeaksQueryProtocol.h"
@class FTObjectShadow;

@interface NSObject (FTLeaks)<FTLeaksQueryProtocol>

@property (nonatomic, weak)   id                parentNode;

@property (nonatomic, strong) FTObjectShadow    *shadow;

- (NSArray *)classChain;

- (NSString *)nearestToSystemClassName;

- (Class)nearestToSystemClass;



@end


static inline BOOL isSystemClass(Class aClass) {
  NSBundle *b = [NSBundle bundleForClass:aClass];
  if (b == [NSBundle mainBundle]) {
    return NO;
  }
  return YES;
}

static inline NSArray *classChain(Class aClass) {
  NSArray *result = [NSArray array];
  Class nextClass = aClass;
  while (!isSystemClass(nextClass)) {
    NSString *nextClassString = NSStringFromClass(nextClass);
    result = [@[nextClassString] arrayByAddingObjectsFromArray:result];
    nextClass = [nextClass superclass];
  }
  return result;
}

static inline Class nearestToSystemClass(Class aClass) {
  NSArray *result = classChain(aClass);//[self classChain];
  if (result.count > 0) {
    return NSClassFromString([result firstObject]);
  }
  return aClass;
}

static inline NSString *nearestToSystemClassName(Class aClass) {
  return NSStringFromClass(nearestToSystemClass(aClass));
}
