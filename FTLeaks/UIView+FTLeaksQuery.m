//
//  UIView+FTLeaksQuery.m
//  FTLeaks
//
//  Created by FarTeen on 07/04/2017.
//  Copyright © 2017 organization. All rights reserved.
//

#import "UIView+FTLeaksQuery.h"
#import <Aspects.h>

@implementation UIView (FTLeaksQuery)

+ (void)prepareForQuery {
  [UIView aspect_hookSelector:@selector(didMoveToSuperview) withOptions:AspectPositionAfter usingBlock:^{
    
  } error:nil];
}

@end
