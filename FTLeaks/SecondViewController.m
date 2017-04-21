//
//  SecondViewController.m
//  FTLeaks
//
//  Created by Glasses on 08/04/2017.
//  Copyright © 2017 organization. All rights reserved.
//

#import "SecondViewController.h"
#import "Testing2View.h"
#import <FBRetainCycleDetector.h>
#import <objc/runtime.h>
#import "FLEXHeapEnumerator.h"
#import "NSObject+FTLeaks.h"
#import <KVOController.h>

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  Testing2View *view = [[Testing2View alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
  view.backgroundColor = [UIColor redColor];
  [self.view addSubview:view];
  
  [self.KVOController observe:view keyPath:@"mocking" options:NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
    NSLog(@"%@",observer);
    NSLog(@"%@",object);
    NSLog(@"%@",change);
  }];
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    view.mocking = @"mocking";
  });
//
//  unsigned int classCount = 0;
//  Class *classes = objc_copyClassList(&classCount);
//  CFMutableDictionaryRef mutableCountsForClasses = CFDictionaryCreateMutable(NULL, classCount, NULL, NULL);
//  for (unsigned int i = 0; i < classCount; i++) {
////    NSLog(@"<><><><><>%@",NSStringFromClass(classes[i]));
//    CFDictionarySetValue(mutableCountsForClasses, (__bridge const void *)classes[i], (const void *)0);
//  }
//  
//  // Enumerate all objects on the heap to build the counts of instances for each class.
//  [FLEXHeapEnumerator enumerateLiveObjectsUsingBlock:^(__unsafe_unretained id object, __unsafe_unretained Class actualClass) {
//    if (!isSystemClass(actualClass)) {
//      NSUInteger instanceCount = (NSUInteger)CFDictionaryGetValue(mutableCountsForClasses, (__bridge const void *)actualClass);
//      instanceCount++;
//      CFDictionarySetValue(mutableCountsForClasses, (__bridge const void *)actualClass, (const void *)instanceCount);
//    }
//    
//  }];
//  
//  // Convert our CF primitive dictionary into a nicer mapping of class name strings to counts that we will use as the table's model.
//  NSMutableDictionary *mutableCountsForClassNames = [NSMutableDictionary dictionary];
//  NSMutableDictionary *mutableSizesForClassNames = [NSMutableDictionary dictionary];
//  for (unsigned int i = 0; i < classCount; i++) {
//    Class class = classes[i];
//    if (!isSystemClass(class)) {
//      NSUInteger instanceCount = (NSUInteger)CFDictionaryGetValue(mutableCountsForClasses, (__bridge const void *)(class));
//      NSString *className = @(class_getName(class));
//      if (instanceCount > 0) {
//        [mutableCountsForClassNames setObject:@(instanceCount) forKey:className];
//      }
//      [mutableSizesForClassNames setObject:@(class_getInstanceSize(class)) forKey:className];
//    }
//  }
//  free(classes);
  
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
