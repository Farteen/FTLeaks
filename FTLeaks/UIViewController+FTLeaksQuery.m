//
//  UIViewController+FTLeaksQuery.m
//  FTLeaks
//
//  Created by FarTeen on 07/04/2017.
//  Copyright © 2017 organization. All rights reserved.
//

#import "UIViewController+FTLeaksQuery.h"

@implementation UIViewController (FTLeaksQuery)

/// 是否需要检查
- (BOOL)shouldCheckMe {
  return YES;
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

@end
