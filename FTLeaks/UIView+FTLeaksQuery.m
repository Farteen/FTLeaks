//
//  UIView+FTLeaksQuery.m
//  FTLeaks
//
//  Created by FarTeen on 07/04/2017.
//  Copyright © 2017 organization. All rights reserved.
//

#import "UIView+FTLeaksQuery.h"
#import "UIResponder+ResponderChain.h"
#import <Aspects.h>
static NSString *const FTLeaksQueryUIViewUpToClass = @"UIView";

@implementation UIView (FTLeaksQuery)

+ (void)prepareForQuery {
  [UIView aspect_hookSelector:@selector(didMoveToSuperview) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
    NSLog(@"%@",aspectInfo.instance);
    [(UIView *)aspectInfo.instance watchoutProperties];
  } error:nil];
}

/// 巡检的深度
- (NSInteger)checkingDepth {
  return 5;
}
/// 标记为alive
- (void)markIAmAlive {
  
}
/// 是否应该存在,YES为合理存在,NO为不合理存在,如果为NO,并且多次诊断都为NO,则认为他是一个内存泄漏
- (BOOL)shouldIAlive {
  return YES;
}
/// 需要诊断的子属性
- (NSArray *)propertiesToCheck {
  return nil;
}

- (BOOL)isVisible {
  if (self.window) {
    return YES;
  }
  return NO;
}

- (BOOL)isInViewStack {
  if ([self nearestNavigationController] == nil) {
    return NO;
  } else {
    return YES;
  }
}

- (NSString *)checkUpToClass {
  if ([NSStringFromClass([self class]) hasPrefix:@"UI"]) {
    return NSStringFromClass([self class]);
  }
  return FTLeaksQueryUIViewUpToClass;
}

/// 需要诊断的子属性
- (NSArray *)ignoredSuperClass {
  return nil;
}
/// 需要忽略的子属性
- (NSArray *)ignoredProperties {
  return nil;
}



@end
