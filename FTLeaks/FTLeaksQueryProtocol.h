//
//  FTLeaksQueryProtocol.h
//  FTLeaks
//
//  Created by FarTeen on 07/04/2017.
//  Copyright © 2017 organization. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FTLeaksQueryProtocol <NSObject>
/// 是否需要检查
- (BOOL)shouldCheckMe;

@optional
/// 巡检的深度
- (NSInteger)checkingDepth;
/// 标记为alive
- (void)markIAmAlive;
/// 是否应该存在,YES为合理存在,NO为不合理存在,如果为NO,并且多次诊断都为NO,则认为他是一个内存泄漏
- (BOOL)shouldIAlive;
/// 检测属性
- (void)watchoutProperties;
/// 需要诊断的子属性
- (NSArray *)ignoredSuperClass;
/// 需要忽略的子属性
- (NSArray *)ignoredProperties;
/// 最顶检测到的类
- (NSString *)checkUpToClass;
/// 开始查询
+ (void)prepareForQuery;

@end
