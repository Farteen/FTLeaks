//
//  UINavigationController+FTLeaksQuery.m
//  FTLeaks
//
//  Created by FarTeen on 07/04/2017.
//  Copyright © 2017 organization. All rights reserved.
//

#import "UINavigationController+FTLeaksQuery.h"

@implementation UINavigationController (FTLeaksQuery)

+ (void)prepareForQuery {
  [UIView aspect_hookSelector:@selector(didMoveToSuperview) withOptions:AspectPositionAfter usingBlock:^{
    
  } error:nil];
}

@end