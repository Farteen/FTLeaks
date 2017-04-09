//
//  NSObject+FTLeaks.m
//  FTLeaks
//
//  Created by FarTeen on 07/04/2017.
//  Copyright © 2017 organization. All rights reserved.
//

#import "NSObject+FTLeaks.h"
#import <objc/runtime.h>
#import "FTLeaksAssistant.h"
#import <Aspects.h>

static inline NSArray* allPropertiesNames(Class class) {
  unsigned count;
  objc_property_t *properties = class_copyPropertyList(class, &count);
  
  NSMutableArray *rv = [NSMutableArray array];
  
  unsigned i;
  for (i = 0; i < count; i++)
  {
    objc_property_t property = properties[i];
    NSString *name = [NSString stringWithUTF8String:property_getName(property)];
    [rv addObject:name];
  }
  
  free(properties);
  
  return rv;
}

@implementation NSObject (FTLeaks)

/// 是否需要检查
- (BOOL)shouldCheckMe {
  if ([self isSystemClass]) {
    return NO;
  }
  return YES;
}
/// 巡检的深度
- (NSInteger)checkingDepth {
  return 0;
}

/// 标记为alive
- (void)markIAmAlive {
  
}

/// 是否应该存在,YES为合理存在,NO为不合理存在,如果为NO,并且多次诊断都为NO,则认为他是一个内存泄漏
- (BOOL)shouldIAlive {
  return NO;
}

+ (void)prepareForQuery {
  
}

- (void)setLeaksAssistant:(FTLeaksAssistant *)leaksAssistant {
  objc_setAssociatedObject(self, @selector(leaksAssistant), leaksAssistant, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  leaksAssistant.weakOwner = self;
}

- (FTLeaksAssistant *)leaksAssistant {
  return objc_getAssociatedObject(self, @selector(leaksAssistant));
}

- (void)watchoutProperties {
  if ([self shouldCheckMe]) {
    NSInteger checkDepth = [self checkingDepth];
    NSMutableArray *watchedAllProperties = [NSMutableArray array];
    
    NSInteger index = 0;
    Class nextClass = [self class];
    NSString *nextClassString = NSStringFromClass(nextClass);
    
    while (nextClass && [nextClassString isEqualToString:[self checkUpToClass]]) {
      if (index < checkDepth) {
        /// 如果当前类为不是忽略的类链之一,则直接
        NSString *nextClassString = NSStringFromClass(nextClass);
        if (![[self ignoredSuperClass] containsObject:nextClassString]) {
          [watchedAllProperties addObjectsFromArray:allPropertiesNames(nextClass)];
        }
        nextClass = [nextClass superclass];
        nextClassString = NSStringFromClass(nextClass);
        index++;
      } else {
        break;
      }
    }
    NSLog(@"%@",watchedAllProperties);
  }
}

- (BOOL)isSystemClass {
  NSBundle *b = [NSBundle bundleForClass:[self class]];
  if (b == [NSBundle mainBundle]) {
    return NO;
  }
  return YES;
}

@end
