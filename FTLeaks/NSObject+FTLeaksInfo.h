//
//  NSObject+FTLeaksInfo.h
//  FTLeaks
//
//  Created by FarTeen on 07/04/2017.
//  Copyright © 2017 organization. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (FTLeaksInfo)
/// 连接数组,暂时使用数组这个结构,未来换成graph
@property (nonatomic, strong) NSArray *parentsLinks;
/// 该集合只记录所有的父节点
@property (nonatomic, strong) NSSet   *parentNodes;


@end
