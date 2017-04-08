//
//  UIResponder+ResponderChain.m
//  FTLeaks
//
//  Created by Glasses on 08/04/2017.
//  Copyright © 2017 organization. All rights reserved.
//

#import "UIResponder+ResponderChain.h"

@implementation UIResponder (ResponderChain)

- (UIViewController *)nearestViewController {
  UIResponder *nextResponder = self;
  while (![nextResponder isKindOfClass:[UIViewController class]]) {
    nextResponder = nextResponder.nextResponder;
  }
  return (UIViewController *)nextResponder;
}

@end
