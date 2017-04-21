//
//  NSObject+FTLeaks.m
//  FTLeaks
//
//  Created by FarTeen on 07/04/2017.
//  Copyright © 2017 organization. All rights reserved.
//

#import "NSObject+FTLeaks.h"
#import <objc/runtime.h>
#import "FTObjectShadow.h"
#import "FTLeaksCenter.h"
#import <Aspects.h>
#import <KVOController.h>

static inline BOOL isStrongProperty(objc_property_t property) {
  const char* attrs = property_getAttributes(property);
  if (attrs == NULL)
    return false;
  
  const char* p = attrs;
  p = strchr(p, '&');
  if (p == NULL) {
    return false;
  } else {
    return true;
  }
}

static inline NSArray* allPropertiesNames(Class aClass) {
  unsigned count;
  objc_property_t *properties = class_copyPropertyList(aClass, &count);
  
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

static inline NSArray *allStrongPropertiesNames(Class aClass) {
  unsigned int i, count = 0;
  
  objc_property_t* properties = class_copyPropertyList(aClass, &count );
  if(count == 0) {
    free(properties);
    return nil;
  }
  
  NSMutableArray* names = @[].mutableCopy;
  
  for (i = 0; i < count; i++) {
    objc_property_t property = properties[i];
    bool isStrong = isStrongProperty(property);
    if (isStrong == false) {
      NSString *name = [NSString stringWithUTF8String:property_getName(property)];
      [names addObject:name];
    }
  }
  
  return [names copy];

}

@implementation NSObject (FTLeaks)

+ (void)prepareForQuery {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    Class class = [self class];
    
    SEL originalSelector = @selector(init);
    SEL swizzledSelector = @selector(leaks_init);
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    // When swizzling a class method, use the following:
    // Class class = object_getClass((id)self);
    // ...
    // Method originalMethod = class_getClassMethod(class, originalSelector);
    // Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
      class_replaceMethod(class,
                          swizzledSelector,
                          method_getImplementation(originalMethod),
                          method_getTypeEncoding(originalMethod));
    } else {
      method_exchangeImplementations(originalMethod, swizzledMethod);
    }
  });
}

- (instancetype)leaks_init {
  if ([self shouldCheckMe]) {
    if (![FTLeaksCenter isIgnoredClass:[self class]]) {
      FTObjectShadow *shadow = [[FTObjectShadow alloc] init];
      shadow.ownerName = NSStringFromClass([self class]);
      [[FTLeaksCenter sharedInstance] enqueueShadow:shadow];
      self.shadow = shadow;
    }
  }
  return [self leaks_init];
}

- (NSArray *)classChain {
  NSArray *result = [NSArray array];
  Class nextClass = [self class];
  while (!isSystemClass(nextClass)) {
    NSString *nextClassString = NSStringFromClass(nextClass);
    result = [@[nextClassString] arrayByAddingObjectsFromArray:result];
    nextClass = [nextClass superclass];
  }
  return result;
}

- (Class)nearestToSystemClass {
  NSArray *result = [self classChain];
  if (result.count > 0) {
    return NSClassFromString([result firstObject]);
  }
  return [self class];
}

- (NSString *)nearestToSystemClassName {
  
  return NSStringFromClass([self nearestToSystemClass]);
}

/// 是否需要检查
- (BOOL)shouldCheckMe {
  if (isSystemClass([self class])) {
    return NO;
  }
  return YES;
}
/// 巡检的深度
//- (NSInteger)checkingDepth {
//  return 0;
//}

/// 标记为alive
- (void)markIAmAlive {
  
}

/// 是否应该存在,YES为合理存在,NO为不合理存在,如果为NO,并且多次诊断都为NO,则认为他是一个内存泄漏
- (BOOL)shouldIAlive {
  return NO;
}

- (void)prepareForQuery {

}

- (void)setShadow:(FTObjectShadow *)leaksAssistant {
  objc_setAssociatedObject(self, @selector(leaksAssistant), leaksAssistant, OBJC_ASSOCIATION_ASSIGN);
  leaksAssistant.weakOwner = self;
}

- (FTObjectShadow *)leaksAssistant {
  return objc_getAssociatedObject(self, @selector(leaksAssistant));
}

/// assistant开发接受通知
/// 枚举所有属性变量
/// 对每个属性变量做监听
- (void)watchoutProperties {
  if ([self shouldCheckMe]) {
    NSMutableArray *watchedAllProperties = [NSMutableArray array];
    NSString *checkUpToClassString = [self checkUpToClass];
    
    NSInteger index = 0;
    Class nextClass = [self class];
    NSString *nextClassString = NSStringFromClass(nextClass);
    
    while (nextClass) {
      /// 如果当前类为不是忽略的类链之一,则直接
      if (![[self ignoredSuperClass] containsObject:nextClassString]) {
        [watchedAllProperties addObjectsFromArray:allPropertiesNames(nextClass)];
//        [watchedAllProperties addObjectsFromArray:allStrongPropertiesNames(nextClass)];
      }
      if ([nextClassString isEqualToString:checkUpToClassString]) {
        break;
      }
      nextClass = [nextClass superclass];
      nextClassString = NSStringFromClass(nextClass);
      index++;
    }
    
    NSArray *properties = [watchedAllProperties copy];
    /// 过滤
    properties = [self filterProperties:properties];
    /// 添加观察
      
    
  }
}

- (NSArray *)filterProperties:(NSArray *)properties {
  NSSet *ignoredProperties = [NSSet setWithArray:[self ignoredProperties]];
  NSMutableSet *allProperties = [NSMutableSet setWithArray:properties];
  [allProperties minusSet:ignoredProperties];
  NSArray *result = [allProperties allObjects];
  return result;
}



@end
