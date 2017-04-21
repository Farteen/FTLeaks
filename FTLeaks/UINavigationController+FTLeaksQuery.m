//
//  UINavigationController+FTLeaksQuery.m
//  FTLeaks
//
//  Created by FarTeen on 07/04/2017.
//  Copyright © 2017 organization. All rights reserved.
//

#import "UINavigationController+FTLeaksQuery.h"
#import <Aspects.h>

@implementation UINavigationController (FTLeaksQuery)

+ (void)prepareForQuery {
  [UIView aspect_hookSelector:@selector(pushViewController:animated:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, UIViewController *vc, BOOL animated){
    
  } error:nil];
}

@end
